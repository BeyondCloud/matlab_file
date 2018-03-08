% To query Nth data:
% val(2).y
function val = load_json(fname)
    fid = fopen(fname); 
    raw = fread(fid,inf); 
    str = char(raw'); 
    fclose(fid); 
    val = jsondecode(str);
end

