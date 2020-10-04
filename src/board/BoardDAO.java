package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
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

	

	public String getDate() {
		try {
			getCon();
			String SQL = "SELECT GETDATE()";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		try {
			getCon();
			String SQL = "SELECT board2.*FROM (SELECT board2.* FROM board2 ORDER BY boardID DESC) board2 WHERE ROWNUM <= 10";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 게시물 오류시
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류시
	}
	
	public int write(String boardTitle, String userID, String boardContent) {
		try {
			getCon();
			String SQL = "INSERT INTO board2 VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);			
				return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류시
	}
	
	public ArrayList<Board> getList(int pageNumber) {
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			getCon();
			String SQL = "SELECT * FROM (SELECT board2.*, ROW_NUMBER() OVER(ORDER BY boardID DESC) AS RNO FROM board2) WHERE RNO <= 10";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailabe(rs.getInt(6));
				list.add(board);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	public boolean nextPage (int pageNumber) { //페이징 처리 함수
		String SQL = "SELECT * FROM board2 WHERE boardID < ? AND boardAvailabe = 1";
		try {
			getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			return true;	
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	public Board getBbs(int boardID) {
		String SQL = "SELECT * FROM board2 WHERE boardID = ?";
		try {
			getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailabe(rs.getInt(6));
				return board;
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int boardID, String boardTitle, String boardContent) {
		String SQL = "UPDATE BOARD2 SET boardTitle = ?, boardContent = ? WHERE boardID = ?";
		try {
			getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류시
	}
	
	public int delete(int boardID) {
		String SQL = "UPDATE BOARD2 SET boardAvailabe = 0 WHERE boardID = ?";
		try {
			getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, boardID);			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류시
	}
	
	
}