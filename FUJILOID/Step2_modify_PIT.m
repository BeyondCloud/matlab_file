% x = vertcat(w_tbl{:});
ini_P = 0;
ini_S = 6;
cc_i = 1;
while str2double(score.cc(cc_i).t{1}) == 0
    switch(score.cc(cc_i).ID{1})
        case 'S'
            ini_S = str2double(score.cc(cc_i).val{1});
        case 'P'
            ini_P = str2double(score.cc(cc_i).val{1});
    end
    cc_i=cc_i+1;
    if cc_i>length(score.cc)
        break
    end
end

for i = 1:4
%     x = pit_norm(w_tbl{1},311.2);
    
    cur_n =  str2double(score.note(i).n{1});
    note_end = str2double(score.note(i).t{1})+...
        str2double(score.note(i).dur{1})-1;
    
    frq  = note2frq(cur_n,ini_P,ini_S);
    t_tbl = [1];
    f_tbl = [frq];
    if cc_i<length(score.cc)
        ini_t = str2double(score.cc(cc_i).t{1});
    end
    while str2double(score.cc(cc_i).t{1})<note_end

        %batch all same time cc         
        while  cc_i<length(score.cc)
            switch(score.cc(cc_i).ID{1})
                case 'S'
                    ini_S = str2double(score.cc(cc_i).val{1});
                case 'P'
                    ini_P = str2double(score.cc(cc_i).val{1});
            end
            cc_i=cc_i+1;
            if str2double(score.cc(cc_i).t{1}) == ini_t
                continue;
            else
                break;
            end
        end
        frq  = note2frq(cur_n,ini_P,ini_S);
        t_tbl = [t_tbl str2double(score.cc(cc_i).t{1})-...
                       str2double(score.note(i).t{1})];
        f_tbl = [f_tbl frq];
        disp(i);
        disp(t_tbl);
        disp(f_tbl);
    end
end
param.sr = 44100;
% yin_f0(x,param);

% end