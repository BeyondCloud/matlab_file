function r =leastSqr(pntx,pnty)
n=size(pntx,2);
if (size(pntx,2)~=size(pnty,2))
   fprintf(1,'\nERROR!\npntx and pnty must have the same number of elements\n');
   y=NaN;
else
%============modify here only=================
  %note that don't write 1,use x.^0 instead  
  %ln use log
%    f1 = @(x) x.^(-1);
%    f2 = @(x) x.^0;

    f1 = @(x) x.^0;
    f2 = @(x) x.^1;
    f3 = @(x) x.^2;
    

   X = cat(1, f1(pntx), f2(pntx),f3(pntx)); %add more arg if you need
%===========================================
   X = transpose(X);
   A = zeros(size(X,2)); %create size(X,2) by size(X,2) zero mat
   B = zeros(1,size(X,2));
   for i=1:n
            row =X(i,:);
            A = A + transpose(row)*row;
            B = B + X(i,:).*pnty(i);
   end
   r = inv(A)*transpose(B);
end

