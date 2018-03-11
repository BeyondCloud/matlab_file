function [y,Fs] = load_Xia_wav(wav_name,which,Xia_path)
    if nargin < 2
        which = 'mid';
        disp('load_Xia_wav: use mid dictionary');
    end
    wav_path= fullfile(Xia_path,which,wav_name);

    [y,Fs] = audioread(wav_path);
end