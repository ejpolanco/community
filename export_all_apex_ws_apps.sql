declare
   lv_file_name   varchar2(255);
   lt_ex_files    apex_t_export_files;
   lb_zip         blob;
   lt_zip_files   apex_zip.t_files;   
BEGIN
   for reg in (select application_id
                 from apex_applications 
                where workspace = 'MY_WORKSPACE')
   loop
      begin
         lt_ex_files := apex_export.get_application( p_application_id          => reg.application_id
                                                   , p_with_ir_public_reports  => true  
                                                   , p_with_ir_private_reports => true);
                                            
         apex_zip.add_file( p_zipped_blob => lb_zip
                          , p_file_name   => reg.application_id||'.sql'
                          , p_content     => lt_ex_files(1).contents);
   
      EXCEPTION
      WHEN OTHERS THEN
        apex_zip.finish(p_zipped_blob => lb_zip);
         dbms_output.put_line(sqlerrm);
      end;
   end loop;
   apex_zip.finish(p_zipped_blob => lb_zip);
EXCEPTION
WHEN OTHERS THEN
   apex_zip.finish(p_zipped_blob => lb_zip);
   dbms_output.put_line(sqlerrm);
END;
/

