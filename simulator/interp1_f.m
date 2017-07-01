function yi=interp1_f(x,y,xi,method,L,b1,b2)
if strcmpi(method,'delta')
    ind=interp1(xi,1:length(xi),x,'nearest'); % index of xi, length(x)=length(ind)=number of markers
    yi=zeros(size(xi));
    yi(ind(~isnan(ind)))=y(~isnan(ind));
else
    yi=interp1([0 x L],[b1 y b2],xi,method); 
end