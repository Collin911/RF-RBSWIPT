%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数：能量从一个天线阵列到另一个天线阵列的传播
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%两个公式表示空间功率和场强的关系
% P_d = P_t * G_t / 4*pi*R^2
% P_d = E^2 / η_0
% 得到 E = sqrt(30*P_t*G_t)/R
% 其中η_0为自由空间的阻抗，为120piΩ或377欧姆
function [E_recv] = field_transfer_from_array_to_array(E_init, Tx_pos, Rx_pos, lambda)
% E_init表示每个阵元的电场强度，应当是一个3x(nt*nt)的矩阵，每三行对应xyz三个方向，每一列对应一个阵元
% Tx_pos表示本次发射端每个阵元的xyz坐标， Rx_pos表示本次接收端每个阵元的xyz坐标，都是3x(nt*nt)的矩阵
% lambda表示本次发射出去的电磁波波长，是实数
% timeSeq是与E_init一致的时间序列，以秒为单位的实际时间，是1xt的数组
    
    % r_phase = zeros(1, size(Rx_pos, 2));
    % r_power = zeros(1, size(Rx_pos, 2));
    E_recv = zeros(1, size(Rx_pos, 2));
    k = 2 * pi / lambda;

    %计算相位叠加
    for r = 1:size(Rx_pos, 2)
%         disp(r);
        %，计算出距离
        R_temp = zeros(1, size(Tx_pos ,2));
        R_temp = gpuArray(R_temp);
        for p = 1:size(Tx_pos, 2)
            R_temp(p) = norm(Tx_pos(:,p) - Rx_pos(:, r));     %接收阵元与每个发射端的距离
        end
        %disp(R_temp);
        sig = 1.*exp(-1j.*R_temp.*k);         %由距离带来的相位偏移

        E_unit = E_init .* sig ./ R_temp;

        E_recv(r) = sum(sum(E_unit));
        
    end
    % disp(E_recv)
end