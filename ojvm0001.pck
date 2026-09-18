CREATE OR REPLACE NONEDITIONABLE PACKAGE ojvm0001 IS
  -- Author  : Ademir Miguel Evaristo Junior
  -- Created : 19/08/2026 13:07:52
  -- Purpose : Inject java code into Oracle Database OJVM
  
  -- Public function and procedure declarations
  -- Creating the SQL bridge for your method
  PROCEDURE create_table_user_developer; --AS LANGUAGE JAVA

  -- Creating the SQL bridge for the insert operation
  PROCEDURE insert_user_developer (p_name     IN VARCHAR2, 
                                   p_phone    IN VARCHAR2,
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2);
  
  -- Creating the SQL bridge for the update operation
  PROCEDURE update_user_developer (p_id       IN NUMBER,
                                   p_name     IN VARCHAR2, 
                                   p_phone    IN VARCHAR2, 
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2);
  
  -- Creating the SQL bridge for the delete operation
  PROCEDURE delete_user_developer (p_id IN NUMBER);

  -- Creating the SQL bridge as a FUNCTION to capture the text return
  FUNCTION get_user_developer (p_id IN NUMBER) RETURN VARCHAR2;

  -- Creating the a FUNCION that will generate QRCode
  FUNCTION fnc_gerar_qrcode (p_text   IN VARCHAR2,
                             p_width  IN NUMBER,
                             p_height  IN NUMBER) RETURN BLOB;
                             
  -- Creating the running precedure                           
  PROCEDURE control(p_id_drop IN CHAR);    

END ojvm0001;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY ojvm0001 IS
  -- Private type declarations
  -- Private constant declarations
  -- Private variable declarations
  -- Function and procedure implementations
  -- Creating the SQL bridge for your method
  PROCEDURE create_table_user_developer AS LANGUAGE JAVA
    NAME 'UserDeveloper.createTableUserDeveloper()';


  -- Creating the SQL bridge for the insert operation
  PROCEDURE insert_user_developer (p_name     IN VARCHAR2, 
                                   p_phone    IN VARCHAR2,
                                   p_email    IN VARCHAR2,
                                   p_stack    IN VARCHAR2) AS LANGUAGE JAVA
    NAME 'UserDeveloper.insertUser(java.lang.String, 
                                   java.lang.String, 
                                   java.lang.String, 
                                   java.lang.String)';
  
  
  -- Creating the SQL bridge for the update operation
  PROCEDURE update_user_developer (p_id       IN NUMBER,
                                   p_name     IN VARCHAR2, 
                                   p_phone    IN VARCHAR2,
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2) AS LANGUAGE JAVA 
    NAME 'UserDeveloper.updateUser(int, 
                                   java.lang.String,
                                   java.lang.String,  
                                   java.lang.String, 
                                   java.lang.String)';
  
  
  -- Creating the SQL bridge for the delete operation
  PROCEDURE delete_user_developer (p_id IN NUMBER) AS LANGUAGE JAVA 
    NAME 'UserDeveloper.deleteUser(int)';


  -- Creating the SQL bridge as a FUNCTION to capture the text return
  FUNCTION get_user_developer (p_id IN NUMBER) RETURN VARCHAR2 AS LANGUAGE JAVA 
    NAME 'UserDeveloper.getUser(int) return java.lang.String';


  -- Creating the a FUNCION that will generate QRCode
  FUNCTION fnc_gerar_qrcode (p_text    IN VARCHAR2,
                             p_width   IN NUMBER,
                             p_height  IN NUMBER) RETURN BLOB AS LANGUAGE JAVA
    NAME 'QRCodeGenerator.generateQRCode(java.lang.String, int, int) return oracle.sql.BLOB';
 
  -- Creating the control precedure
  PROCEDURE control(p_id_drop IN CHAR) IS
    v_resultado VARCHAR2(4000);

  BEGIN
    -- 1. Create Table via Java
    
    IF UPPER(p_id_drop) = 'S' THEN 
      EXECUTE IMMEDIATE 'DROP TABLE ' || DBMS_ASSERT.ENQUOTE_NAME('user_developer');
    END IF;
    DBMS_OUTPUT.PUT_LINE('--- Creating Table ---');
    ojvm0001.create_table_user_developer;
    DBMS_OUTPUT.PUT_LINE('Table USER_DEVELOPER created successfully.');

    -- 2. Insert Record via Java
    DBMS_OUTPUT.PUT_LINE('--- Inserting Record ---');
    ojvm0001.insert_user_developer(p_name  => 'Ademir Junior',
                                   p_phone => '+55 11 99999-8888',
                                   p_email => 'ademirjunior@msn.com',
                                   p_stack => 'Oracle PL/SQL & Java');
    DBMS_OUTPUT.PUT_LINE('User inserted successfully.');
    --COMMIT;

    -- 2.1 Insert new Record via Java
    DBMS_OUTPUT.PUT_LINE('--- Inserting Record ---');
    ojvm0001.insert_user_developer(p_name  => 'Michael Bond',
                                   p_phone => '+1 768 657 8888',
                                   p_email => 'michaelbond@mb.com',
                                   p_stack => 'Oracle PL/SQL & Java');
    DBMS_OUTPUT.PUT_LINE('User inserted successfully.');
    --COMMIT;

    -- 3. Query Record via Java Function
    DBMS_OUTPUT.PUT_LINE('--- Querying Record ID: 1 ---');
    v_resultado := ojvm0001.get_user_developer(p_id => 1);
    DBMS_OUTPUT.PUT_LINE('Java Return: ' || v_resultado);

    -- 4. Update Record via Java
    DBMS_OUTPUT.PUT_LINE('--- Updating Record ID: 1 ---');
    ojvm0001.update_user_developer(p_id    => 1,
                                   p_name  => 'Ademir Junior (Especialista PL/SQL)',
                                   p_phone => '+55 11 99999-8888',
                                   p_email => 'adejr@gmail.com',
                                   p_stack => 'Oracle PL/SQL, Java OJVM & Arquitetura');
    v_resultado := ojvm0001.get_user_developer(p_id => 1);
    DBMS_OUTPUT.PUT_LINE('Updated Java Return: ' || v_resultado);
    --COMMIT;

    -- 5. Delete Record via Java
    DBMS_OUTPUT.PUT_LINE('--- Deleting Record ID: 1 ---');
    ojvm0001.delete_user_developer(p_id => 1);
    DBMS_OUTPUT.PUT_LINE('User deleted successfully.');
    
    COMMIT;
    
  END control;
END ojvm0001;
/
