function [xx, yy, zz] = Scan_space_power(VRange, HRange, PhaseDistr, PowerDistr, Pos, lambda, G)

Hstart = HRange(1);
Hend = HRange(2);
Vstart = VRange(1);
Vend = VRange(2);
zi=0;
for z = Hstart :0.01: Hend
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = Vstart :0.01: Vend
        yi = yi+1;
        r_pos = [y; 0; z];
        [~, p_power, ~] = power_from_array(PhaseDistr, PowerDistr, Pos, r_pos, lambda, G);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

% %         对于斜的情况
%         if z>2.5
%             if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
%                 p_power_res(zi, yi, :) = 0;
%             end
%         end

    end
end
z = Hstart :0.01: Hend;
y = Vstart :0.01: Vend;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
zz = p_power_res'./power_max;

end