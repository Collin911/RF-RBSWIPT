%% SNR vs Distance
clear all

pow_down = [];
pow_up = [];
pow_down_n = [];
pow_up_n = [];

R_x = 0;
Ds = [1:0.2:5];

k = 1.380649e-23;
T = 295;
B = 1e9;
Fd = db2pow(35);
Pnd = k*T*B*Fd; % Use this to calculate SNR
Fu = db2pow(25);
Pnu = k*T*B*Fu; % Use this to calculate SNR

% Pnoise = 0.001; % Use this to show the recv power in dBm
gamma = 0.004/2500;
% Precv = [1.5557e-04 0.0042 0.0119];
% SNR = Precv ./ Pnoise;
% SNRdB = pow2db(SNR);

for D = Ds
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    pow_down = [pow_down PMr1(end)];
    pow_up = [pow_up PBr1(end)];
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)    
    PBr1 =  PBr1(find(~isnan(PBr1)));
    PBr2 =  PBr2(find(~isnan(PBr2)));
    PBr3 =  PBr3(find(~isnan(PBr3)));
    PMr1 =  PMr1(find(~isnan(PMr1)));
    PMr2 =  PMr2(find(~isnan(PMr2)));
    PMr3 =  PMr3(find(~isnan(PMr3)));
    p_down = mean([PMr1(end), PMr2(end), PMr3(end)]);
    p_up = mean([PBr1(end), PBr2(end), PBr3(end)]);
    pow_down_n = [pow_down_n p_down];
    pow_up_n = [pow_up_n p_up];
end
Psigd = pow_down.*gamma;
Psigu = pow_up.*gamma.*10;
Psigdn = pow_down_n.*gamma;
Psigun = pow_up_n.*gamma.*10;
SNRd = pow2db(Psigd./(Pnd));
SNRu = pow2db(Psigu./(Pnu));
SNRdn = pow2db(Psigdn./(Pnd));
SNRun = pow2db(Psigun./(Pnu));

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 2.5 7 4])
axis on
box on
grid on
xlim([1 5]);
set(gca,'position',[0.085, 0.11, 0.82, 0.87])

