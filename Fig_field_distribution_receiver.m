% 归一化电磁场分布
% 分析接收端处的三维能量分布

% 载入数据
clc;
clear;
load('数据345无功率限制收发端振幅相位分布.mat');


% 图1：绘制接收端x=0，z=d直线能量分布
clear yi z p_power_rwpt  p_power_bf r_pos


% 获得稳定后发射端的振幅和相位分布
Power_p = reshape(Power_p_5050(2.5*10, 1, :), 1, 2500);
Phase_p = reshape(Phase_p_5050(2.5*10, 1, :), 1, 2500);
Pos_p = Pos_p_5050;

% 绘制平面分布，xy平面，z=2.5m
xi=0; yi=0; z=2.5;
for x= -0.4:0.01:0.4
    xi = xi+1;
    yi=0;
    disp(x);
    for y= -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [x; y; z];
        [p_phase, p_power, p_E] = power_from_array(Phase_p, Power_p, Pos_p, r_pos, lambda, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(xi, yi, :) = p_power;
    end
end

x= -0.4:0.01:0.4;
y= -0.4:0.01:0.4;
[xx,yy]=meshgrid(x,y); %构成格点矩阵
power_max = max(max(p_power_res'));
rmpt_0_xx = xx;
rmpt_0_yy = yy;
rmpt_0_zz = p_power_res'./power_max;

% 获得稳定后发射端的振幅和相位分布
clear xi yi z p_power_rwpt  p_power_bf r_pos
Power_p = reshape(Power_p_1_5050(2.5*10, 1, :), 1, 2500);
Phase_p = reshape(Phase_p_1_5050(2.5*10, 1, :), 1, 2500);
Pos_p = Pos_p_5050;

% 绘制平面分布，xy平面，z=2.5m
xi=0; yi=0; z=2.5;
for x= -0.4:0.01:0.4
    xi = xi+1;
    yi=0;
    disp(x);
    for y= -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [x; y; z];
        [p_phase, p_power, p_E] = power_from_array(Phase_p, Power_p, Pos_p, r_pos, lambda, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(xi, yi, :) = p_power;
    end
end

x= -0.4:0.01:0.4;
y= -0.4:0.01:0.4;
[xx,yy]=meshgrid(x,y); %构成格点矩阵
power_max = max(max(p_power_res'));
bf_0_xx = xx;
bf_0_yy = yy;
bf_0_zz = p_power_res'./power_max;

createfigure_receiver(rmpt_0_xx, rmpt_0_yy, rmpt_0_zz, bf_0_zz);
% 第一张图：接收端在0m，2.5m位置
% set(findall(gcf, 'Type', 'line'), 'LineWidth', lineWidth);
% set(findall(gcf, 'Type', 'scatter'), 'SizeData', markerSize^2);
columnWidth = 7; % Set the desired column width in inches (e.g., 3.5 for a single-column figure or 7 for a double-column figure)
aspectRatio = 4/2; % Set the desired aspect ratio of the figure (e.g., 4/3 or 3/2)
figureWidth = columnWidth;
figureHeight = figureWidth / aspectRatio;
set(gcf, 'Units', 'inches', 'Position', [0, 0, figureWidth, figureHeight], 'PaperPositionMode', 'auto');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% set(gca,'xcolor','k');      % 默认是灰色，将其指定为黑色
% set(gca,'ycolor','k');
fileName = 'Fig_rec_dis_25m0m.pdf'; % Set the desired output file name
print(gcf, fileName, '-dpdf', '-r600', '-opengl');

