DECLARE
   l_lookup_type           VARCHAR2 (250);
   l_lookup_code           VARCHAR2 (250);
   l_enabled_flag          VARCHAR2 (250);
   l_security_group_id     NUMBER;
   l_view_application_id   NUMBER;
   l_tag                   VARCHAR2 (250);
   l_meaning               VARCHAR2 (250);

   CURSOR c1
   IS
      SELECT lookup_type,
             lookup_code,
             enabled_flag,
             security_group_id,
             view_application_id,
             tag,
             meaning
        FROM fnd_lookup_values_vl
       WHERE lookup_type = 'LEAV_REAS'
             AND meaning IN
                    ('Disciplinary', 'Dismissed', 'Employee Transfer');
BEGIN
   FOR i IN c1
   LOOP
      BEGIN
         fnd_lookup_values_pkg.
          update_row (x_lookup_type           => i.lookup_type,
                      x_security_group_id     => i.security_group_id,
                      x_view_application_id   => i.view_application_id,
                      x_lookup_code           => i.lookup_code,
                      x_tag                   => i.tag,
                      x_attribute_category    => NULL,
                      x_attribute1            => NULL,
                      x_attribute2            => NULL,
                      x_attribute3            => NULL,
                      x_attribute4            => NULL,
                      x_enabled_flag          => 'N',
                      x_start_date_active     => NULL,
                      x_end_date_active       => NULL,
                      x_territory_code        => NULL,
                      x_attribute5            => NULL,
                      x_attribute6            => NULL,
                      x_attribute7            => NULL,
                      x_attribute8            => NULL,
                      x_attribute9            => NULL,
                      x_attribute10           => NULL,
                      x_attribute11           => NULL,
                      x_attribute12           => NULL,
                      x_attribute13           => NULL,
                      x_attribute14           => NULL,
                      x_attribute15           => NULL,
                      x_meaning               => i.meaning,
                      x_description           => NULL,
                      x_last_update_date      => TRUNC (SYSDATE),
                      x_last_updated_by       => fnd_global.user_id,
                      x_last_update_login     => fnd_global.user_id);

         COMMIT;

         dbms_output_line (i.lookup_code || ' has been Updated  !!!!');
      EXCEPTION
         WHEN OTHERS
         THEN
            dbms_output_line (
               i.lookup_code || ' - Inner Exception - ' || SQLERRM);
      END;
   END LOOP;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Main Exception: ' || SQLERRM);

END;