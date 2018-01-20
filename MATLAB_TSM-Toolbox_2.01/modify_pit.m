%x:
function final=modify_pit(x,f_tbl,target_freq)
    if size(x) ~= size(f_tbl)
        disp('error:size x != f_tbl');
        return;
    end
    clear parameter
    parameter.anaHop = 512;
    parameter.win = win(2048,1); % sin window
    parameter.filterLength = 60;
    final = modifySpectralEnvelope(target_freq./f_tbl,x,parameter);
end