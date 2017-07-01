function update_v_graph(inp)
% sinchronize line in main GUI to line in velocity GUI
% and other
handles=inp{1}; 
ghandles=inp{2}; 
vic=inp{3}; 

velocity=get(ghandles.axes2,'UserData');

hp=velocity.hp;% handle to line in main GUI
hpv=vic.lineHandle;% handle to line in velocity GUI

XData=get(hpv,'XData');
YData=get(hpv,'YData');

set(hp,'XData',XData);
set(hp,'YData',YData);

velocity.markersX=vic.x;
velocity.markersY=vic.y;

velocity.method=vic.method;

set(ghandles.axes2,'UserData',velocity);





