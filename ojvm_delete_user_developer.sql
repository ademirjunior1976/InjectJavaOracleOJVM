-- Criando a ponte SQL para a operação de exclusão
CREATE OR REPLACE PROCEDURE ojvm_delete_user_developer (
    p_id IN NUMBER
)
AS LANGUAGE JAVA
NAME 'InitializeUser.deleteUser(int)';
/
