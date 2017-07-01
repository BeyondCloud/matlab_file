 function [L,U,flag]=LU(A) 
% flag='failure'表示計算失敗，flag='OK'表示計算成功 
[n,m]=size(A); 
if n~=m 
    error('The rows and columns of matrix A must be equal!'); 
    return; 
end 

v = [1 1 1 1 1 1 1 1 1 1];
L = diag(v);
U=zeros(n);
flag='OK'; 
for k=1:n 
    for j=k:n 
        z=0; 
        for s=1:k-1 
            z=z+L(k,s)*U(s,j); 
        end 
        U(k,j)=(A(k,j)-z)/L(k,k); 
        
    end 
    
    if abs(U(k,k))<eps 
        flag='failure'; 
        return; 
    end 
    
    for i=k+1:n 
        z=0; 
        for s=1:k-1 
            z=z+L(i,s)*U(s,k); 
        end 
        L(i,k)=(A(i,k)-z)/U(k,k); 
    end 
end 

