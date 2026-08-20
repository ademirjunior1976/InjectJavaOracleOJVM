-- Criando a ponte SQL para a operação de inclusão
CREATE OR REPLACE PROCEDURE ojvm_insert_user_developer (
    p_nome IN VARCHAR2, 
    p_telefone IN VARCHAR2, 
    p_stack IN VARCHAR2
)
AS LANGUAGE JAVA
NAME 'InitializeUser.insertUser(java.lang.String, java.lang.String, java.lang.String)';
/
