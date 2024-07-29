%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数：发射端阵列和接收端阵列进行迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 返回值分别为迭代次数、稳定后接收阵列功率、发射阵列迭代功率、接收阵列迭代功率、稳定后发射（接收）端功率分布、相位分布
function [iterTimes, PowerTotalItr, PowerFinalDistr, PhaseFinalDistr,... 
    Positions, PowerFirstDistr, PhaseFirstDistr, Ez_p, Ez_r, plot] = ...
    ARRAY_PAIR_v6(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, rComm, rPower)
% T is for Tx, R is for Rx
% Both BS and MT has its respective Tx and Rx
% rComm is the ratio splitted for communication
% rPower is the one for power transfer

    plot = {};    

    %%% 分配一些内存
    %收发端的阵元位置矩阵
    BS_T_pos = zeros(3, array_nt*array_nt);
    MT_R_pos = zeros(3, array_nt*array_nt);
    MT_T_pos = zeros(3, array_nr*array_nr);
    BS_R_pos = zeros(3, array_nr*array_nr);
    %收发端的阵元功率
    BS_T_power = zeros(1, array_nt*array_nt);
    MT_R_power = zeros(1, array_nt*array_nt);
    MT_T_power = zeros(1, array_nr*array_nr);
    BS_R_power = zeros(1, array_nr*array_nr);
    %收发端的阵元相位 零相位即exp(j0)=1
    BS_T_phase = zeros(1, array_nt*array_nt);
    MT_R_phase = zeros(1, array_nt*array_nt);
    MT_T_phase = zeros(1, array_nr*array_nr);
    BS_R_phase = zeros(1, array_nr*array_nr);

    % GPU feature is deprecated due to inefficiency
    % if gpuIdx ~= 0
    %     gpuDevice(gpuIdx);
    %     BS_T_pos = gpuArray(BS_T_pos);
    %     MT_T_pos = gpuArray(MT_T_pos);
    %     BS_T_power = gpuArray(BS_T_power);
    %     MT_T_power = gpuArray(MT_T_power);
    %     BS_T_phase = gpuArray(BS_T_phase);
    %     MT_T_phase = gpuArray(MT_T_phase);
    % end

    %%% 计算发射阵列和接收阵列阵元的位置
    dt_max = (array_nt-1)/2 * array_dt;          %最边界的坐标
    dr_max = (array_nr-1)/2 * array_dr;
    % 发射阵元坐标
    i_t = 1; i_r = 1;
    for iy = 0:array_nt-1
        for ix = 0:array_nt-1
            BS_T_pos(:, i_t) = [-dt_max+ix*array_dt; -dt_max+iy*array_dt; 0];
            MT_R_pos(:, i_t) = [-dt_max+ix*array_dt + R_x; -dt_max+iy*array_dt; D];
            i_t = i_t + 1;
        end
    end
    % 接收阵元坐标
    for iy = 0:array_nr-1
        for ix = 0:array_nr-1
            MT_T_pos(:, i_r) = [-dr_max+ix*array_dr + R_x; -dr_max+iy*array_dr; D];
            BS_R_pos(:, i_r) = [-dr_max+ix*array_dr; -dr_max+iy*array_dr; 0];
            i_r = i_r + 1;
        end
    end
    
    %%% 初始化基站端和相位，默认相位相同为0，功率为设定值
    for i_r = 1:1:size(MT_T_pos, 2)
        MT_T_power(i_r) = 0;             %10mW
        MT_T_phase(i_r) = exp(1j*0);           
    end
    % 初始接收端相位，接收端中心发射100mW能量，相位均为0
    if rem(array_nr, 2) == 0
        MT_T_power(round(array_nr*array_nr/2 - array_nr/2)) = 0.1;
    else
        MT_T_power((array_nr*array_nr - 1) / 2)= 0.1;
    end
%     disp("2. 初始化相位功率完成")
    
    %%% 进行功率循环，发射端会进行功率方法
    step = 1000;             % 最大循环次数为1000，中途若已经稳定则停止       

    power_BS_recv = zeros(1, step); % the power received by the BS from MT
    power_MT_emit = zeros(1, step); % the power emitted by the MT to BS
    power_BS_emit = zeros(1, step); % the power emitted by the BS to MT
    power_MT_recv = zeros(1, step); % the power received by the MT from BS

    stable_cnt = -1; % Used to control iterations after stability
    zz = [];
    for i = 1:step
        phase_noise_var = 0.3101723;
        phase_noise_var = 0.5;
        stable_cnt = stable_cnt - 1;
        disp(i);
        
        % 1.接收端到发射端[r_phase, r_power] = Phase_Conjugate_R_to_T(p_phase, p_power, p_pos, r_pos, lambda, Gt)
        [BS_R_phase, BS_R_power, Ez] = power_transfer_from_array_to_array_v2...
            (MT_T_phase, MT_T_power, MT_T_pos, BS_R_pos, lambda_r, Gt);
        % this version calls v2 of power transfer since the phase error is
        % processed hereinafter.
