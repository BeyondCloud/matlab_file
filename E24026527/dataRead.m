dim = 2   %a,b:2 , a,b,c:3
sumA = zeros(dim); 
sumB = zeros(1,dim);
for k = 1:2
   textFilename = ['f' num2str(k) '.dat'];
   M = csvread( textFilename);
   M = transpose(M);
   Mx = M(1,:);
   My = M(2,:);
   [A,B] = leastSqr(Mx,My);
   sumA = sumA +A;
   sumB = sumB +B;
end