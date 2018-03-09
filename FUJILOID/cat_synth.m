% load the score
addpath('./score_generate');
note = load_json('data.json');
% load the oto table
[w y p] = load_oto('mid');
oto_param_preprocess(p,44100);
%add Xia voice dictionary to path 

%find corresponded wav segment using oto
for i = 1: length(note)
%     index =  find([y{:}] == note(i).y);
    index =  find(strcmp(y,note(i).y))

end