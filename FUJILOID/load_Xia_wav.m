function [y,Fs] = load_Xia_wav(wav_name, wav_dir)
    if nargin < 2
        which = 'mid';
        disp('load_Xia_wav: use mid dictionary');
    end
    wav_path= fullfile(wav_dir,wav_name);
    [y,Fs] = audioread(wav_path);
end