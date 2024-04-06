% Define theta range from -pi/2 to pi/2 (-90° to 90°)
epsilon = 1e-5;
theta = linspace(-pi/2 + epsilon, pi/2 - epsilon, 1000);

% Constants
L = 0.4;

% Compute Y values for E-plane
Y_E_1 = 0.7453 * pi * ((sin(pi * L * cos(theta)))./(pi * L * cos(theta))) .* cos(pi * L * sin(theta));
Y_E = Y_E_1.^2;
Y_E = 10 * log10(Y_E);

% disp(max(Y_E))
% % 4.9693

% Compute Y values for H-plane
Y_H_1 = 0.7453 * pi * sin(theta + pi/2) .* ((sin(pi * L * sin(theta + pi/2)))./(pi * L * sin(theta + pi/2))) ...
     .* ((sin(pi * L * cos(theta + pi/2)))./(pi * L * cos(theta + pi/2)));
Y_H = Y_H_1.^2;
Y_H = 10 * log10(Y_H);
% Y_H = 10 * log10(Y_H_G);

% Truncate values less than -20 dBi
Y_E(Y_E < -20) = -20;
Y_H(Y_H < -20) = -20;
Y_H(Y_H > 6) = 6;



% Set up the figure size based on column width and aspect ratio
columnWidth = 3.5; % Width in inches
aspectRatio = 2/1.4; 
figureWidth = columnWidth;
figureHeight = figureWidth / aspectRatio;
figure('Units', 'inches', 'Position', [2, 2, figureWidth, figureHeight], 'PaperPositionMode', 'auto');

% Plot for E-plane (left side)
% subplot(1, 2, 1);
polarplot(theta, Y_E, 'r', 'LineWidth', 2,  'Color',[0 0 0.7]);
set(gca, 'Position', [0.05 0 0.85 0.85])
% title('\bf\it(a) Antenna Gain at \phi = 0^\circ/360^\circ', 'FontSize', 14, ...
%     'Position', [0, -34, 0], 'FontName', 'Times New Roman', 'Interpreter','latex');
rlim([-20 10]); % This sets the range for the plot

ax1 = gca;
ax1.FontSize = 12;  % Adjust the font size here
ax1.FontName = 'Times New Roman';
ax1.ThetaZeroLocation = 'top';
ax1.ThetaDir = 'clockwise';
ax1.ThetaLim = [-90+epsilon 90-epsilon];
ax1.ThetaTickLabel = { '60^\circ', '30^\circ', '0^\circ', '30^\circ', '60^\circ'};
ax1.RTickLabel = {'-20', '-10', '0dBi', '10'};


% Arrow and label for phi on E-plane
annotation('line',[0.475 0.475],[0.85 0.95],'LineWidth',1);
annotation('arrow',[0.475 0.505],[0.9 0.9],'LineWidth',1, 'HeadWidth', 8, 'HeadLength', 8);
annotation('textbox',[0.495, 0.85, 0.1, 0.1],'String', '\theta', 'FontSize', ...
    14, 'EdgeColor', 'none', 'FontName', 'Times New Roman');

%%
% Plot for H-plane (right side)
subplot(1, 2, 2);
polarplot(theta, Y_H, 'b', 'LineWidth', 2, 'Color',[0.85 0.33 0.1]);
% title('\bf\it(b) Antenna Gain at \phi = 90^\circ/270^\circ', 'FontSize', 14, ...
%     'Position', [0, -34, 0], 'FontName', 'Times New Roman');
rlim([-20 10]); % This sets the range for the plot

ax2 = gca;
ax2.FontSize = 12;  % Adjust the font size here
ax2.FontName = 'Times New Roman';
ax2.ThetaZeroLocation = 'top';
ax2.ThetaDir = 'clockwise';
ax2.ThetaLim = [-90+epsilon 90-epsilon];
ax2.ThetaTickLabel = { '60^\circ', '30^\circ', '0^\circ', '30^\circ', '60^\circ'};
ax2.RTickLabel = {'-20', '-10', '0dBi', '10'};


% Arrow and label for phi on H-plane
annotation('line',[0.73 0.73],[0.85 0.95],'LineWidth',1);
annotation('arrow',[0.73 0.76],[0.9 0.9],'LineWidth',1, 'HeadWidth', 8, 'HeadLength', 8);
annotation('textbox',[0.752, 0.85, 0.1, 0.1],'String', '\theta', 'FontSize', 14, 'EdgeColor', 'none', 'FontName', 'Times New Roman');

% Save figure to PDF
% pos = get(gcf, 'Position');
% set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
% fileName = 'Fig_antenna_gain.pdf';
% print(gcf, fileName, '-dpdf', '-r600', '-opengl');
