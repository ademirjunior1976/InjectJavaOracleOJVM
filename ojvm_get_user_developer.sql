-- Criando a ponte SQL como FUNCTION para capturar o retorno de texto
CREATE OR REPLACE FUNCTION ojvm_get_user_developer (
    p_id IN NUMBER
) 
RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'InitializeUser.getUser(int) return java.lang.String';
/
