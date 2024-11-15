function [xx, yy, zz] = Scan_surface_power(XRange, YRange, L, PhaseDistr, PowerDistr, Pos, lambda, G)

Ystart = YRange(1);
Yend = YRange(2);
Xstart = XRange(1);
Xend = XRange(2);
yi=0;
granularity = 0.002;
for y = Ystart :granularity: Yend
    yi = yi+1;
    xi=0;
    disp(yi);
    for x = Xstart :granularity: Xend
        xi = xi+1;
        r_pos = [x; y; L];
        [~, p_power, ~] = power_from_array(PhaseDistr, PowerDistr, Pos, r_pos, lambda, G);      % 发射阵列在特定位置的功率密度
        p_power_res(xi, yi, :) = p_power;

% %         对于斜的情况
%         if z>2.5
%             if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
%                 p_power_res(zi, yi, :) = 0;
%             end
%         end

    end
end
y = Ystart :0.01: Yend;
x = Xstart :0.01: Xend;
[xx,yy]=meshgrid(x,y); %构成格点矩阵
power_max = max(max(p_power_res'));
zz = p_power_res'./power_max;

end