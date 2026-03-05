declare                      
  lf_file utl_file.file_type; 
  lv_line varchar2(5000);
BEGIN
  lf_file := utl_file.fopen('MY_DIRECTORY','my_file.txt', 'r'); 
    loop 
      begin 
        utl_file.get_line(lf_file, lv_line); 
        dbms_output.put_line(lv_line);
          exception  when others then 
        dbms_output.put_line( '[****'||sqlerrm||'******]');
        exit;
       end; 
    end loop; 
  utl_file.fclose(lf_file); 
end;