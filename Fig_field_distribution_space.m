% 归一化电磁场分布
% 分析接收端在不同位置时候的分布

% 载入数据
% clc;
% clear;
[Powers_Bt, Powers_Mr, Powers_Mt, Powers_Br] = Parse_compact_return(PowerFinalDistr);
[Phases_Bt, Phases_Mr, Phases_Mt, Phases_Br] = Parse_compact_return(PhaseFinalDistr);
[Powers_Bt_1, Powers_Mr_1, Powers_Mt_1, Powers_Br_1] = Parse_compact_return(PowerFirstDistr);
[Phases_Bt_1, Phases_Mr_1, Phases_Mt_1, Phases_Br_1] = Parse_compact_return(PhaseFirstDistr);
[Pos_Bt, Pos_Mr, Pos_Mt, Pos_Br] = Parse_compact_return(Positions);

%% 图1：下行链路能量分布对比
clear yi z p_power_rwpt  p_power_bf r_pos


% 获得稳定后发射端的振幅和相位分布
% Power_p = reshape(Power_p_5050(2.5*10, 1, :), 1, 2500);
% Phase_p = reshape(Phase_p_5050(2.5*10, 1, :), 1, 2500);
% Pos_p = Pos_p_5050;

% 绘制平面分布，yz平面位置
% 稳定下行链路
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Bt, Powers_Bt, Pos_Bt, r_pos, lambda_t, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于正对的情况
        if z>2.5
            if y<(50*lambda_t/4) && y>-(50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = 0 :0.01: 3;
y = -0.4 :0.01: 0.4;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
rmpt_0_xx = xx;
rmpt_0_yy = yy;
rmpt_0_zz = p_power_res'./power_max;



% 获得稳定后发射端的振幅和相位分布
% clear yi z p_power_rwpt  p_power_bf r_pos
% Power_p = reshape(Power_p_1_5050(2.5*10, 1, :), 1, 2500);
% Phase_p = reshape(Phase_p_1_5050(2.5*10, 1, :), 1, 2500);
% Pos_p = Pos_p_5050;

% 绘制平面分布，yz平面位置
% 初次下行链路
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Bt_1, Powers_Bt_1, Pos_Bt, r_pos, lambda_t, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于正对的情况
        if z>2.5
            if y<(50*lambda_t/4) && y>-(50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end
%         对于斜的情况
%         if z>2.5
%             if y<(z*1/2.5 +  50*lambda/4) && y>-(-z*1/2.5 +  50*lambda/4)
%                 p_power_res(zi, yi, :) = 0;
%             end
%         end

    end
end
z = 0 :0.01: 3;
y = -0.4 :0.01: 0.4;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
bf_0_xx = xx;
bf_0_yy = yy;
bf_0_zz = p_power_res'./power_max;

% 第一张图：接收端在0m，2.5m位置
createfigure_dis(rmpt_0_xx, rmpt_0_yy, rmpt_0_zz, bf_0_zz);
% set(findall(gcf, 'Type', 'line'), 'LineWidth', lineWidth);
% set(findall(gcf, 'Type', 'scatter'), 'SizeData', markerSize^2);
columnWidth = 7; % Set the desired column width in inches (e.g., 3.5 for a single-column figure or 7 for a double-column figure)
aspectRatio = 4/1.4; % Set the desired aspect ratio of the figure (e.g., 4/3 or 3/2)
figureWidth = columnWidth;
figureHeight = figureWidth / aspectRatio;
set(gcf, 'Units', 'inches', 'Position', [0, 0, figureWidth, figureHeight], 'PaperPositionMode', 'auto');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% set(gca,'xcolor','k');      % 默认是灰色，将其指定为黑色
% set(gca,'ycolor','k');
% fileName = 'Fig_space_dis_25m0m.pdf'; % Set the desired output file name
% print(gcf, fileName, '-dpdf', '-r600', '-opengl');

%% 图2：上行链路对比
% 绘制平面分布，yz平面位置
% 稳定上行链路
zi=0; yi=0;
for z = -0.5 :0.01: 2.5
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Mt, Powers_Mt, Pos_Mt, r_pos, lambda_r, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于正对的情况
        if z < 0
            if y<(50*lambda_t/4) && y>-(50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = -0.5 :0.01: 2.5;
y = -0.4 :0.01: 0.4;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
rmpt_0_xx = xx;
rmpt_0_yy = yy;
rmpt_0_zz = p_power_res'./power_max;

% 初次上行链路
zi=0; yi=0;
for z = -0.5 :0.01: 2.5
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.4 :0.01: 0.4
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Mt_1, Powers_Mt_1, Pos_Mt, r_pos, lambda_r, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于正对的情况
        if z < 0
            if y<(50*lambda_t/4) && y>-(50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = -0.5 :0.01: 2.5;
y = -0.4 :0.01: 0.4;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
bf_0_xx = xx;
bf_0_yy = yy;
bf_0_zz = p_power_res'./power_max;

% 第一张图：接收端在0m，2.5m位置
createfigure_dis_up(rmpt_0_xx, rmpt_0_yy, rmpt_0_zz, bf_0_zz);
% set(findall(gcf, 'Type', 'line'), 'LineWidth', lineWidth);
% set(findall(gcf, 'Type', 'scatter'), 'SizeData', markerSize^2);
columnWidth = 7; % Set the desired column width in inches (e.g., 3.5 for a single-column figure or 7 for a double-column figure)
aspectRatio = 4/1.4; % Set the desired aspect ratio of the figure (e.g., 4/3 or 3/2)
figureWidth = columnWidth;
figureHeight = figureWidth / aspectRatio;
set(gcf, 'Units', 'inches', 'Position', [0, 0, figureWidth, figureHeight], 'PaperPositionMode', 'auto');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% set(gca,'xcolor','k');      % 默认是灰色，将其指定为黑色
% set(gca,'ycolor','k');
% fileName = 'Fig_space_dis_25m0m.pdf'; % Set the desired output file name
% print(gcf, fileName, '-dpdf', '-r600', '-opengl');

%%
[Powers_Bt, Powers_Mr, Powers_Mt, Powers_Br] = Parse_compact_return(PowerFinalDistr);
[Phases_Bt, Phases_Mr, Phases_Mt, Phases_Br] = Parse_compact_return(PhaseFinalDistr);
[Powers_Bt_1, Powers_Mr_1, Powers_Mt_1, Powers_Br_1] = Parse_compact_return(PowerFirstDistr);
[Phases_Bt_1, Phases_Mr_1, Phases_Mt_1, Phases_Br_1] = Parse_compact_return(PhaseFirstDistr);
[Pos_Bt, Pos_Mr, Pos_Mt, Pos_Br] = Parse_compact_return(Positions);

%% 图3：偏移下行链路
% % 获得稳定后发射端的振幅和相位分布
% clear yi z p_power_rwpt  p_power_bf r_pos
% Power_p = reshape(Power_p_5050(2.5*10, 11, :), 1, 2500);
% Phase_p = reshape(Phase_p_5050(2.5*10, 11, :), 1, 2500);
% Pos_p = Pos_p_5050;
% 
% 绘制平面分布，yz平面位置
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.2 :0.01: 1.2
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Bt, Powers_Bt, Pos_Bt, r_pos, lambda_t, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于斜的情况
        if z>2.5
            if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = 0 :0.01: 3;
y = -0.2 :0.01: 1.2;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
rmpt_1_xx = xx;
rmpt_1_yy = yy;
rmpt_1_zz = p_power_res'./power_max;
% 
% 
% 
% % 获得稳定后发射端的振幅和相位分布
% clear yi z p_power_rwpt  p_power_bf r_pos
% Power_p = reshape(Power_p_1_5050(2.5*10, 11, :), 1, 2500);
% Phase_p = reshape(Phase_p_1_5050(2.5*10, 11, :), 1, 2500);
% Pos_p = Pos_p_5050;
% 
% 绘制平面分布，yz平面位置
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.2 :0.01: 1.2
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Bt_1, Powers_Bt_1, Pos_Bt, r_pos, lambda_t, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于斜的情况
        if z>2.5
            if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = 0 :0.01: 3;
y = -0.2 :0.01: 1.2;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
bf_1_xx = xx;
bf_1_yy = yy;
bf_1_zz = p_power_res'./power_max;




% 第二张图：接收端在1m，2.5m位置
createfigure_dis_y1m(rmpt_1_xx,rmpt_1_yy,rmpt_1_zz,bf_1_zz);
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
fileName = 'Fig_space_dis_25m1m.pdf'; % Set the desired output file name
print(gcf, fileName, '-dpdf', '-r600', '-opengl');

%% 图4：偏移上行链路
% % 获得稳定后发射端的振幅和相位分布
% clear yi z p_power_rwpt  p_power_bf r_pos
% Power_p = reshape(Power_p_5050(2.5*10, 11, :), 1, 2500);
% Phase_p = reshape(Phase_p_5050(2.5*10, 11, :), 1, 2500);
% Pos_p = Pos_p_5050;
% 
% 绘制平面分布，yz平面位置
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.2 :0.01: 1.2
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Mt, Powers_Mt, Pos_Mt, r_pos, lambda_r, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于斜的情况
        if z>2.5
            if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = 0 :0.01: 3;
y = -0.2 :0.01: 1.2;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
rmpt_1_xx = xx;
rmpt_1_yy = yy;
rmpt_1_zz = p_power_res'./power_max;
% 
% 
% 
% % 获得稳定后发射端的振幅和相位分布
% clear yi z p_power_rwpt  p_power_bf r_pos
% Power_p = reshape(Power_p_1_5050(2.5*10, 11, :), 1, 2500);
% Phase_p = reshape(Phase_p_1_5050(2.5*10, 11, :), 1, 2500);
% Pos_p = Pos_p_5050;
% 
% 绘制平面分布，yz平面位置
zi=0; yi=0;
for z = 0 :0.01: 3
    zi = zi+1;
    yi=0;
    disp(zi);
    for y = -0.2 :0.01: 1.2
        yi = yi+1;
        r_pos = [y; 0; z];
        [p_phase, p_power, p_E] = power_from_array(Phases_Mt_1, Powers_Mt_1, Pos_Mt, r_pos, lambda_r, Gt);      % 发射阵列在特定位置的功率密度
        p_power_res(zi, yi, :) = p_power;

%         对于斜的情况
        if z>2.5
            if y<(z*1/2.5 +  50*lambda_t/4) && y>-(-z*1/2.5 +  50*lambda_t/4)
                p_power_res(zi, yi, :) = 0;
            end
        end

    end
end
z = 0 :0.01: 3;
y = -0.2 :0.01: 1.2;
[xx,yy]=meshgrid(z,y); %构成格点矩阵
power_max = max(max(p_power_res'));
bf_1_xx = xx;
bf_1_yy = yy;
bf_1_zz = p_power_res'./power_max;




% 第二张图：接收端在1m，2.5m位置
createfigure_dis_y1m(rmpt_1_xx,rmpt_1_yy,rmpt_1_zz,bf_1_zz);
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
fileName = 'Fig_space_dis_25m1m.pdf'; % Set the desired output file name
print(gcf, fileName, '-dpdf', '-r600', '-opengl');


% % (1,1) rmpt 0m 
% ha = tight_subplot(2, 2, [.05 .05], [.1 .1], [.1 .1]);
% axes(ha(1));
% surf(rmpt_0_xx,rmpt_0_yy,rmpt_0_zz,'FaceColor','interp',...
%     'EdgeColor','none');
% % 创建 zlabel
% zlabel('Energy density(W/m^2)','FontName','Times New Roman');
% % 创建 ylabel
% ylabel('\ity \rm(m)','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('\itz \rm(m)','FontName','Times New Roman');
% view([-0.574033149171257 90]);
% hold('off');
% % 设置其余坐标区属性
% set(ha(1), 'FontName','Times New Roman','FontSize',8,'XColor',[0 0 0],...
%     'XTick',[0 0.5 1 1.5 2 2.5 3],'YColor',[0 0 0]);
% 
% % (1,2) bf 0m 
% axes(ha(2));
% surf(bf_0_xx,bf_0_yy,bf_0_zz,'FaceColor','interp',...
%     'EdgeColor','none');
% % 创建 zlabel
% zlabel('Energy density(W/m^2)','FontName','Times New Roman');
% % 创建 ylabel
% ylabel('\ity \rm(m)','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('\itz \rm(m)','FontName','Times New Roman');
% view([-0.574033149171257 90]);
% hold('off');
% % 设置其余坐标区属性
% set(ha(2), 'FontName','Times New Roman','FontSize',8,'XColor',[0 0 0],...
%     'XTick',[0 0.5 1 1.5 2 2.5 3],'YColor',[0 0 0]);
% 
% % (1,3) rmpt 1m 
% axes(ha(3));
% surf(rmpt_1_xx,rmpt_1_yy,rmpt_1_zz,'FaceColor','interp',...
%     'EdgeColor','none');
% % 创建 zlabel
% zlabel('Energy density(W/m^2)','FontName','Times New Roman');
% % 创建 ylabel
% ylabel('\ity \rm(m)','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('\itz \rm(m)','FontName','Times New Roman');
% view([-0.574033149171257 90]);
% hold('off');
% % 设置其余坐标区属性
% set(ha(3), 'FontName','Times New Roman','FontSize',8,'XColor',[0 0 0],...
%     'XTick',[0 0.5 1 1.5 2 2.5 3],'YColor',[0 0 0]);
% 
% % (1,4) bf 1m 
% axes(ha(4));
% surf(bf_1_xx,bf_1_yy,bf_1_zz,'FaceColor','interp',...
%     'EdgeColor','none');
% % 创建 zlabel
% zlabel('Energy density(W/m^2)','FontName','Times New Roman');
% % 创建 ylabel
% ylabel('\ity \rm(m)','FontName','Times New Roman');
% % 创建 xlabel
% xlabel('\itz \rm(m)','FontName','Times New Roman');
% view([-0.574033149171257 90]);
% hold('off');
% % 设置其余坐标区属性
% set(ha(4), 'FontName','Times New Roman','FontSize',8,'XColor',[0 0 0],...
%     'XTick',[0 0.5 1 1.5 2 2.5 3],'YColor',[0 0 0]);
