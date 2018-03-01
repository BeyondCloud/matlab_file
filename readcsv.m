fid = fopen('test.csv');
C = textscan(fid, '%s%f%f%f',  'delimiter',',');
utta = char(C{1});
keys = {'a','i','u','e'};
wav_path =   {'a.wav', 'i.wav', '', 'Apr'};
for i = 1:4
    switch(utta)
       
end