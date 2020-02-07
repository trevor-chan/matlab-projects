v2length = [8,0,8,16,24,32,40,48,52,44,36,28,20,12,4,48,40,32,24,16,8,0,8];
v2length = v2length+12;
v3length = 29.*ones(22,1);

v3cellsA = [1,1,0,1,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,0,1,1];
v3cellsB = [0,1,1,1,0,0,1,1,1,0,1,1,1,1,1,1,2,0,1,1,1,1];
v3cellsC = [0,1,1,0,1,1,0,1,1,2,0,1,1,1,1,1,1,1,2,1,1,1];
v3cellsD = [1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,2,1,1,2,1,1,1];
v3cells = [v3cellsA ; v3cellsB ; v3cellsC ; v3cellsD];

v2cellsE = [1,1,1,1,0,1,0,0,1,0,0,1,1,1,1,0,0,1,0,1,0,1,1];
v2cellsF = [2,1,2,1,1,0,1,0,0,1,3,0,1,3,2,0,1,0,2,1,2,1,0];
v2cellsG = [1,2,1,2,0,1,1,0,1,1,1,1,1,1,1,1,1,2,0,2,0,2,1];
v2cellsH = [0,3,0,4,0,1,0,2,1,0,1,1,2,3,1,1,0,1,0,0,0,1,0];
v2cells = [v2cellsE ; v2cellsF ; v2cellsG ; v2cellsH];

v2totals = v2cellsE + v2cellsF + v2cellsG + v2cellsH;
v3totals = v3cellsA + v3cellsB + v3cellsC + v3cellsD;

m = [v2length ; v2cells];
[~,idx] = sort(m(1,:));
sortedm = m(:,idx);
slength = sortedm(1,:);
%scells = m(2:5,:);
scells = v2totals(idx);
slength = slength.';
scells = scells.';
figure(2)
corrplot([slength,scells],'varNames',{'lngth','cells'});


%{
v2lengthcondensed = [12,16,20,24,28,32,36,40,44,48,52,56,60,64];
v2cellscondensed = [(7+5)/2,5,(4+4+2+2)/4,8,(8+4)/2,5,(1+2)/2,3,(3+4)/2,5,(2+2)/2,2,(2+2)/2,3];
x = [v2lengthcondensed;v2cellscondensed];
%}

v3empty = zeros(4,1);
v3sngl = zeros(4,1);
v3dbl = zeros(4,1);
for i = 1:4
    for j = 1:22
        if v3cells(i,j) == 0
            v3empty(i) = v3empty(i)+1;
        elseif v3cells(i,j) == 1
            v3sngl(i) = v3sngl(i)+1;
        else
            v3dbl(i) = v3dbl(i)+v3cells(i,j)-1;
        end
    end
end

v2empty = zeros(4,1);
v2sngl = zeros(4,1);
v2dbl = zeros(4,1);
for i = 1:4
    for j = 1:22
        if v2cells(i,j) == 0
            v2empty(i) = v2empty(i)+1;
        elseif v2cells(i,j) == 1
            v2sngl(i) = v2sngl(i)+1;
        else
            v2dbl(i) = v2dbl(i)+v2cells(i,j)-1;
        end
    end
end

figure(1)
subplot(1,3,1);
boxplot([v2empty,v3empty],'Labels',{'old','new'});
title('non-loaded');
ylabel('Channels');
subplot(1,3,2);
boxplot([v2sngl,v3sngl],'Labels',{'old','new'});
title('singly-loaded');
ylabel('Channels');
subplot(1,3,3);
boxplot([v2dbl,v3dbl],'Labels',{'old','new'});
title('doubly-loaded');
ylabel('Channels');


%addpath('C:\Users\Trevor Chan\Desktop');
%PrettyFig