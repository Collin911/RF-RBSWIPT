% 单位为W/m^2
% 根据天线阵列的发射功率和相位，计算任意空间位置的功率情况
% 参数：阵元相位，阵元功率，阵元坐标位置，接收机坐标
% 返回：接收机相位和功率

function [r_phase, r_power, E] = power_from_array(p_phase, p_power, p_pos, r_pos, lambda, Gt)
    %，计算出距离
    for p = 1:size(p_phase, 2)
        R_temp(p) = norm(p_pos(:,p) - r_pos);     %接收阵元与每个发射端的距离
        %R_t(:,p) = (r_pos - p_pos(:,p)) / R_temp(p);
    end
    %disp(R_temp);
    sig = 1.*exp(-1j.*R_temp./lambda * 2 * pi);         %由距离带来的相位偏移
    % 计算对应的场强并叠加
    E_temp = sqrt(30.*p_power.*Gt)./R_temp;              %由发射阵列在R处的场强强度，默认天线增益为2
    %disp(E_temp);

%         d_p = ((r_pos(:,r) - p_pos)./R_temp);
%         E_temp = (E_temp.*sig.*p_phase.*((r_pos(:,r) - p_pos)./R_temp)).*Gt;
    E = (sum(((E_temp.*sig.*p_phase.*sqrt((r_pos - p_pos)./R_temp)))'));    % 考虑空间电场向量
%         E = sum((E_temp.*sig.*p_phase).*Gt);      % 未考虑空间电场向量

%     E = sum(((E_temp.*sig.*p_phase)));
%     r_phase = conj(sum(E));
    r_phase = conj(exp(1j*atan2(norm(imag(E)), norm(real(E)))));   %相位，进行了相位共轭。注意使用了atan2，以保证相位正确
    r_power = abs(norm(E))*abs(norm(E))*1/377*(1);             % 功率密度，W/m^2

    % 进行相位计算
end
%disp((sum(abs(r_power)))/(0.01*size(r_phase, 2)));

% 
% function [r_phase, r_power] = power_from_array(p_phase, p_power, p_pos, r_pos, lambda, Gt)
%     p_size = size(p_phase, 2);
%     
%     % 计算距离
%     for p = 1:p_size
%         R_temp(p) = norm(p_pos(:,p) - r_pos);
%     end
%     
%     sig = 1.*exp(1j.*R_temp./lambda * 2 * pi);         %由距离带来的相位偏移
%     % 计算对应的场强并叠加
%     E_temp = sqrt(30.*p_power.*Gt)./R_temp;              %由发射阵列在R处的场强强度，默认天线增益为2
%     
%     % 对场强进行矢量叠加
%     E = sum((E_temp.*sig.*p_phase));
%     r_phase = (exp(1j*atan2(imag(E), real(E))));       % 相位，注意使用了atan2，以保证相位正确
%     r_power = abs(E)*abs(E)*1/377*(lambda*lambda/4);   % 功率
% end
% 
% 
% 
