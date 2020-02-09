tt1016 = [309,2227,727,1355,2601];
tt0912 = [475 1000 585 630];
tt0919 = [3485 2509];
dbr1016 = [0.7166116388 0.7683094314 0.8572080029 1.040072988 ...
    0.9747951095];
dbr0912 = [0.6652740407 1.445324132 1.394714728 0.9911993159];
dbr0919 = [0.9527570621 0.9828081612];

figure(1);
hold on;

f2 = scatter(tt0912, dbr0912, 'g','filled');
f3 = scatter(tt0919, dbr0919, 'r','filled');
f1 = scatter(tt1016, dbr1016, 'b','filled');

title('Single cell proliferation vs transit time');
xlabel('Transit time (s)');
ylabel('Doubling rate (days)');
PrettyFig;
legend('0912LoadingExperiment','0919LoadingExperiment' ...
,'1016LoadingExperiment');

%%
%proliferation of 5 monoclonal populations

%stat format = [mean stdev coefVar stderrofmean]
line1stat = [442 423.1734278 0.9574059453 141.0578093];
line2stat = [390.0909091 330.2361139 0.8465619326 99.56993472];
line3stat = [1602.625 1166.448816 0.7278364031 412.4019337];
line4stat = [550.0606061 484.3690444 0.7916143729 84.31782787];
line5stat = [570.4210526 660.1372177 1.157280599 151.4458643];

proliferation = [0.7166116388 0.7683094314 0.8572080029 ...
    1.040072988 0.9747951095];
figure(2);