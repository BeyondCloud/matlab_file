function set_calc_false(handles)
%if handles.calculated_flag
if strcmpi(get(handles.calculated,'visible'),'on')
    handles.calculated_flag=false; % not usefull becuase handles is copy of stucture then original structure vill be not updated
        
    update_calulated(handles);
end