% xline(4.25, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6.5, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(9, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
    % ,'HandleVisibility','off'); % No need for legend

yyaxis left
% ylim([12 28])

% plot(Ds, SNRu, 'LineStyle',':','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
powu = plot(Ds, SNRun, 'LineStyle','-','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds, SNRd, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
powd = plot(Ds, SNRdn, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% 
% % plot(Ds50, SNR50u, 'LineStyle',':','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% p50u = plot(Ds50, SNR50un, 'LineStyle','-','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% % % plot(Ds50, SNR50d, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% p50d = plot(Ds50, SNR50dn, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% 
% % plot(Ds80, SNR80u, 'LineStyle',':','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% p80u = plot(Ds80, SNR80un, 'LineStyle','-','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% % % plot(Ds80, SNR80d, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% p80d = plot(Ds80, SNR80dn, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);

xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('SNR (dB)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)


yyaxis right

% c35u = plot(Ds35, Cal_spectral_efficiency(SNR35un,3,4.8), ...
%     'LineStyle',':','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
% c35d = plot(Ds35, Cal_spectral_efficiency(SNR35dn,3,4.8), ...
%     'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
% 
% c50u = plot(Ds50, Cal_spectral_efficiency(SNR50un,3,4.8), ...
%     'LineStyle',':','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% c50d = plot(Ds50, Cal_spectral_efficiency(SNR50dn,3,4.8), ...
%     'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);

capu = plot(Ds, Cal_spectral_efficiency(SNRun,3,4.8), ...
    'LineStyle','-','Marker', '^','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
capd = plot(Ds, Cal_spectral_efficiency(SNRdn,3,4.8), ...
    'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
ylim([2 5])
ylabel('Spectral Efficiency (bps/Hz)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)


% legend([p35u, p35d], '$\alpha = 3.5\%$, up', '$\alpha = 3.5\%$, down', ...
%     'interpreter', 'latex', 'FontName', 'Times New Roman', ...
%     'FontSize', 14, 'Location', 'Northwest')
% legend boxoff;
% ah=axes('position',get(gca,'position'), 'visible','off');
% legend(ah, [p50u, p50d], '$\alpha = 5.0\%$, up', '$\alpha = 5.0\%$, down', ...
%     'interpreter', 'latex', 'FontName', 'Times New Roman', ...
%     'FontSize', 14, 'Location', 'North')
% legend boxoff;
% ah=axes('position',get(gca,'position'), 'visible','off');
% legend(ah, [p80u, p80d], '$\alpha = 8.0\%$, up', '$\alpha = 8.0\%$, down', ...
%     'interpreter', 'latex', 'FontName', 'Times New Roman', ...
%     'FontSize', 14, 'Location', 'Northeast')
% legend boxoff;

annotation("arrow", [0.31 0.26], [0.75 0.75], 'LineWidth',1.5)
rectangle('Position',[2.1, 3.9, 0.3, 0.7],'Curvature',[0.5 0.5],'edgecolor','k','linewidth',1.5);
annotation("arrow", [0.78 0.83], [0.84 0.84], 'LineWidth',1.5)
rectangle('Position',[4.1, 4.2, 0.3, 0.7],'Curvature',[0.5 0.5],'edgecolor','k','linewidth',1.5);


ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah, [powu, powd], 'SNR Uplink', 'SNR Downlink', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 14, 'Location', 'Southwest')
legend boxoff;
ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah, [capu, capd], 'SE Uplink', 'SE Downlink', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 14, 'Location', 'South')
legend boxoff;



%% BER vs Distance
% !!! Run this section after the previous one
% This section do NOT load data on its own.

% close all;
Ks = [6 7 8 9];                %莱斯分布的增益
M=4;                        %MPSK
k=log2(M);                  %每符号的比特数
N_sym=10;                   %分块处理，每个块含有的符号数
N_bit=k*N_sym;              %总共要处理的符号数
N_block=200000;              %块的数目
Es=1;                       %将每个符号的能量归一化    
Eb=Es/k;                    %计算每比特的能量   
Eb_N0_dB=SNRun;           %初始化信噪比
% EbN0=SNR*Bandwidth/Rate, 3dB-> 2*Bandwidth = Rate
Eb_N0=10.^(Eb_N0_dB/10);
N0=Eb./Eb_N0;               %计算噪声功率谱密度
len_EbN0=length(Eb_N0);

figure 
set(gcf, 'unit', 'inch', 'position', [3 2.5 7 4])
Num_BER = {};
for K_rice_dB = Ks
    K_rice=10^(K_rice_dB/10);
    EbN0_pointer=1;
    temp_EbN0_pointer=EbN0_pointer;
    errs=zeros(1,len_EbN0);     %错误码元数目初始化
    block_count=zeros(1,len_EbN0);
    while (EbN0_pointer <= len_EbN0) && (block_count(len_EbN0) < N_block)
        B=round(rand(1,N_bit)); %产生随机二进制序列
        Dm=reshape(B,k,N_sym);  %矩阵转置
        D = Dm(1,:)+1i*Dm(2,:); %产生两路独立的二进制信号.
        Tx_data = sqrt(Eb) * (2*D-(1+1i));                      %发射双极性不归零二进制信号
        Noise=sqrt(0.5)*(randn(1, N_sym)+1i*randn(1, N_sym));   %高斯噪声
        h_ray=sqrt(0.5)*(randn(1,1)+1i*randn(1,1));             %瑞利衰落分布信道
        h_rice=(sqrt(K_rice)+h_ray)/sqrt(1+K_rice);             %莱斯衰落分布信道，这里要做归一化
        for n = EbN0_pointer : len_EbN0
            Rx_data = h_rice*Tx_data + sqrt(N0(n))*Noise;       %接收端信号
            y=Rx_data/h_rice;                                   %信道增益
            Recov_Tx_data= sqrt(Eb)*(sign(real(y))+1i*sign(imag(y)));
            Recov_D = 0.5*(1+1i+Recov_Tx_data/sqrt(Eb));
            errs(n)= errs(n)+sum(abs(Recov_D-D).^2);            %计算错误比特数
            if errs(n)>=1000
                temp_EbN0_pointer = temp_EbN0_pointer+1;
            end
            block_count(n)=block_count(n)+1;                    %进入下一块循环
        end
        EbN0_pointer=temp_EbN0_pointer;
        block_count
    end
    Num_BER = [Num_BER, errs./(N_bit*block_count)];                        %数值模拟误码率
    % N_block = N_block * 1.5;
end


semilogy(Ds, cell2mat(Num_BER(1)),'LineWidth',2,'Marker', 'square','MarkerSize',4);                              %做出误码率曲线
hold on;
semilogy(Ds, cell2mat(Num_BER(2)),'LineWidth',2,'Marker', 'square','MarkerSize',4); 
semilogy(Ds, cell2mat(Num_BER(3)),'LineWidth',2,'Marker', 'square','MarkerSize',4); 
semilogy(Ds, cell2mat(Num_BER(4)),'LineWidth',2,'Marker', 'square','MarkerSize',4); 

% Ana_BER=0.5*(1-sqrt(Eb_N0./(1+Eb_N0)));                     %理论误码率
% semilogy(Eb_N0_dB, Ana_BER,'LineWidth',2);
grid on;

% xlim([1 9.5]);
set(gca,'position',[0.089, 0.11, 0.89, 0.86])

% Rician_legend=['Rician fading (K= ',num2str(K_rice_dB),' dB)'];
% legend(Rician_legend, 'Rayleigh fading');
% title('QPSK in Ricean Fading Channels');
legend('$K=6$', '$K=7$', '$K=8$', '$K=9$', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 14, 'Location', 'Southwest')
xlabel('Distance (m)','interpreter', 'latex', 'FontName', 'Times New Roman','FontSize', 16);
ylabel('Uplink BER','interpreter', 'latex', 'FontName', 'Times New Roman','FontSize', 16);
yline(3.8e-3, 'LineStyle',':','LineWidth',2,'HandleVisibility','off'); % No need for legend

note = 'HD-FEC Threshold @ $3.8\times10^{-3}$';
text(3,2e-3,note,'HorizontalAlignment','right', ...
    'Interpreter','Latex', 'Fontname', 'Times New Roman', ...
    'Fontsize', 14);

