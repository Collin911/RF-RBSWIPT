%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数：发射端阵列和接收端阵列进行迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 返回值分别为迭代次数、稳定后接收阵列功率、发射阵列迭代功率、接收阵列迭代功率、稳定后发射（接收）端功率分布、相位分布
function [N, P, Pp, Ppa, Pr, Po, Power_p, Power_r, Phase_p, Phase_r, Pos_p, Pos_r, Power_p_1, Phase_p_1] = ...
    ARRAY_PAIR(lambda, array_np, array_nr, array_d, Gt, R, R_x)
    %%% 分配一些内存
    %收发端的阵元位置矩阵
    p_pos = zeros(3, array_np*array_np);
    r_pos = zeros(3, array_nr*array_nr);
    %收发端的阵元功率
    p_power = zeros(1, array_np*array_np);
    r_power = zeros(1, array_nr*array_nr);
    %收发端的阵元相位
    p_phase = zeros(1, array_np*array_np);
    r_phase = zeros(1, array_nr*array_nr);


    %%% 计算发射阵列和接收阵列阵元的位置
    dp_max = (array_np-1)/2 * array_d;          %最边界的坐标
    dr_max = (array_nr-1)/2 * array_d;
    % 发射阵元坐标
    i_p = 1; i_r = 1;
    for iy = 0:array_np-1
        for ix = 0:array_np-1
            p_pos(:, i_p) = [-dp_max+ix*array_d; -dp_max+iy*array_d; 0];
            i_p = i_p + 1;
        end
    end
    % 接收阵元坐标
    for iy = 0:array_nr-1
        for ix = 0:array_nr-1
            r_pos(:, i_r) = [-dr_max+ix*array_d + R_x; -dr_max+iy*array_d; R];
            i_r = i_r + 1;
        end
    end
    
    %%% 初始化发射端的幅度（功率）和相位，默认相位相同为0，功率为设定值
    for i_r = 1:1:size(r_pos, 2)
        r_power(1, i_r) = 0;             %10mW
        r_phase(1, i_r) = exp(1j*0);           
    end
    % 初始接收端相位，接收端中心发射100mW能量，相位均为0
    if rem(array_nr, 2) == 0
        r_power(round(array_nr*array_nr/2 - array_nr/2)) = 0.1;
    else
        r_power((array_nr*array_nr - 1) / 2)= 0.1;
    end
%     disp("2. 初始化相位功率完成")
    
    %%% 进行功率循环，发射端会进行功率方法
    step = 100;             % 最大循环次数为100，中途若已经稳定则停止       

    pp = zeros(1, step);
    pr = zeros(1, step);
    ppa = zeros(1, step);
    po = zeros(1, step);
    for i = 1:step
        disp(i);

        % 1.接收端到发射端[r_phase, r_power] = Phase_Conjugate_R_to_T(p_phase, p_power, p_pos, r_pos, lambda, Gt)
        [p_phase, p_power] = power_transfer_from_array_to_array(r_phase, r_power, r_pos, p_pos, lambda, Gt);
%         disp(p_power);

        % 2.发射端进行PA方放大
        p_power_pa = abs(RF_PA(p_power));

        % 3.发射端到接收端
        [r_phase, r_power] = power_transfer_from_array_to_array(p_phase, p_power_pa, p_pos, r_pos, lambda, Gt);
        
        % 4.接收端能量分为两部分
        o_power = sum(r_power);
        r_power = r_power .* 0.0035;         % 12W 按比例返回，会导致效率先增加后减少（功率爆炸导致），或者达不到最高的效率（功率过小导致）
        
        pp(i) =(sum((p_power)));     % 接收端到发射端的能量
        ppa(i) =(sum((p_power_pa))); % 发射端PA放大后的能量
        pr(i) =(sum((r_power)));     % 接收端返回给发射端的能量，应为0.1
        po(i) =(sum((o_power)));     % 接收端输出的能量，比发射端到接收端的能量少0.1


        N = i;      % 迭代次数
        % 截至条件：两次的功率差少于0.1%
        if i > 1
            if (po(i) - po(i-1))>0 && (po(i) - po(i-1)) < (po(i-1)*0.00001)
                for j = (N+1):step
                    pp(j) = pp(N);
                    ppa(j) = ppa(N);
                    pr(j) = pr(N);
                    po(j) = po(N);
                 end
                 break;
             end
        end

        % 保存第一次的发射端能量和相位分布
        if i == 1
            Power_p_1 = p_power_pa;
            Phase_p_1 = p_phase;
        end
      
    end
    
    %%% 返回值
    P = pr(N);
    Pp = pp;
    Pr = pr;
    Ppa = ppa;
    Po = po;

    Power_p = p_power_pa;
    Power_r = r_power;
    Phase_p = p_phase;
    Phase_r = r_phase;
    Pos_p = p_pos;
    Pos_r = r_pos;

end








