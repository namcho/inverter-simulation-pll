
%% Orthogonal waveforms
f27 = figure(27);

% Figure background color
f27.Color = [hex2dec('15')/255, hex2dec('20')/255, hex2dec('2B')/255];

subplot(3,1,1);
hold off;
p11 = plot(t, v_alpha_debug);
hold on;
p12 = plot(t, v_beta_debug);

% Legend theme
lg = legend('V_{alpha}', 'V_{beta}');
set(lg, 'color', [hex2dec('22')/255, hex2dec('27')/255, hex2dec('2E')/255]);
lg.TextColor = [1, 1, 1];
lg.FontName = 'Arial Rounded MT Bold';

% Ploting area theme
set(gca, 'Color', [hex2dec('15')/255, hex2dec('20')/255, hex2dec('2B')/255]);
grid on;
set(gca, 'XColor', 'w');
set(gca, 'YColor', 'w');
title('Clark Transformation Outputs - Orthogonal Signals', 'Color', 'w');
xlabel('Time [s]')
ylabel('Clark Axis [V]');

% First line theme
p11.LineWidth = 2;
p11.Color = [hex2dec('5C')/255, hex2dec('37')/255, hex2dec('B8')/255];

% Second line theme
p12.LineWidth = 2;
p12.Color = [hex2dec('FD')/255, hex2dec('FA')/255, hex2dec('1F')/255];


%% Rotating reference frame waveforms
subplot(3,1,2);
hold off;
p21 = plot(t, Vq_debug);
hold on;
p22 = plot(t, Vd_debug);

% Legend Theme
lg = legend('V_{d}', 'V_{q}');
set(lg, 'color', [hex2dec('22')/255, hex2dec('27')/255, hex2dec('2E')/255]);
lg.TextColor = [1, 1, 1];
lg.FontName = 'Arial Rounded MT Bold';

% Ploting area theme
set(gca, 'Color', [hex2dec('15')/255, hex2dec('20')/255, hex2dec('2B')/255]);
grid on;
set(gca, 'XColor', 'w');
set(gca, 'YColor', 'w');
title('Park Transformation Outputs - DC Signals', 'Color', 'w');
xlabel('Time [s]');
ylabel('Park Axis [V]');

% First line theme
p21.LineWidth = 2;
p21.Color = [hex2dec('5C')/255, hex2dec('37')/255, hex2dec('B8')/255];

% Second line theme
p22.LineWidth = 2;
p22.Color = [hex2dec('FD')/255, hex2dec('FA')/255, hex2dec('1F')/255];


%% Grid voltage vs Estimated PLL generated voltage
subplot(3,1,3);
hold off;
p31 = plot(t, 310*sin(wff*t));
hold on;
p32 = plot(t, 310*sin(theta_est_debug));

% Legend Theme
lg = legend('sin(w_{grid} x t)', 'sin(w_{estimated} x t)');
set(lg, 'color', [hex2dec('22')/255, hex2dec('27')/255, hex2dec('2E')/255]);
lg.TextColor = [1, 1, 1];
lg.FontName = 'Arial Rounded MT Bold';

% Ploting area theme
set(gca, 'Color', [hex2dec('15')/255, hex2dec('20')/255, hex2dec('2B')/255]);
grid on;
set(gca, 'XColor', 'w');
set(gca, 'YColor', 'w');
title('Grid Voltage vs Estimated PLL Sinus Waveform', 'Color', 'w');
xlabel('Time [s]');
ylabel('Voltage [V]');

% First line theme
p31.LineWidth = 2;
p31.Color = [hex2dec('5C')/255, hex2dec('37')/255, hex2dec('B8')/255];

% Second line theme
p32.LineWidth = 2;
p32.Color = [hex2dec('FD')/255, hex2dec('FA')/255, hex2dec('1F')/255];

