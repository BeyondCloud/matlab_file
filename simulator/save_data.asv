function save_data(handles)


    

    [file,path] = uiputfile('*.mat','Save to mat file');
    if file==0
        return;
    end
    fln=[path file];
    
    
    L=str2double(get(handles.L,'string'));
    n=str2double(get(handles.n,'string'));
    x=linspace(0,L,n);

      
    y=get(handles.calculate,'UserData');
    
   

    Fs=str2double(get(handles.Fs,'string'));
    dt=1/Fs;

    t=(0:size(y,1)-1)*dt;
    
    save(fln,'y','t','x','Fs');
    

  

    
