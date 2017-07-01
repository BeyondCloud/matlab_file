function ab = leastSqr2(pointx,pointy)
n=size(pointx,2);
if (size(pointx,2)~=size(pointy,2))
   fprintf(1,'\nERROR!\nPOINTX and POINTY must have the same number of elements\n');
   y=NaN;
else
    
   %note that don't write 1,use x.^0 instead
   f1 = @(x) x;
   f2 = @(x) x.^0; 
   
   x1 = f1(pointx);
   x2 = f2(pointx);
   sum_x1x1 = 0;
   sum_x1x2 = 0;
   sum_x2x2 = 0;
   for i=1:n
        sum_x1x1 = sum_x1x1 + x1(i)*x1(i);
        sum_x1x2 = sum_x1x2 + x1(i)*x2(i);
        sum_x2x2 = sum_x2x2 + x2(i)*x2(i);      
   end
   A = [sum_x1x1 sum_x1x2 ;sum_x1x2  sum_x2x2];
   B = [sum(x1.*pointy);sum(x2.*pointy)];
   ab = inv(A)*B;
end

f = @(x) ab(1,:)*x+ab(2,:);
hold on;
plot(pointx,pointy,'o');
plot(pointx,f(pointx),'-');
hold off;