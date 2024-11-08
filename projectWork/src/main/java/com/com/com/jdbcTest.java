package com.com.com;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbcTest {
    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@192.168.0.5:1521:XE";
        String username = "giantstudy";
        String password = "gs123";
        String driverClass = "oracle.jdbc.driver.OracleDriver";
        
        Connection connection = null;

        try {
            // JDBC 드라이버 로드
            Class.forName(driverClass);
            // 데이터베이스 연결
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("연결 성공!");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver 못찾음: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("연결 실패: " + e.getMessage());
        } finally {
            // 연결 해제
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("연결 해제: " + e.getMessage());
                }
            }
        }
    }
}
