%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���Դ��룺��Ƶ���ʷŴ����Ķ���ʽ���������Բ��ԣ��������������1W����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;


% ʹ��dbmΪ��λ
% Pin = -10:0.2:14;
% Pout = RF_PA(Pin);
% disp(size(Pin));
% disp(size(Pout));
% plot(Pin, Pout);
% 
% title("���ʷŴ���");
% xlabel("���빦��/dBm");
% ylabel("�������/dBm");

% ʹ��WΪ��λ
Pin = 0.00001:0.00001:0.01;
Pout = Power_Amplify(Pin, "ADL8106", 1);
% Pin = -10:0.0001:14;
Pout = RF_PA(Pin);
RF_PA = [Pin; Pout];

disp(size(Pin));
disp(size(Pout));

figure();
plot(Pin, Pout, '-b');
% ���������
grid on;
hold on;
%title("���ʷŴ���");
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
