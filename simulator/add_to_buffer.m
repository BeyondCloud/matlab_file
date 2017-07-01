function add_to_buffer(src,eventdata,Fs,ao,pso)
global pco pco1
global ym
global y hp m
% d1=0.1*randn(pso,2);
% putdata(ao,d1);
x1=pso*(pco1-1)+(1:pso);
if x1(end)>length(ym)
    %disp('out of ym');
    delete(daqfind);
    return;
end
%d1=ym(x1);

%d1=y(x1,m);
%d2=[d1 d1];
d2=[y(x1,m(1)) y(x1,m(2))];
putdata(ao,d2);
pco=pco+1;
pco1=pco1+1;


if ishandle(hp)
    set(hp,'YData',y(x1(1),:));
    drawnow;
else
    delete(daqfind);
    return;
end



        