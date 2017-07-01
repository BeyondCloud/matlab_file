function btn_ctrl
 % starting points:
    a = 0;
    b = 0;
    figure;
    disp('init');
    set(gcf,'userdata',0)
    set(gcf,'WindowButtonDownFcn','set(gcf,''userdata'',1)')
    set(gcf,'WindowButtonUpFcn'  ,'set(gcf,''userdata'',0)')
    hold on
    for n=length(a):-1:1
        h(n)=plot(a(n),b(n),'ro','markersize',8,'markerfacecolor','r');
        set(h(n),'ButtonDownFcn',@btnDown);
    end
    plot([-1 a 1],[0 b 0]);
    axis equal
    plot([-1 1 1 -1 -1],[1 1 -1 -1 1],'k:','color',[.8 .8 .8])%rect
    axis([-1 1 -1 1])
    uistack(h,'top')
    drawnow
function btnDown(~,~)
if ~isempty(gcbo)
    disp('btn down');
     Line1 = line([0 0], [0 0]);
    Line2 =line([0 0], [0 0]);
    plot(Line1,Line2);
    while get(gcf,'userdata')
        %update click point
        set(gcbo,'markerfacecolor','g') 
        p=get(0,'PointerLocation');%return mouse pos (ref botton left)
        pf=get(gcf,'pos');%[x y w h] (ref botton left)
        p(1:2)=p(1:2)-pf(1:2);
        set(gcf,'CurrentPoint',p(1:2))
        p=get(gca,'CurrentPoint');
        p=sign(p).*min(abs(p),1);  %limit point in rect 
        set(gcbo,'xdata',p(1,1));
        set(gcbo,'ydata',p(1,2));
        set(Line1, 'XData', [-1 p(1,1)], 'YData', [0 p(1,2)]);
        set(Line2, 'XData', [p(1,1) 1], 'YData', [p(1,2) 0]);
        axis([-1 1 -1 1])
        h=findobj(gca,'color','r');
        uistack(h,'top');
        pause(0.01);
    end
    disp('btn up');
    set(gcbo,'markerfacecolor','r','markeredgecolor','r')
end

