function update_f_graph(inp)
% % sinchronize line in main GUI to line in velocity GUI
% % and other
handles=inp{1}; 
ghandles=inp{2}; 
fic=inp{3}; 

friction=get(ghandles.axes4,'UserData');

hp=friction.hp;% handle to line in main GUI
hpv=fic.lineHandle;% handle to line in friction GUI


XData=get(hpv,'XData');
YData=get(hpv,'YData');

% prevent negative friction:
YData(YData<0)=0;

set(hp,'XData',XData);
set(hp,'YData',YData);

friction.markersX=fic.x;
friction.markersY=fic.y;

friction.method=fic.method;

friction.boundaryYLeft=fic.boundaryYLeft;
friction.boundaryYRight=fic.boundaryYRight;


set(ghandles.axes4,'UserData',friction);





