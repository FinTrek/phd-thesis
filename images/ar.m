rng(2);
fTildeX = @(t) 2 + sin(t);
M = 4;
T = 4*pi;

p = []; py = [];
r = []; ry = [];

R = 100; attempts = 0;
for rep=1:R
    for attempt=1:100
        x = rand()*T;
        u = rand();
        if u < fTildeX(x) / M
            p = [p, x];
            py = [py, M*u];
            break;
        else
            r = [r, x];
            ry = [ry, M*u];
            
            disp('failed')
            x
            u
            r
            ry
        end
    end
    attempts = attempts + attempt;
end

fails = attempts - R

%
figure(1); clf; hold on; 
xlabel('$x$', 'interpreter', 'latex');
ylabel('$U$', 'interpreter', 'latex');
t = 0:0.01:T;
plot(t, fTildeX(t));
line([0, T], [M, M], 'LineWidth', 4);
scatter(p, py, 'o');
scatter(r, ry, '+');
scatter(p, zeros(size(p)), 80, [0 .5 0], 's', 'filled');
for i=1:numel(p)
    line([p(i), p(i)], [0, py(i)], 'LineStyle', '--', 'Color', [0 .5 0]);
end
axis([0, T, 0, M+.01]);
legend({'$\widetilde{f}_X(x)$','$C f_Y(x)$','Accepted Points','Rejected Points'}, 'interpreter', 'latex');

%set(gcf,'OuterPosition',[700,500,700,500])
set(gcf, 'OuterPosition', [360, 470, 820, 370]);
%export_fig('..\images\pp.pdf', '-pdf', '-transparent');

save_plot_as_pdf('ar.pdf')

function save_plot_as_pdf(name)
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = [fig_pos(3)*0.85 fig_pos(4)];
    print(name, '-dpdf')
end