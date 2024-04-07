%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 测试代码：射频功率放大器的二项式拟合输出特性测试，输出功率限制在1W以内
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;


% 使用dbm为单位
% Pin = -10:0.2:14;
% Pout = RF_PA(Pin);
% disp(size(Pin));
% disp(size(Pout));
% plot(Pin, Pout);
% 
% title("功率放大器");
% xlabel("输入功率/dBm");
% ylabel("输出功率/dBm");

% 使用W为单位
Pin = 0.00001:0.00001:0.01;
Pout = Power_Amplify(Pin, "ADL8106", 1);
% Pin = -10:0.0001:14;
Pout = RF_PA(Pin);
RF_PA = [Pin; Pout];

disp(size(Pin));
disp(size(Pout));

figure();
plot(Pin, Pout, '-b');
% 设置坐标格
grid on;
hold on;
%title("功率放大器");
xlabel("Input power, P_{in}(W)");
ylabel("Output power, P_{out}(W)");

% i = 1;
% while i < 10
%     disp(i);
%     i = i+1;  
%     if i > 5
%         break;
%     end
% end
