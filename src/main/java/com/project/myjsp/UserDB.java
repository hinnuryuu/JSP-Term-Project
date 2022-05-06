package com.project.myjsp;


import java.sql.*;

public class UserDB {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/userinfo?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useUnicode=true";
    static final String USER = "root";
    static final String PASS = "123456";
    Connection conn = null;
    Statement stmt = null;

    private void connect() throws SQLException, ClassNotFoundException {
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    }

    private void disconnect() throws SQLException {
        stmt.close();
        conn.close();
    }

    public void insert(User user) throws SQLException, ClassNotFoundException {
        connect();
        String sql = "insert into user_data values( '" + user.getId() + "','" + user.getPwd() + "','" + user.getGender() + "'," + user.getAge() + ",'" + user.getEmail() + "'," + user.getAdmin() + ")";
        int rs = stmt.executeUpdate(sql);
        disconnect();
    }

    public void delete(User user) throws SQLException, ClassNotFoundException {
        connect();
        String email = user.getEmail();
        String sql = "delete from user_data where email= '" + email + "'";
        int rs = stmt.executeUpdate(sql);
        disconnect();
    }

    public void update(User user, String id, String password, String gender, int age, String email) throws SQLException, ClassNotFoundException {
        connect();
        String sql = "update user_data set id='" + id + "',pwd='" + password + "',gender='" + gender + "',email='" + email + "',age=" + age + " where email='" + user.getEmail() + "'";
        int rs = stmt.executeUpdate(sql);
        disconnect();
    }

    public boolean existUser(String email) throws SQLException, ClassNotFoundException {
        connect();
        String sql = "select * from user_data where email='" + email + "'";
        ResultSet rs = stmt.executeQuery(sql);
        rs.last();
        int row = rs.getRow();
        rs.close();
        disconnect();
        return row != 0;
    }

    public boolean checkRightUser(String email, String password) throws SQLException, ClassNotFoundException {
        connect();
        String sql = "select * from user_data where email='" + email + "' and pwd='" + password + "'";
        ResultSet rs = stmt.executeQuery(sql);
        rs.last();
        int row = rs.getRow();
        rs.close();
        disconnect();
        return row != 0;
    }

    public User searchByEmail(String email) {
        try {
            connect();
            String sql = "select * from user_data where email='" + email + "'";
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            User user = new User(rs.getString("id"), rs.getString("pwd"), rs.getString("gender"), rs.getInt("age"), rs.getString("email"), rs.getInt("admin"));
            disconnect();
            return user;
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public User searchByEmailPassword(String email, String password) {
        try {
            connect();
            String sql = "select * from user_data where email='" + email + "' and pwd='" + password + "'";
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            if (rs.getRow() == 0) return null;
            User user = new User(rs.getString("id"), rs.getString("pwd"), rs.getString("gender"), rs.getInt("age"), rs.getString("email"), rs.getInt("admin"));
            disconnect();
            return user;
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    public void switchAuthority(User user,int admin) throws SQLException, ClassNotFoundException {
        connect();
        String sql = "update user_data set admin="+admin+" where email='"+ user.getEmail() +"'";
        int rs = stmt.executeUpdate(sql);
        disconnect();
    }
}
