create or replace package ojvm0001 is

  -- Author  : Ademir Miguel Evaristo Junior
  -- Created : 19/08/2026 13:07:52
  -- Purpose : Inject java code into Oracle Database OJVM
  
  -- Public function and procedure declarations

  -- Criando a ponte SQL para o seu método em inglês
  PROCEDURE create_table_user_developer; --AS LANGUAGE JAVA
    --NAME 'UserDeveloper.createTableUserDeveloper()';

  -- Criando a ponte SQL para a operação de inclusão
  PROCEDURE insert_user_developer (p_nome     IN VARCHAR2, 
                                   p_telefone IN VARCHAR2,
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2); --IS --AS LANGUAGE JAVA
    --NAME 'InitializeUser.insertUser(java.lang.String, 
    --                                java.lang.String, 
    --                                java.lang.String)';
  
  -- Criando a ponte SQL para a operação de alteração
  PROCEDURE update_user_developer (p_id       IN NUMBER,
                                   p_nome     IN VARCHAR2, 
                                   p_telefone IN VARCHAR2, 
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2); --AS LANGUAGE JAVA 
    --NAME 'InitializeUser.updateUser(int, 
    --                                java.lang.String, 
    --                                java.lang.String, 
    --                                java.lang.String)';
  
  -- Criando a ponte SQL para a operação de exclusão
  PROCEDURE delete_user_developer (p_id IN NUMBER); -- AS LANGUAGE JAVA 
    --NAME 'InitializeUser.deleteUser(int)';


  -- Criando a ponte SQL como FUNCTION para capturar o retorno de texto
  FUNCTION get_user_developer (p_id IN NUMBER) RETURN VARCHAR2; -- AS LANGUAGE JAVA 
  --NAME 'InitializeUser.getUser(int) return java.lang.String';


end ojvm0001;
/
CREATE OR REPLACE PACKAGE BODY ojvm0001 IS

  -- Private type declarations
  -- Private constant declarations
  -- Private variable declarations
  -- Function and procedure implementations

  -- Criando a ponte SQL para o seu método em inglês
  PROCEDURE create_table_user_developer AS LANGUAGE JAVA
    NAME 'UserDeveloper.createTableUserDeveloper()';

  -- Criando a ponte SQL para a operação de inclusão
  PROCEDURE insert_user_developer (p_nome     IN VARCHAR2, 
                                   p_telefone IN VARCHAR2,
                                   p_email    IN VARCHAR2,
                                   p_stack    IN VARCHAR2) AS LANGUAGE JAVA
    NAME 'UserDeveloper.insertUser(java.lang.String, 
                                   java.lang.String, 
                                   java.lang.String, 
                                   java.lang.String)';
  
  -- Criando a ponte SQL para a operação de alteração
  PROCEDURE update_user_developer (p_id       IN NUMBER,
                                   p_nome     IN VARCHAR2, 
                                   p_telefone IN VARCHAR2,
                                   p_email    IN VARCHAR2, 
                                   p_stack    IN VARCHAR2) AS LANGUAGE JAVA 
    NAME 'UserDeveloper.updateUser(int, 
                                   java.lang.String,
                                   java.lang.String,  
                                   java.lang.String, 
                                   java.lang.String)';
  
  -- Criando a ponte SQL para a operação de exclusão
  PROCEDURE delete_user_developer (p_id IN NUMBER) AS LANGUAGE JAVA 
    NAME 'UserDeveloper.deleteUser(int)';


  -- Criando a ponte SQL como FUNCTION para capturar o retorno de texto
  FUNCTION get_user_developer (p_id IN NUMBER) RETURN VARCHAR2 AS LANGUAGE JAVA 
    NAME 'UserDeveloper.getUser(int) return java.lang.String';


BEGIN
  NULL;
END ojvm0001;
/
