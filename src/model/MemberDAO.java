package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	String id ="XE";
	String pass="apmsetup";
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	
	Connection con; //db에 접근해주는 객체
	PreparedStatement pstmt; //db에 쿼리 실행시키는 객체
	ResultSet rs; //db테이블 결과 리턴 후 자바에 저장하는 객체
	
	
	//DB접속할 메소드 생성
	//crud 메소드 작성시마다 db접속을 위해 사용해야하므로 메소드로 만들어 편하게 사용하기 위함
	public void getCon() {
		
		//컨넥션풀로 접속하기
		/*
		try {
			//외부에서 데이터 읽기위해 
			Context initctx = new InitialContext();
			//톰캣 서버 정보 담아놓은 곳으로 이동
			Context envctx = (Context) initctx.lookup("java:comp/env");
			//데이터 소스 객체선언
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
		
		public void insertMember(MemberBean mbean) { //mbean에 데이터를 받아 저장	
			try {
				getCon();//접속
				//접속 후 쿼리준비
				String sql = "insert into member values(?,?,?,?,?,?,?,?)";
				//JSP에서 쿼리사용하도록 설정
				PreparedStatement pstmt = con.prepareStatement(sql);
				// ??에 맞게 데이터 맵핑
				pstmt.setString(1, mbean.getId());
				pstmt.setString(2, mbean.getPass1());
				pstmt.setString(3, mbean.getEmail());
				pstmt.setString(4, mbean.getTel());
				pstmt.setString(5, mbean.getHobby());
				pstmt.setString(6, mbean.getJob());
				pstmt.setString(7, mbean.getAge());
				pstmt.setString(8, mbean.getInfo());
				
				
				pstmt.executeUpdate(); //오라클에서 쿼리 실행
				
				con.close(); //자원반납
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		//회원정보 리턴해주는 메소드
		public Vector<MemberBean> allSelectMember() {
			Vector<MemberBean> v = new Vector<>();
		
			
			//db연결시 접속끊김 등의 예외가 발생할수있기에 예외처리 필수
			//입출력,db,스레드,네트워크 관련해서는 무조건 예외처리 해야함
			try {
				getCon(); //db접속하기
				//쿼리준비
				String sql = "select * from member";
				//쿼리 실행을 위한 객체 선언
				pstmt = con.prepareStatement(sql);
				//쿼리 실행 결과 리턴해서 받아오기
				rs = pstmt.executeQuery();
				//반복문으로 결과값 rs추출하기
				while(rs.next()) { //rs.next 저장된 결과만큼 반복문 돌리기
					MemberBean bean = new MemberBean(); //칼럼으로 나누어진 데이터 bean에 저장
					bean.setId(rs.getString(1));
					bean.setPass1(rs.getString(2));
					bean.setEmail(rs.getString(3));
					bean.setTel(rs.getString(4));
					bean.setHobby(rs.getString(5));
					bean.setJob(rs.getString(6));
					bean.setAge(rs.getString(7));
					bean.setInfo(rs.getString(8));
					//패키징된 memberBean클래스 벡터에 저장
					v.add(bean);
				}
					con.close();
				
				
			} catch (Exception e) {
				e.printStackTrace();

			}
			
			//저장된 벡터를 리턴해줌
			return v;
		
	}
		
		//한사람의 정보 리턴해주는 메소드
		public MemberBean oneSelectMember(String id) {
			// 한사람에 대한 정보만 리턴해주기 위해 빈객체 생성
			MemberBean bean = new MemberBean();
			
			try {
				getCon();
				String sql="select * from member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) { //조건문으로 데이터 받아오기 / 회원정보가 있다면 불러오는 조건
					bean.setId(rs.getString(1));
					bean.setPass1(rs.getString(2));
					bean.setEmail(rs.getString(3));
					bean.setTel(rs.getString(4));
					bean.setHobby(rs.getString(5));
					bean.setJob(rs.getString(6));
					bean.setAge(rs.getString(7));
					bean.setInfo(rs.getString(8));
				}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return bean;
			}
		
		//한 회원의 패스워드를 리턴하는 메소드
		public String getPass(String id) {
			
			//스트링으로 리턴해야하기에 스트링 변수선언
			String pass="";
			
			try {
				getCon();
				String sql="select pass1 from member where id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pass = rs.getString(1); //매핑한 1번값을 pass에 저장
			}
			con.close();
			} catch (Exception e) {
				e.printStackTrace();
			} 
	
		return pass;
		}
		
		
		//회원정보 수정 메소드
		public void updateMember(MemberBean bean) {
			
			getCon();
			
			try {
			String sql = "update member set email=?, tel=? where id=?";
				pstmt = con.prepareStatement(sql);
				System.out.println(sql);
				pstmt.setString(1, bean.getEmail());
				pstmt.setString(2, bean.getTel());
				pstmt.setString(3, bean.getId());
				System.out.println(bean);
				pstmt.executeUpdate(); //쿼리실행
				
				con.close();
				
				
			} catch (Exception e) {
			e.printStackTrace();
			}
			
		}
		
		//회원삭제 메소드
		public void deleteMember(String id) {
			getCon();
			
			try {
				String sql = "delete from member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate(); //쿼리실행
				
				con.close();
				
				
			} catch (Exception e) {
			e.printStackTrace();
				
			}
			
			
		}
		
}
