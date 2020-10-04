package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RentCarDAO {
/*	private Connection con;  //db 연결 객체
	private ResultSet rs; // 정보를 담을 변수
	PreparedStatement pstmt;*/
	
	/*public RentCarDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/test?serverTimezone=UTC";
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
	
	//컨넥션 풀을 이용한 db연결
	public void getCon() {
		/*try { //server.xml에서 지정한 name값 jdbc/pool을 읽기위한 인스턴스 생성과 예외처리
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
		} catch (NamingException e) {
			e.printStackTrace();
		} 
		*/
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); //db 사용 선언
			con = DriverManager.getConnection(url, id, pass); //db 접속
			
		}catch (Exception e) {
			
			
		}
		
		
	}
	
	
	//최신 데이터 가져오는 메소드
	public Vector<CarListBean> getSelectCar() {
		Vector<CarListBean> v = new Vector<>(); //리턴타입 설정
		 getCon();
		
		try {
			String sql = "select * from rentcar order by no desc";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			/*pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(); //쿼리 실행결과를 result타입으로 리턴시키기
*/			
			int count = 0;
			while(rs.next()) {
				CarListBean bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				v.add(bean); // 벡터에 데이터저장
				count++;
				if(count >2)break;
				//반복문과 조건문으로 3개 데이터만 빼냄
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		} return v;
	}
	
	
	//카테고리별 차 리스트 저장 메소드
	public Vector<CarListBean> getCategoryCar(int cate) {
		Vector<CarListBean> v = new Vector<>();
		//데이터 저장할 빈클래스
		 getCon();
		CarListBean bean = null;
		try {
			String sql = "select * from rentcar where category=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cate);
			rs = pstmt.executeQuery();
			// pstmt = con.prepareStatement(sql);
			while(rs.next()) {
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				v.add(bean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//차량 리스트 보기 메소드
	public Vector<CarListBean> getAllCar() {
		Vector<CarListBean> v = new Vector<>();
		//데이터 저장할 빈클래스
		 getCon();
		CarListBean bean = null;
		try {
			String sql = "select * from rentcar";
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//pstmt = con.prepareStatement(sql);
			while(rs.next()) {
				bean = new CarListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
				v.add(bean);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//하나의 차 정보 리턴 메소드
	public CarListBean getOneCar(int no) {
		//리턴 타입 선언
		getCon();
		CarListBean bean = new CarListBean();
		try {
			String sql = "select * from Rentcar where no=?";
			pstmt = con.prepareCall(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCategory(rs.getInt(3));
				bean.setPrice(rs.getInt(4));
				bean.setUsepeople(rs.getInt(5));
				bean.setCompany(rs.getString(6));
				bean.setImg(rs.getString(7));
				bean.setInfo(rs.getString(8));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	//db에 회원정보 있는지 비교'
	public int getMember(String id, String pass) {
		int result = 0;
		getCon();
		 try {
			String sql="select count(*) from member where id=? and pass1=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		 
		 } catch (Exception e) {
			e.printStackTrace();
		}
		 return result;
	}
	
	//예약정보 저장하는 메소드
	public void setReserveCar(CarReserveBean bean) {
		getCon();
		try {
			String sql = "insert into carreserve values(reserve_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNo());
			pstmt.setString(2, bean.getId());
			pstmt.setInt(3, bean.getQty());
			pstmt.setInt(4, bean.getDday());
			pstmt.setString(5, bean.getRday());
			pstmt.setInt(6, bean.getUsein());
			pstmt.setInt(7, bean.getUsewifi());
			pstmt.setInt(8, bean.getUseseat());
			pstmt.setInt(9, bean.getUsenavi());
			pstmt.executeUpdate();
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 회원 예약정보 불러오는 메소드
	public Vector<CarViewBean> getAllReserve(String id) {
			Vector<CarViewBean> v = new Vector<>();
			CarViewBean bean = null;
			getCon();
			try {
				String sql="select *from rentcar natural join carreserve where sysdate < to_date(rday, 'YYYY-MM-DD') and id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new CarViewBean();
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(4));
				bean.setImg(rs.getString(7));
				bean.setQty(rs.getInt(11));
				bean.setDday(rs.getInt(12));
				bean.setRday(rs.getString(13));
				bean.setUsein(rs.getInt(14));
				bean.setUsewifi(rs.getInt(15));
				bean.setUseseat(rs.getInt(16));
				bean.setUsenavi(rs.getInt(17));
				v.add(bean);
			}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return v;
	}
	
	//예약 삭제 메소드
	public void carRemoveReserve(String id, String rday) {
		getCon();
		try {
			String sql = "delete from carreserve where id=? and rday=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, rday);
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}