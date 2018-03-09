% load the score
addpath('./score_generate');
addpath('C:\Users\a1989\OneDrive\���\MATLAB\MATLAB_TSM-Toolbox_2.01');
    
note = load_json('foo.json');

%add Xia lib (low mid high)
addpath(genpath('C:/Program Files (x86)/UTAU/App/UTAU/voice/Xia_Voice_Bank_TZH/'))

% load the oto table
[w y p] = load_oto('mid');
mparam = oto_param_preprocess(p,44100);

%find corresponded wav segment using oto
w_tbl = cell(1,length(note));
for i = 1: length(note)
%     index =  find([y{:}] == note(i).y);
    index =  find(strcmp(y,note(i).y));
    tmp_w= load_Xia_wav(w{index},'mid');
    clip_w = partial_stretch(tmp_w,note(i).dur,mparam(index));
    w_tbl{i} =clip_w;
end