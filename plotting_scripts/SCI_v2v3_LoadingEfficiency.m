v2channels = [1:23];
v2cells = [4,7,4,8,2,3,2,2,4,2,5,4,6,9,6,2,2,4,2,4,2,5,2];
v2length = [8,0,8,16,24,32,40,48,52,44,36,28,20,12,4,48,40,32,24,16,8,0,8];
v2length = v2length+12;

v3channels = [1:22];
v3length = 29.*ones(22,1);
v3cells = [2,4,3,3,3,3,2,2,4,4,3,3,4,4,4,4,5,3,5,3,4,4];


%{
figure(1);
subplot(1,2,1);
bar(v2channels,v2cells);
subplot(1,2,2);
bar(v3channels,v3cells);
%}

figure(2);
title('Number of Doubly Loaded Channels');
dblloadingv2 = [0,9,5,9];
dblloadingv3 = [0,1,2,2];
m = [dblloadingv2;dblloadingv3];
boxplot(m);

figure(3);
title('Number of Non-loaded Channels');
emptychnv2 = [9,7,4,10];
emptychnv3 = [4,5,4,2];
m = [emptychnv2;emptychnv3];
boxplot(m);

figure(4);
title('Number of Singly-loaded Channels');
snglv2
