package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	String id ="XE";
	String pass="apmsetup";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getCon() {
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver"); //db 사용 선언
		con = DriverManager.getConnection(url, id, pass); //db 접속
		
	}catch (Exception e) {
		
		
	}
	
	
}
	
	public int login(String userID, String userPassword) { //로그인 메서드
		try {
			getCon();
			String SQL = "SELECT userPassword FROM USER2 WHERE userID = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) 
					return 1; // 로그인 성공
					else
						return 0; // 비밀번호 틀릴경우
				}
			return -1;	//아이디 없을경우	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;  //db오류일경우
	}
	
	public int join(User user) {
		try {
			getCon();
			String SQL = "INSERT INTO USER2 VALUES (?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
