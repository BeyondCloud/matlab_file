function [wave,lyric,param] = load_oto(which )
    if nargin == 0 
        which = 'mid';
        disp('load_oto:no argin , use mid as default')
    end
    Xia_path = 'C:\Program Files (x86)\UTAU\App\UTAU\voice\Xia_Voice_Bank_TZH';
    oto_mid = fullfile(Xia_path,which,'oto.ini');
    f = fopen(oto_mid);
    C_mid = textscan(f, '%s%f%f%f%f%f', 'delimiter',',');
    ly = C_mid{1};
    for i = 1: length(ly)
        ly_out(i) = regexp(ly{i},'(?<==)(.*)','match');
        wav_out(i) = regexp(ly{i},'(.*)(?==)','match'); 
    end
    lyric = ly_out';
    wave = wav_out';
    param = cell2mat(C_mid(2:6));
end