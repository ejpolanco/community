DECLARE

   lv_user_name        VARCHAR2 (20) := 'EPOLANCO';
   lv_req_resp_key     VARCHAR2 (50) := 'RESP_SHORT_NAME';
   lv_description      VARCHAR2 (100) := 'Adding Responsibility to user using script';
   lv_req_resp_name    VARCHAR2 (200);
   lv_appl_shrt_name   VARCHAR2 (20);
   lv_appl_name        VARCHAR2 (50);
   lv_resp_key         VARCHAR2 (50);
  
BEGIN

   SELECT fav.application_short_name,
          fav.application_id,
          frv.responsibility_key
     INTO lv_appl_shrt_name, lv_appl_name, lv_req_resp_name
     FROM fnd_application fav, fnd_responsibility frv
    WHERE frv.application_id = fav.application_id
      AND frv.responsibility_key = lv_req_resp_key;

   fnd_user_pkg.addresp (username         => lv_user_name,
                         resp_app         => lv_appl_shrt_name,
                         resp_key         => lv_req_resp_key,
                         security_group   => 'STANDARD',
                         description      => lv_description,
                         start_date       => SYSDATE,
                         end_date         => NULL
                                              );
   COMMIT;
  
   DBMS_OUTPUT.put_line ('The responsibility ' || lv_req_resp_name || ' is added to the user ' || lv_user_name);
  
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line ('Responsibility IS NOT added due to ' || SQLCODE || '; ' || SUBSTR (SQLERRM, 1, 250));
      ROLLBACK;
END;
