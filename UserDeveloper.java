import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // IMPORTANTE: Adicionado para ler os resultados do banco
import java.sql.SQLException;
import java.sql.Statement;

public class UserDeveloper {

    private static Connection getInternalConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:default:connection:");
    }

    // OPERAÇÃO 0: Criar a tabela nativamente pelo Java
    public static void createTableUserDeveloper() throws SQLException {
        String sql = "CREATE TABLE user_developer (" +
                     "id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, " +
                     "nome VARCHAR2(150) NOT NULL, " +
                     "telefone VARCHAR2(50), " +
                     "email VARCHAR2(50), " +
                     "stack VARCHAR2(100))";
                     
        try (Connection conn = getInternalConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }

    // OPERAÇÃO 1: Incluir um novo usuário (ID automático)
    public static void insertUser(String nome, String telefone, String email, String stack) throws SQLException {
        String sql = "INSERT INTO user_developer (nome, telefone, email, stack) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nome);
            pstmt.setString(2, telefone);
            pstmt.setString(3, email);
            pstmt.setString(4, stack);
            
            pstmt.executeUpdate();
        }
    }

    // OPERAÇÃO 2: Alterar dados de um usuário pelo ID
    public static void updateUser(int id, String nome, String telefone, String email, String stack) throws SQLException {
        String sql = "UPDATE user_developer SET nome = ?, telefone = ?, email = ?, stack = ? WHERE id = ?";
        
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nome);
            pstmt.setString(2, telefone);
            pstmt.setString(3, email);
            pstmt.setString(4, stack);
            pstmt.setInt(4, id);
            
            pstmt.executeUpdate();
        }
    }

    // OPERAÇÃO 3: Excluir um usuário pelo ID
    public static void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM user_developer WHERE id = ?";
        
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            pstmt.executeUpdate();
        }
    }

    // OPERAÇÃO 4: Consultar dados de um usuário pelo ID (Retorna String)
    public static String getUser(int id) throws SQLException {
        String sql = "SELECT id, nome, telefone, email, stack FROM user_developer WHERE id = ?";
        
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return "Dev: "+ rs.getString("id")+
                           " | Nome: "+rs.getString("nome") + 
                           " | Tel: " + rs.getString("telefone") + 
                           " | Email: " + rs.getString("email") + 
                           " | Stack: " + rs.getString("stack");
                }
                return "Desenvolvedor não encontrado para o ID: " + id;
            }
        }
    }
}
