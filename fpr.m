function [str] = fpr(x)
% Generates the floating point representation of a floating point number x

str1 = dec2bin(typecast(x, 'uint64'), 64);

str = ['s' str1(1) 'e'];
for k = 1:11
    str = [str str1(k+1)];
end

str = [str 'm'];
for k = 1:52
    str = [str str1(k+12)];
end

end