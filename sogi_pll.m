%% @Author MSc. Nazým Yýldýz
%% @date 23.07.2021
%% @brief One of the oldest and powerful PLL algorithm for single-phase inverter control
%% @reference [1]https://ieeexplore.ieee.org/document/1711988
%% @reference [2]https://ieeexplore.ieee.org/document/6179528
clear, clc

fs = 10000; % Hz sampling freq
Ts = 1/fs;  % Sampling period

f_grid = 50.0;      % Hz grid freq
wff = 2*pi*f_grid;

t = [0:Ts:10];      % Simulation time
vi = 310*sin(wff*t);% input voltage for PLL - it's simulating grid-voltage

%% Debug outputs
v_alpha_debug = zeros(1, length(t));
v_beta_debug = zeros(1, length(t));
Vd_debug = zeros(1, length(t));
Vq_debug = zeros(1, length(t));
w_est_debug = zeros(1, length(t));
theta_est_debug = zeros(1, length(t));

%% Phase detector inits - SOGI
k = 5;%2.01;           % To_p = 2/(k*w); to_p = 3.03e-3, w = 2*pi*f

v_alpha = 0.0;      % output [n]
v_alpha_n1 = 0.0;   % output [n-1]
v_alpha_in = 0.0;   % input [n]
v_alpha_in1 = 0.0;  % input [n-1]
v_alpha_in2 = 0.0;  % input [n-2]
v_alpha_in3 = 0.0;  % input [n-3]

v_beta = 0.0;       % output [n]
v_beta_n1 = 0.0;    % output [n-1]
v_beta_in = 0.0;    % input [n]
v_beta_in1 = 0.0;   % input [n-1]
v_beta_in2 = 0.0;   % input [n-2]
v_beta_in3 = 0.0;   % input [n-3]

%% Loop filter inits - PI
Kp = 137.5;     % see [2] 137.5
Ki = 7878.0;    % see [2] 7878.0
pi_integ = 0.0;
pi_out = 0.0;
pi_ref = 0.0;   % For Vq

%% Voltage Control Output inits - VCO
w_est = 0.0;
theta_est = 0.0;
theta_integ = 0.0;

%% Algorithm RUN
for i = 1:length(t);
    
   vin_norm = vi(i)/310;    % Normalized value, diveded by 310
   
   %% SOGI calculations
   v_alpha_in = ((vin_norm - v_alpha)*k - v_beta) * w_est;
   v_alpha = v_alpha_n1 + (Ts/12)*(23*v_alpha_in1 - 16*v_alpha_in2 + 5*v_alpha_in3);
   v_alpha_in3 = v_alpha_in2;
   v_alpha_in2 = v_alpha_in1;
   v_alpha_in1 = v_alpha_in;
   v_alpha_n1 = v_alpha;
   
   v_beta_in = v_alpha * wff;
   v_beta = v_beta_n1 + (Ts/12)*(23*v_beta_in1 - 16*v_beta_in2 + 5*v_beta_in3);
   v_beta_in3 = v_beta_in2;
   v_beta_in2 = v_beta_in1;
   v_beta_in1 = v_beta_in; 
   v_beta_n1 = v_beta;
   
   %% Park transformation calculations
   Vd = cos(theta_est) * v_alpha + sin(theta_est) * v_beta;
   Vq = -sin(theta_est) * v_alpha + cos(theta_est) * v_beta;
   
   %% Loop filter - PI calculations
   pi_err = pi_ref - Vq;
   pi_integ = pi_integ + pi_err*Ki*Ts;
   pi_out = pi_err*Kp + pi_integ;
   
   %% VCO calculations
   w_est = wff + pi_out;
   theta_integ = w_est * Ts;
   theta_est = theta_est + theta_integ;
   if theta_est > 2*pi
      theta_est = 2*pi - theta_est; 
   end
   
   %% Debug and visualization purpose
   v_alpha_debug(i) = v_alpha;
   v_beta_debug(i) = v_beta;
   Vd_debug(i) = Vd;
   Vq_debug(i) = Vq;
   w_est_debug(i) = w_est;
   theta_est_debug(i) = theta_est;
end


