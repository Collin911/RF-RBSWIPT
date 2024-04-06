%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数：发射端阵列和接收端阵列进行迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 返回值分别为迭代次数、稳定后接收阵列功率、发射阵列迭代功率、接收阵列迭代功率、稳定后发射（接收）端功率分布、相位分布
function [iterTimes, PTr, PTt, PRt, PRr, Powers_p, Powers_r, Phases_p, Phases_r, ...
    Pos_p, Pos_r, Power_p_1, Phase_p_1, Ez_p, Ez_r] = ...
    ARRAY_PAIR_v3(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, gpuIdx)
% T is for Tx (BS), R is for Rx (MT)

    if(~exist('gpuIdx','var'))
        gpuIdx = 0;  % 如果未出现该变量，则默认为0
    end

    %%% 分配一些内存
    %收发端的阵元位置矩阵
    T_pos = zeros(3, array_nt*array_nt);
    R_pos = zeros(3, array_nr*array_nr);
    %收发端的阵元功率
    T_power = zeros(1, array_nt*array_nt);
    R_power = zeros(1, array_nr*array_nr);
    %收发端的阵元相位
    T_phase = zeros(1, array_nt*array_nt);
    R_phase = zeros(1, array_nr*array_nr);

    if gpuIdx ~= 0
        gpuDevice(gpuIdx);
        T_pos = gpuArray(T_pos);
        R_pos = gpuArray(R_pos);
        T_power = gpuArray(T_power);
        R_power = gpuArray(R_power);
        T_phase = gpuArray(T_phase);
        R_phase = gpuArray(R_phase);
    end

    %%% 计算发射阵列和接收阵列阵元的位置
    dt_max = (array_nt-1)/2 * array_dt;          %最边界的坐标
    dr_max = (array_nr-1)/2 * array_dr;
    % 发射阵元坐标
    i_t = 1; i_r = 1;
    for iy = 0:array_nt-1
        for ix = 0:array_nt-1
            T_pos(:, i_t) = [-dt_max+ix*array_dt; -dt_max+iy*array_dt; 0];
            i_t = i_t + 1;
        end
    end
    % 接收阵元坐标
    for iy = 0:array_nr-1
        for ix = 0:array_nr-1
            R_pos(:, i_r) = [-dr_max+ix*array_dr + R_x; -dr_max+iy*array_dr; D];
            i_r = i_r + 1;
        end
    end
    
    %%% 初始化发射端的幅度（功率）和相位，默认相位相同为0，功率为设定值
    for i_r = 1:1:size(R_pos, 2)
        R_power(i_r) = 0;             %10mW
        R_phase(i_r) = exp(1j*0);           
    end
    % 初始接收端相位，接收端中心发射100mW能量，相位均为0
    if rem(array_nr, 2) == 0
        R_power(round(array_nr*array_nr/2 - array_nr/2)) = 0.1;
    else
        R_power((array_nr*array_nr - 1) / 2)= 0.1;
    end
%     disp("2. 初始化相位功率完成")
    
    %%% 进行功率循环，发射端会进行功率方法
    step = 1000;             % 最大循环次数为1000，中途若已经稳定则停止       

    power_T_recv = zeros(1, step); % the power received by the BS from MT
    power_R_emit = zeros(1, step); % the power emitted by the MT to BS
    power_T_emit = zeros(1, step); % the power emitted by the BS to MT
    power_R_recv = zeros(1, step); % the power received by the MT from BS
    for i = 1:step
        disp(i);

        % 1.接收端到发射端[r_phase, r_power] = Phase_Conjugate_R_to_T(p_phase, p_power, p_pos, r_pos, lambda, Gt)
        [T_phase, T_power, Ez] = power_transfer_from_array_to_array_v3...
            (R_phase, R_power, R_pos, T_pos, lambda_r, Gt, 0.035779);
%         disp(p_power);
        % E_recv = field_transfer_from_array_to_array(Ez, T_pos, R_pos, lambda_t);

        % 2.发射端进行PA方放大
        power_T_recv(i) =(sum((T_power)));     % 接收端到发射端的功率
        T_power = T_power .* 0.025;
        power_T_pa = abs(Power_Amplify(T_power, "HMC519"));
        power_T_emit(i) =(sum((power_T_pa)));  % 发射端PA放大后的功率

        % 3.发射端到接收端
        [R_phase, R_power, Er] = power_transfer_from_array_to_array_v3...
            (T_phase, power_T_pa, T_pos, R_pos, lambda_t, Gt, 0.6026);
        
        % 4.接收端能量分为两部分
        power_R_recv(i) =(sum((R_power)));     % 接收端接收到的功率
        % R_power = R_power .* 0.0035;         % 12W 按比例返回，会导致效率先增加后减少（功率爆炸导致），或者达不到最高的效率（功率过小导致）
        R_power = R_power .* 0.025;
        R_power = abs(Power_Amplify(R_power, "ADL8106"));
        power_R_emit(i) =(sum((R_power)));     % 接收端返回给发射端的功率 
                 

        iterTimes = i;      % 迭代次数
        % 截至条件：两次的功率差少于1%
        if i > 1
            if (power_R_recv(i) - power_R_recv(i-1))>=0 && (power_R_recv(i) - power_R_recv(i-1)) < (power_R_recv(i-1)*0.005)
                power_T_recv = power_T_recv(1:i);
                power_T_emit = power_T_emit(1:i);
                power_R_emit = power_R_emit(1:i);
                power_R_recv = power_R_recv(1:i); 
                 break;
            end
            if power_R_recv(i) == 0 && power_R_recv(i-1) == 0 && power_R_recv(i-2) == 0
                disp("No Power")
                break;
            end
        end

        % 保存第一次的发射端能量和相位分布
        if i == 1
            Power_p_1 = power_T_pa;
            Phase_p_1 = T_phase;
        end
      
    end
    
    %%% 返回值
    PTr = power_T_recv;
    PRt = power_R_emit;
    PTt = power_T_emit;
    PRr = power_R_recv;

    Powers_p = power_T_pa;
    Powers_r = R_power;
    Phases_p = T_phase;
    Phases_r = R_phase;
    Pos_p = T_pos;
    Pos_r = R_pos;

    Ez_p = reshape(Ez, [array_nt, array_nt]);
    Ez_r = reshape(Er, [array_nr, array_nr]);
end








