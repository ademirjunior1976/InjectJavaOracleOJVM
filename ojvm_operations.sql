DROP TABLE user_developer;  

BEGIN
  ojvm0001.create_table_user_developer;
END;


BEGIN
  FOR reg IN (SELECT * FROM usuario_teste) LOOP
    ojvm0001.insert_user_developer(p_nome     => reg.nm_usuario,
                                   p_telefone => reg.ds_telefone,
                                   p_email    => reg.ds_email,
                                   p_stack    => reg.ds_stack);
  END LOOP                                 
                             

  COMMIT;                                                            
END;




SELECT *  FROM  user_developer FOR UPDATE

SELECT ojvm0001.get_user_developer(p_id => 6) FROM dual;

BEGIN
  ojvm0001.delete_user_developer(p_id => 8);
  COMMIT;
END;


BEGIN
  ojvm0001.update_user_developer(p_id       => 1,
                                 p_nome     => 'Ademir Jr',
                                 p_telefone => '+55 11 94581-6565',
                                 p_stack    => 'Java / Oracle PL/SQL / QUARKUS');
  COMMIT;                               
END;



