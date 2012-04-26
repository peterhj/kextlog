close all;

dt = 24*60*60;
ds = 60*60;
t0 = 1325376000/dt;

ts = csvread('kernel.log.out');
t = ts - mod(ts, dt);
s = mod(ts, dt);

% Offset date from New Year's Day
t = t/dt - t0;

% Offset time from midnight
s = s/ds;

% Scatterplot
%figure;
%plot(t, s, 'k.');

% 2d histogram
t_lev = 15;
s_lev = 3;
s_res = 4;
nt = max(t)-min(t)+1;
ns = 24*s_res;
ti = linspace(min(t), max(t), nt);
si = linspace(min(s), max(s), ns);
tr = interp1(ti, 1:nt, t, 'nearest');
sr = interp1(si, 1:ns, s, 'nearest');
z = accumarray([tr sr], 1, [nt ns]);
z = z';

min_tr = min(tr)+min(t)-1;
max_tr = max(tr)+min(t)-1;
z_xticks = linspace(1-min(t)+ceil(min_tr/t_lev)*t_lev, 1-min(t)+floor(max_tr/t_lev)*t_lev, 1+abs(ceil(min_tr/t_lev))+abs(floor(max_tr/t_lev)));
z_xlabels = z_xticks+min(t)-1;
z_yticks = linspace(0, ns, 24/s_lev+1);
z_ylabels = z_yticks/s_res;

% Time series analysis
z_samp = z(:) > 0;
%z_samp = bwmorph(z_samp, 'clean');
%z_samp = bwmorph(z_samp, 'fill');
n_samp = nt;
Z = abs(fft(z_samp));
nf = length(Z)/2;
f = [0:(nf-1)]/n_samp;
Z = Z(1:nf);
Z(1) = 0;
Z = Z.^2;

% Plotting

figure;

g = subplot(2,1,1);
imagesc(z, [0 6]);
colormap('gray');

set(g, 'YDir', 'normal');
set(g, 'XTick', z_xticks);
set(g, 'XTickLabel', z_xlabels);
set(g, 'YTick', z_yticks);
set(g, 'YTickLabel', z_ylabels);
set(g, 'TickLength', [0 0]);

gx = xlabel('Day (since 1/1/12)');
gy = ylabel('Hour');

set(gx, 'FontName', 'Helvetica Neue');
set(gy, 'FontName', 'Helvetica Neue');
set(gx, 'FontSize', 14);
set(gy, 'FontSize', 14);

h = subplot(2,1,2);
plot(f, Z, 'k');

set(h, 'TickLength', [0 0]);

hx = xlabel('Frequency (day^{-1})');
hy = ylabel('Power Spectrum');

set(hx, 'FontName', 'Helvetica Neue');
set(hy, 'FontName', 'Helvetica Neue');
set(hx, 'FontSize', 14);
set(hy, 'FontSize', 14);
