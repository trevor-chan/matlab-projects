function r = levicivata(a,b,c)
    if a ~= b && a ~= c && b ~= c
        if (a<b && b<c) || (b<c && c<a) || (c<a && a<b)
            r = 1;
        else
            r = -1;
        end
    else
        r = 0;
    end
end

function r = kroneckerdelta(a,b)