%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数：能量从一个天线阵列到另一个天线阵列的传播
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%两个公式表示空间功率和场强的关系
% P_d = P_t * G_t / 4*pi*R^2
% P_d = E^2 / η_0
% 得到 E = sqrt(30*P_t*G_t)/R
% 其中η_0为自由空间的阻抗，为120piΩ或377欧姆
function [r_phase, r_power, Ez_phasor] = power_transfer_from_array_to_array_v3(p_phase, p_power, p_pos, r_pos, lambda, Gt, phiErr)
% 以实际发射出来的电磁波波长为准，即从哪边发射，就用哪边的波长
% phiErr为最大的弧度相位误差
    if(~exist('phiErr','var'))
        phiErr = 0;  % 如果未出现该变量，则对其进行赋值
    end
    r_phase = zeros(1, size(r_pos, 2));
    r_power = zeros(1, size(r_pos, 2));
    Ez_phasor = zeros(1, size(r_pos, 2));

    %计算相位叠加
    for r = 1:size(r_pos, 2)
%         disp(r);
        %，计算出距离
        R_temp = zeros(1, size(p_phase ,2));
%         R_temp = gpuArray(R_temp);
        for p = 1:size(p_pos, 2)
            R_temp(p) = norm(p_pos(:,p) - r_pos(:, r));     %接收阵元与每个发射端的距离
        end
        %disp(R_temp);

        Err = (rand-0.5)*2*phiErr;
        sig = 1.*exp(-1j.*(R_temp./lambda * 2 * pi+Err));         %由距离带来的相位偏移        
        
        % 计算对应的场强并叠加
        E_temp = sqrt(30.*p_power.*Gt)./R_temp;             %由发射阵列在R处的场强强度，默认天线增益为2

        E_unit = E_temp .* sig .* p_phase;

        % 根据电场计算相位和能量
        E = sum(((E_unit.*((r_pos(:,r) - p_pos)./R_temp)))');    % 考虑空间电场向量，其实在这里的方向已经考虑了共轭了
        
        Ex = E(1);
        Ey = E(2);
        Ez = E(3);

        r_phase(r) = ((sum(Ez))/norm(sum(Ez)));      % 使用该相位共轭，只迭代一次，可以看出方向聚焦
        
        S_recv = Gt.*lambda.*lambda./(4*pi);
        
        r_power(r) = abs(norm(Ez))*abs(norm(Ez))*1/(120*pi)*S_recv; 
        Ez_phasor(r) = Ez;
        
    end
end