n=17;
eapp=0;
for k = 0:n
    eapp = eapp + 1/factorial(k);
end
error=eapp - exp(1)