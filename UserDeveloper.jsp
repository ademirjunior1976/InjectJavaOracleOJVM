create or replace and compile java source named "UserDeveloper" as
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDeveloper {
    private static Connection getInternalConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:default:connection:");
    }

    public static void createTableUserDeveloper() throws SQLException {
        String sql = "CREATE TABLE user_developer (" +
                     "id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, " +
                     "name VARCHAR2(150) NOT NULL, " +
                     "phone VARCHAR2(50), " +
                     "email VARCHAR2(50), " +
                     "stack VARCHAR2(100))";
        try (Connection conn = getInternalConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }

    public static void insertUser(String name, String phone, String email, String stack) throws SQLException {
        validateNome(name);
        String sql = "INSERT INTO user_developer (name, phone, email, stack) VALUES (?, ?, ?, ?)";
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, email);
            pstmt.setString(4, stack);
            pstmt.executeUpdate();
        }
    }

    public static void updateUser(int id, String name, String phone, String email, String stack) throws SQLException {
        validateId(id);
        validateNome(name);
        String sql = "UPDATE user_developer SET name = ?, phone = ?, email = ?, stack = ? WHERE id = ?";
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, email);
            pstmt.setString(4, stack);
            pstmt.setInt(5, id);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No developer found to ID: " + id);
            }
        }
    }

    public static void deleteUser(int id) throws SQLException {
        validateId(id);
        String sql = "DELETE FROM user_developer WHERE id = ?";
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No developer found to ID: " + id);
            }
        }
    }

    public static String getUser(int id) throws SQLException {
        validateId(id);
        String sql = "SELECT id, name, phone, email, stack FROM user_developer WHERE id = ?";
        try (Connection conn = getInternalConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return "Dev: "+ rs.getString("id")+ " | Name: "+rs.getString("name") + 
                           " | Phone: " + rs.getString("phone") + " | Email: " + rs.getString("email") + 
                           " | Stack: " + rs.getString("stack");
                }
                return "No developer found to ID: " + id;
            }
        }
    }

    private static void validateNome(String nome) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException("Name must be provided !!!.");
        }
    }

    private static void validateId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("ID must be greatest than zero.");
        }
    }
}
/
