-- Criando a ponte SQL para a operação de alteração
CREATE OR REPLACE PROCEDURE ojvm_update_user_developer (
    p_id IN NUMBER,
    p_nome IN VARCHAR2, 
    p_telefone IN VARCHAR2, 
    p_stack IN VARCHAR2
)
AS LANGUAGE JAVA
NAME 'InitializeUser.updateUser(int, java.lang.String, java.lang.String, java.lang.String)';
/
