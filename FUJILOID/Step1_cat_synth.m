% load the score
addpath('./score_generate');
addpath('C:\Users\a1989\OneDrive\¤å¥ó\MATLAB\MATLAB_TSM-Toolbox_2.01');

score = load_json('foo.json');

%add Xia lib (low mid high)
Xia_path = 'C:\Program Files (x86)\UTAU\App\UTAU\voice\Xia_Voice_Bank_TZH';
addpath(genpath(Xia_path));

% load the oto table
[w y p] = load_oto('mid');
mparam = oto_param_preprocess(p,44100);

%find corresponded wav segment using oto
w_tbl = cell(1,length(score.note));
for i = 1: length(score.note)
%     index =  find([y{:}] == note(i).y);
    index =  find(strcmp(y,score.note(i).y));
    if isempty(index)
        error(' \"%s\" is illegal lyric',score.note(i).y{1});
    end
    tmp_w= load_Xia_wav(w{index},'mid',Xia_path);
    clip_w = partial_stretch(tmp_w,score.note(i).dur,mparam(index));
    w_tbl{i} =clip_w;
end

disp('done');