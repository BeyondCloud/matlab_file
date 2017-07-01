function yi=interp1_v(x,y,xi,method,L)
if strcmpi(method,'delta')
    ind=interp1(xi,1:length(xi),x,'nearest'); % index of xi, length(x)=length(ind)=number of markers
    yi=zeros(size(xi));
    yi(ind(~isnan(ind)))=y(~isnan(ind));
else
    yi=interp1([0 x L],[0 y 0],xi,method); 
end