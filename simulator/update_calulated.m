function update_calulated(handles)
if handles.calculated_flag
    set(handles.calculated,'visible','on');
    set(handles.not_calculated,'visible','off');
else
    set(handles.calculated,'visible','off');
    set(handles.not_calculated,'visible','on');
end