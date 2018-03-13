function y = note2frq(note,PIT,PBS)
    note_PIT = (PIT/8192)*PBS+note;
    y = 2.^((note_PIT-64)/12)*440;
end