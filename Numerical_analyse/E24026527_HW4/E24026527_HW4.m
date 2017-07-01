k = 0.41
y = zeros(5)
%load velser1~5 first col
for i = 1:5
    z = sprintf('velser%d.out', i);
    ztmp = load(z);
    y(i) = mean(ztmp(:,1));
end

xy = 0;
yAvgSum = 0;
for j=1:5
      xy = xy+y(j)*log(j);
      yAvgSum = yAvgSum+y(j);
end

x = 0;
xx = 0;
for i = 1:5
    xx = xx + log(i)^2;
    x = x + log(i);
end
A = [xx x;x 5];
B = [xy;yAvgSum];
ab = inv(A)*B;
Ustar = k*ab(1)
Z0 = exp(-ab(2)/ab(1))
