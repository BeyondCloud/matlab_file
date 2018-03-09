function [y,Fs] = load_Xia_wav(wav_name, which)
    if nargin < 2
        which = 'mid';
        disp('load_Xia_wav: use mid dictionary');
    end
    Xia_path = 'C:\Program Files (x86)\UTAU\App\UTAU\voice\Xia_Voice_Bank_TZH';
    wav_path= fullfile(Xia_path,which,wav_name);
    [y,Fs] = audioread(wav_path);
end