%         disp(p_power);
        % E_recv = field_transfer_from_array_to_array(Ez, T_pos, R_pos, lambda_t);
        
        % 2.发射端进行PA放大
        power_BS_recv(i) =(sum((BS_R_power)));     % 接收端到发射端的功率
        rReturn = 1 - rComm*10;
        BS_R_power = BS_R_power .* rReturn;
        % if lambda_t >= 0.0093 % wavelength of 32GHz
        %     PA_Type = "HMC519";
        % else
        %     PA_Type = "ADL8106";
        % end
        % BS_T_power = abs(Power_Amplify(BS_R_power, "ADL8106"));
        BS_T_power = RF_PA(BS_R_power);
        power_BS_emit(i) =(sum((BS_T_power)));  % 发射端PA放大后的功率
        
        % PLL err = 0.3101723
        % Err = (rand(1,2500)-0.5).*0.5582; % Uniform error
        Err = randn(1, array_nt*array_nt).*phase_noise_var; % normal distributed err
        
        BS_T_phase = BS_R_phase + Err; %PLL获取相位，同时具有误差

        % This is used to capture progress plot data
        plotidx = [2];
        if ismember(i, plotidx)
            [xx,yy,zz] = Scan_space_power([-0.2,0.2],[-0.1,3.1],MT_T_phase,MT_T_power,MT_T_pos,lambda_r,Gt);
            % Plot_space_power(xx,yy,zz)
            [xx,yy,zz2] = Scan_space_power([-0.2,0.2],[-0.1,3.1],BS_T_phase,BS_T_power,BS_T_pos,lambda_t,Gt);
            % Plot_space_power(xx,yy,zz2)
            filename = sprintf('./results/space_plot/r.4d3r0itr%d_5noise.mat',i);
            save(filename, "xx", "yy", "zz", "zz2")
        end

        % 3.发射端到接收端
         [MT_R_phase, MT_R_power, Er] = power_transfer_from_array_to_array_v2...
            (BS_T_phase, BS_T_power, BS_T_pos, MT_R_pos, lambda_t, Gt);
        
        % 4.接收端能量分为两部分
        power_MT_recv(i) =(sum((MT_R_power)));     % 接收端接收到的功率
        % R_power = R_power .* 0.0035;         % 12W 按比例返回，会导致效率先增加后减少（功率爆炸导致），或者达不到最高的效率（功率过小导致）
        rReturn = 1-rComm-rPower;
        MT_T_power = MT_R_power .* rReturn;
        % Do not amplify 
        % if lambda_r >= 0.0093 % wavelength of 32GHz
        %     PA_Type = "HMC519";
        % else
        %     PA_Type = "ADL8106";
        % end
        % MT_T_power = abs(Power_Amplify(MT_T_power, PA_Type));

        power_MT_emit(i) =(sum((MT_T_power)));     % 接收端返回给发射端的功率 

        % PLL err = 0.3101723
        % Err = (rand(1,2500)-0.5).*0.5951;
        Err = randn(1, array_nt*array_nt).*phase_noise_var;
        
        MT_T_phase = MT_R_phase + Err;
                 

        iterTimes = i;      % 迭代次数
        % 截至条件：两次的功率差少于1%
        if i > 1
            if (power_MT_recv(i) - power_MT_recv(i-1))>=0 &&... 
                    abs(power_MT_recv(i) - power_MT_recv(i-1)) < (power_MT_recv(i-1)*0.01)&&...
                    abs(power_BS_recv(i) - power_BS_recv(i-1)) < (power_BS_recv(i-1)*0.01)
                power_BS_recv = power_BS_recv(1:i);
                power_BS_emit = power_BS_emit(1:i);
                power_MT_emit = power_MT_emit(1:i);
                power_MT_recv = power_MT_recv(1:i); 
                 % break;
                 % instead of breaking, we use stable_cnt to control how
                 % many iterations performed after stability. 
                 if stable_cnt < 0 % Only reset counter at first stability
                    stable_cnt = 1;
                    disp('Stability Reached')
                    % This is used to capture the progress plot data in the
                    % stable condition
                    [xx,yy,zz] = Scan_space_power([-0.2,0.2],[-0.1,3.1],MT_T_phase,MT_T_power,MT_T_pos,lambda_r,Gt);
                    % Plot_space_power(xx,yy,zz)
                    [xx,yy,zz2] = Scan_space_power([-0.2,0.2],[-0.1,3.1],BS_T_phase,BS_T_power,BS_T_pos,lambda_t,Gt);
                    % Plot_space_power(xx,yy,zz2)

                    filename = sprintf('./results/space_plot/r.4d3r0itr%d_noise.mat',i);
                    save(filename, "xx", "yy", "zz", "zz2")
                 end
            end
            if (power_MT_recv(i) < power_MT_recv(i-1) * 0.8)
                disp("Insufficient Power")
                iterTimes = -1;
                break;
            end
            if power_MT_recv(i) == 0 && power_MT_recv(i-1) == 0 && power_MT_recv(i-2) == 0
                disp("No Power")
                iterTimes = -2;
                break;
            end
            if i > 200
                disp('Too Many Iterations')
                iterTimes = -3;
                break;
            end
        end
        if stable_cnt == 0
            break; 
        end

        % 保存第一次的发射端能量和相位分布
        if i == 1
            PowerFirstDistr = cat(3, BS_T_power, MT_R_power, MT_T_power, BS_R_power);
            PhaseFirstDistr = cat(3, BS_T_phase, MT_R_phase, MT_T_phase, BS_R_phase);
        end
      
    end
    
    %%% 返回值
    PowerTotalItr = cat(3, power_BS_emit, power_MT_recv, power_MT_emit, power_BS_recv);
    PowerFinalDistr = cat(3, BS_T_power, MT_R_power, MT_T_power, BS_R_power);
    PhaseFinalDistr = cat(3, BS_T_phase, MT_R_phase, MT_T_phase, BS_R_phase);
    Positions = cat(3, BS_T_pos, MT_R_pos, MT_T_pos, BS_R_pos);

    Ez_p = reshape(Ez, [array_nt, array_nt]);
    Ez_r = reshape(Er, [array_nr, array_nr]);
    % plot = {xx,yy,zz};
end








