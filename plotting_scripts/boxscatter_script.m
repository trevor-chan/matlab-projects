%%
%Data
line1tt = [68 194 137 1234 482 1050 456 161 196];
line2tt = [144 42 575 535 430 100 91 114 404 1036 820];
line3tt = [3699 554 1062 990 1744 554 3039 1179];
line4tt = [209 22 278 1788 208 533 560 1297 115 16 ...
    337 43 1267 460 93 879 962 1787 273 948 212 1083 ...
    202 588 305 96 341 893 620 80 797 342 518];
line5tt = [408 884 374 328 141 168 73 214 399 886 ...
    198 1997 393 189 824 185 459 2574 144];

transittimes = {[line1tt] ; [line2tt] ; [line3tt] ; [line4tt] ; [line5tt]};

ymrtt = [309 2227 727 1355 2601];

transittimes1016 = [425 1195 89 91 51 77 2553 80 165 490 694 ...
    3135 2604 725 2241 465 312 572 789 495 224 178];
    




%stat format = [mean stdev coefVar stderrofmean]
line1stat = [442 423.1734278 0.9574059453 141.0578093];
line2stat = [390.0909091 330.2361139 0.8465619326 99.56993472];
line3stat = [1602.625 1166.448816 0.7278364031 412.4019337];
line4stat = [550.0606061 484.3690444 0.7916143729 84.31782787];
line5stat = [570.4210526 660.1372177 1.157280599 151.4458643];
YMR1016stat = [802.2727273	938.4217846	1.169704207	200.0721967];

proliferation = [0.7166116388 0.7683094314 0.8572080029 ...
    1.040072988 0.9747951095];

%%
%Plotting
C = {transittimes1016(:); line1tt(:); line2tt(:); line3tt(:); line4tt(:); line5tt(:)};
grp = cell2mat(arrayfun(@(i){i*ones(numel(C{i}),1)},(1:numel(C))')); 
boxplot(vertcat(C{:}),grp);

boxplot(vertcat(C{:}),grp, 'Notch','on','Labels',{'YMR','Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'}, 'Whisker',1);

ylabel('Time (s)');
title('Monoclonal cell line transit times');

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'g');

hold on
xCenter = 1:numel(C); 
spread = 0.3; % 0=no spread; 0.5=random spread within box bounds (can be any value)
for i = 1:numel(C)
    %plot(rand(size(C{i}))*spread -(spread/2) + xCenter(i), C{i}, 'mo','linewidth', 2)
    %scatter(rand(size(C{i}))*spread -(spread/2) + xCenter(i), C{i}, 'r','linewidth', .5);
    f1 = scatter(rand(size(C{i}))*spread -(spread/2) + xCenter(i), C{i}, 'k','filled');
    hold on;
    f1.MarkerFaceAlpha = 0.3;
end
hold off;

%%
figure(2);
index = [1:5];

mean = [YMR1016stat(1) line1stat(1) line2stat(1) line3stat(1) ...
    line4stat(1) line5stat(1)];
stderr = [YMR1016stat(4) line1stat(4) line2stat(4) line3stat(4) ...
    line4stat(4) line5stat(4)];
mean2 = [mean(2) mean(3) mean(4) mean(5) mean(6)];
stderr2 = [line1stat(4) line2stat(4) line3stat(4) ...
    line4stat(4) line5stat(4)];

labels = categorical({'Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});
labels = reordercats(labels, {'Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});

%bar(labels, mean2,'b');
scatter(labels, mean2,'b');
hold on
eb(1) = errorbar(index, mean2, stderr2, 'vertical', 'LineStyle', 'none');
set(eb, 'color', 'k', 'LineWidth', 2)
scatter(labels,ymrtt,'r');

title('Population mean and associated parent cell transit time');
ylabel('Transit time (s)');


%%
figure(3);
index = [1:6];

coefvar = [YMR1016stat(3) line1stat(3) line2stat(3) line3stat(3) ...
    line4stat(3) line5stat(3)];
coefvar = coefvar*100;

labels = categorical({'YMR','Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});
labels = reordercats(labels, {'YMR','Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});

%bar(labels, coefvar);
scatter(labels,coefvar);
hold on

title('Transit time coefficient of variance');
ylabel('coefficient of variance = Stdev/mean');

%%
figure(4);
index = [1:6];

stdev = [YMR1016stat(2) line1stat(2) line2stat(2) line3stat(2) ...
    line4stat(2) line5stat(2)];

labels = categorical({'YMR','Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});
labels = reordercats(labels, {'YMR','Line 1','Line 2', ...
    'Line 3','Line 4','Line 5'});

bar(labels, stdev);
hold on

title('Transit time standard deviation');
ylabel('stdev');

%%
figure(5);
mean2 = [mean(2) mean(3) mean(4) mean(5) mean(6)];
corrmat = [mean2 ; ymrtt];
corrmat = transpose(corrmat);
corrplot(corrmat); 
title('Parent cell and daughter population transit times');
PrettyFig;