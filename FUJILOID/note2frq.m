function y = note2frq(note,PIT,PBS)
    note_PIT = (PIT/8192)*PBS+note;
    y = 2.^((note_PIT-69)/12)*440;
end