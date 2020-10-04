package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	/*private Connection con;  //db 연결 객체
	private ResultSet rs; // 정보를 담을 변수
	private PreparedStatement pstmt; */

	
	/*public BoardDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "apmsetup";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	String id ="XE";
	String pass="apmsetup";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//db컨넥션 사용 메소드
	public void getCon() {
		/*try {
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			con = ds.getConnection();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); //db 사용 선언
			con = DriverManager.getConnection(url, id, pass); //db 접속
			
		}catch (Exception e) {
			
			
		}
		
		
	}
	
	//게시글 작성 메소드
	public void insertBoard(BoardBean bean) {
	//	insert폼에서 지정하지 않았던 데이터들 초기화 필요
		getCon(); //db접속
		int ref = 0; //글 그룹 데이터 / 쿼리실행 > 가장 큰 ref가져옴 > 거기에 +1 더함
		int re_step = 1;
		int re_level = 1;
		
		try {
			String refsql = "select max(ref) from board"; //ref중 가장 큰값 가져오기 
			// 커리 실행 객체
			pstmt = con.prepareStatement(refsql);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과 값 있을시 
				ref = rs.getInt(1)+1; //ref에 1더함
			}
			//데이터 전체 db테이블에 저장하기
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)"; //seq있는 값 자동 매핑해줌
			pstmt = con.prepareStatement(sql);
			//?에 해당하는 값 매핑시키기
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			//쿼리 실행
			pstmt.executeUpdate();
			//자원반납
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//전체게시글 리턴 메소드
	public Vector<BoardBean> getAllBoard(int start, int end) {
		//리턴 객체 선언
		Vector<BoardBean> v = new Vector<>();
		getCon();
		
		try {
			//쿼리준비
			String sql = "select * from (select A.*, Rownum Rnum from (select * from board order by ref desc, re_step asc)A)"
					+ "where Rnum >= ? and Rnum <= ?";
			//쿼리 실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//쿼리 실행 후 저장
			rs = pstmt.executeQuery();
			//전체 데이터 갯수를 모르기에 반복문으로 전체 추출
			while(rs.next()) {
				//데이터 패키징하기 BoardBean이란 가방을 만들어 담기
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				//패키징 데이터 벡터에 넣기
				v.add(bean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//Board Info 하나의 게시글 리턴해주는 메소드
	public BoardBean getOneBoard(int num) {
		//리턴타입 선언
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			//조회수 증가 쿼리
			String readsql = "update board set readcount = readcount+1 where num=?";
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 쿼리문 ?에 num값 넣기
			//쿼리 실행 후 결과값 리턴받기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	// 답변글 작성 메소드
	public void reWriteBoard(BoardBean bean) {
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		getCon();
		
		try {
			//부모글보다 큰 re_level의 값전부 1씩 증가시킴
			String levelsql = "update board set re_level = re_level+1 where ref=? and re_level > ?";
			pstmt = con.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			pstmt.executeUpdate();
			
			String sql = "insert into board values(board_seq.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step+1);
			pstmt.setInt(7, re_level+1);
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate();
			con.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//boardUpdate용 메소드
	public BoardBean getOneUpdateBoard(int num) {
		//리턴타입 선언
		BoardBean bean = new BoardBean();
		getCon();
		
		try {
			
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 쿼리문 ?에 num값 넣기
			//쿼리 실행 후 결과값 리턴받기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	//update,delete시 비밀번호 불러오는 메소드
	public String getPass(int num) {
		//리턴할 변수 객체 선언
		String pass = "";
		
		try {
			getCon();
			String sql = "select password from board where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			//패스워드 값 저장하기
			if(rs.next()) {
				pass = rs.getString(1);
				
			}
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pass;
	}
	
		//게시글 수정 메소드
	public void updateBoard(BoardBean bean) {
		getCon();
		 try {
			String sql = "update board set subject=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());
			pstmt.executeUpdate();
			con.close();
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//게시글 삭제 메소드
	public void deleteBoard(int num) {
		getCon();
		try {
			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//전체 게시글 갯수 리턴해주는 메소드
	public int getAllCount() {
		getCon();
		int count = 0;
		try {
			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
