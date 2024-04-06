clc;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF-RBS：空间传输效率Vs.迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------------------------------
%   参数设置
%--------------------------------------------------------------------------
c = 299792458;                                                              %光速
ft = 28e9;                                                                  %发射端频率,30GHz
fr = 32e9;                                                                  %接收端频率,50GHz
lambda_t = c/ft;                                                            %发射端波长
lambda_r = c/fr;                                                            %接收端波长
D = 3;                                                                      %正对距离
R_x = 0;                                                                    %偏移距离
array_nt = 50;                                                              %天线发射阵元边长
array_nr = 50;                                                              %天线接收阵元边长
array_dt = lambda_t/2;                                                      %阵元间距离,默认半波长
array_dr = lambda_r/2;                                                      %阵元间距离,默认半波长
Gt = pi;                                                                    %天线的增益，为最大功率与理想点功率的比值，相当于3dm
rComm = 0.0065;
rPower = 0.99;                                                             %功率返回比例

% 分析1：迭代优化，阵列数量40*40，距离
% Benchmark Testing
% [N, P, Pp, Ppa, Pr, Po, Power_p, Power_r, Phase_p, Phase_r, Pos_p, Pos_r, Power_p_1, Phase_p_1] = ...
%     ARRAY_PAIR(lambda_t, array_nt, array_nr, array_dt, Gt, D, R_x);
for D = [1:0.2:10]
    D
    % This is the benchmark tesing do NOT uncomment unless needed
    % [N, P, Pp, Ppa, Pr, Po, Power_p, Power_r, Phase_p, Phase_r, Pos_p, Pos_r, Power_p_1, Phase_p_1] = ...
    %      ARRAY_PAIR(lambda_t, array_nt, array_nr, array_dt, Gt, D, R_x);
    [iterTimes1, PowerTotalItr1, PowerFinalDistr1, PhaseFinalDistr1,Positions1, PowerFirstDistr1, PhaseFirstDistr1, Ez_p1, Ez_r1, ~] = ...
        ARRAY_PAIR_v6(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, rComm, rPower);
    [PBt1,PMr1,PMt1,PBr1] = Parse_compact_return(PowerTotalItr1);
    eta_down1= PMr1./PBt1;        % 下行链路效率
    eta_up1 = PBr1./PMt1;
    Precv = PMr1 - PMt1;
    filename = sprintf('./results/dist%.1fshift%.1f.mat',D,R_x);
    save(filename)

    [iterTimes1, PowerTotalItr1, PowerFinalDistr1, PhaseFinalDistr1,Positions1, PowerFirstDistr1, PhaseFirstDistr1, Ez_p1, Ez_r1, ~] = ...
        ARRAY_PAIR_v6(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, rComm, rPower);
    [iterTimes2, PowerTotalItr2, PowerFinalDistr2, PhaseFinalDistr2,Positions2, PowerFirstDistr2, PhaseFirstDistr2, Ez_p2, Ez_r2, ~] = ...
        ARRAY_PAIR_v6(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, rComm, rPower);
    [iterTimes3, PowerTotalItr3, PowerFinalDistr3, PhaseFinalDistr3,Positions3, PowerFirstDistr3, PhaseFirstDistr3, Ez_p3, Ez_r3, ~] = ...
        ARRAY_PAIR_v6(lambda_t, lambda_r, array_nt, array_nr, array_dt, array_dr, Gt, D, R_x, rComm, rPower);
    
    [PBt1,PMr1,PMt1,PBr1] = Parse_compact_return(PowerTotalItr1);
    [PBt2,PMr2,PMt2,PBr2] = Parse_compact_return(PowerTotalItr2);
    [PBt3,PMr3,PMt3,PBr3] = Parse_compact_return(PowerTotalItr3);

    eta_down1= PMr1./PBt1;        % 下行链路效率
    eta_up1 = PBr1./PMt1;
    eta_down2= PMr2./PBt2;        % 下行链路效率
    eta_up2 = PBr2./PMt2;
    eta_down3= PMr3./PBt3;        % 下行链路效率
    eta_up3 = PBr3./PMt3;
    filename = sprintf('./results/dist%.1fshift%.1f_noisy.mat',D,R_x);
    save(filename)
end


% figure();
% hold on;
% plot(eta_down);
% plot(eta_up);
% title("Transfer Efficiency","FontName","Times New Roman")
% 
% figure();
% semilogy(eta_down);
% hold on;
% semilogy(eta_up)
% ylim([0.1 1]);
% yticks([0.1 0.5 1]);
% title("Transfer Efficiency","FontName","Times New Roman")
% 
% figure;
% hold on
% plot(PBt);
% plot(PMr);
% title("Downlink Power","FontName","Times New Roman")
% 
% figure;
% hold on
% plot(PMt);
% plot(PBr);
% title("Uplink Power","FontName","Times New Roman")
