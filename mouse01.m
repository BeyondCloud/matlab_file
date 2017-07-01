function mouse01(action)
clc;
if nargin<1, action='start'; end
switch(action)
	case 'start'
		axis([0 1 0 1]);
		box on;
		title('Click and drag your mouse in this window!');
		set(gcf, 'WindowButtonDownFcn', 'mouse01 down');
	case 'down'	
		set(gcf, 'WindowButtonMotionFcn', 'mouse01 move');
		set(gcf, 'WindowButtonUpFcn', 'mouse01 up');
		fprintf('Mouse down!\n');
	case 'move'
		currPt = get(gca, 'CurrentPoint');
		x = currPt(1,1);
		y = currPt(1,2);
		line(x, y, 'marker', '.');
		fprintf('Mouse is moving! Current location = (%g, %g)\n', x, y);
	case 'up'
		set(gcf, 'WindowButtonMotionFcn', '');
		set(gcf, 'WindowButtonUpFcn', '');
		fprintf('Mouse up!\n');
end