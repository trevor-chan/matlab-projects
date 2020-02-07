A = zeros(3,3,3,3); %Tijlm = Eijk*Eklm
B = zeros(3,3,3,3); %Tijlm = dil*djm-dim*djl
for i = 1:3
    for j = 1:3
        for l = 1:3
            for m = 1:3
                %determines if the inner product Eijk and Eklm is +1, -1,
                %or zero
                if i ~= j && l == i && m == j 
                    r = 1;
                elseif i ~= j && l == j && m == i
                    r = -1;
                else
                    r = 0;
                end
                A(i,j,l,m) = r;
                s = 0;
                %Determine product of dil*djm, add 1 if nonzero
                if i==l && j==m
                    s = 1;
                end
                %Determine product of dim*djl, subtract 1 if nonzero
                if i==m && j==l
                    s = s-1;
                end
                B(i,j,l,m) = s;
            end
        end
    end
end
%Check if matrices are identical
answ = isequal(A,B);
disp(answ);


