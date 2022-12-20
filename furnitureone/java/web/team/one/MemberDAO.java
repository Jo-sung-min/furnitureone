package web.team.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection getConnection() throws NamingException, SQLException {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	//회원 가입 처리 메서드 1
	public void insertMemeber(MemberDTO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into member values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, 0, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMid());
			pstmt.setString(2, member.getMimg());
			pstmt.setString(3, member.getMpw());
			pstmt.setString(4, member.getMname());
			pstmt.setString(5, member.getMtel());
			pstmt.setString(6, member.getMemail());
			pstmt.setString(7, member.getMtype());
			int result = pstmt.executeUpdate();
			System.out.println("insert member result : "+result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
	}
	//Mnum 가져오는 메서드
	public int getMnum(String id) {
		int mnum = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
	        String sql = "select mnum from member where mid=?"; 
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery(); 
	        
	        if(rs.next()) {
	        	mnum = rs.getInt(1);
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(Exception e) { e.printStackTrace(); }
	        if(pstmt != null) try{ pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
	        if(conn != null) try{ conn.close(); }catch(Exception e) { e.printStackTrace(); }
	    }
	    return mnum;
	}
	//회원 가입 처리 메서드 2 
	public void insertAddress(AddressDTO address, int Mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into address values(address_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Mnum);
			pstmt.setString(2, address.getMaddr()); 
			int result = pstmt.executeUpdate();
			
			System.out.println("insert member result : "+result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
	}
	//로그인 처리 :id, pw 체크
	public int idPwCheck(String mid, String mpw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//사용자가 작성한 id와 동일한 id값이 DB에 있는 꺼내오기
			String sql = "select mid from member where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "select count(*) from member where mid=? and mpw=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setString(2, mpw);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1); //비번맞으면 1, 안맞으면 0
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	// 회원 한명 정보 가져오는 메서드 
	public MemberDTO getMember(int mnum) {
		MemberDTO member = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from member where mnum=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과가 있으면 
				member = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
				member.setMid(rs.getString("mid"));
				member.setMpw(rs.getString("mpw"));
				member.setMname(rs.getString("mname"));
				member.setMemail(rs.getString("memail"));
				member.setMreg(rs.getTimestamp("mreg"));
				member.setMimg(rs.getString("mimg"));
				member.setMtel(rs.getString("mtel"));
				member.setMtype(rs.getString("mtype"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return member; 
	}
	// 회원 정보 수정 메서드
	public int updateMember(MemberDTO member) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update member set mimg=?, mpw=?, mtel=?, memail=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMimg());
			pstmt.setString(2, member.getMpw());
			pstmt.setString(3, member.getMtel());
			pstmt.setString(4, member.getMemail());
			pstmt.setString(5, member.getMid());
			result = pstmt.executeUpdate(); // 잘되면 리턴1, 잘안되면 리턴0 
			System.out.println("update result : "+result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return result; 
	}
	//id 중복 확인 메서드
	public boolean confirmId(String mid) {
		boolean result = false;
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from member where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
				System.out.println("mid : "+mid);
				System.out.println("count : "+count);
				if(count == 1 ) {
					result = true;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return result; //result == true 이미 존재, result == false 존재하지 않는다
	}
	//id 찾기
	public MemberDTO idfind(String mname, String memail) {
		//String result = null;
		MemberDTO member = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		try {
			conn = getConnection();
			//사용자가 작성한 mname와 동일한 memail값이 DB에 있는 꺼내오기
			String sql = "select mid from member where mname=? and memail=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mname);
			pstmt.setString(2, memail);
			rs = pstmt.executeQuery();
				
			if(rs.next()) {
				System.out.println("111111");
				//result = rs.getString("mid");
				member = new MemberDTO(); 
				member.setMid(rs.getString("mid"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		//System.out.println("mid "+result);
		System.out.println("mid "+member.getMid());
		//return result;
		return member;
	}
	//pw 찾기
	public MemberDTO pwfind(String mid, String memail) {
		//String result = null;
		MemberDTO member = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		try {
			conn = getConnection();
			//사용자가 작성한 mid와 동일한 memail값이 DB에 있는 꺼내오기
			String sql = "select mpw from member where mid=? and memail=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, memail);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("111111");
				//result = rs.getString("mid");
				member = new MemberDTO(); 
				member.setMpw(rs.getString("mpw"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		//System.out.println("mid "+result);
		System.out.println("mpw "+member.getMpw());
		//return result;
		return member;
	}		
	//계정 정지
	public void memberStop(int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
			
		try {
			conn = getConnection();
			String sql="update member set mcon=1 where mnum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.executeUpdate();
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	
	public void sellerStop(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql="update product set pcon=1 where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	
	
	/* 지훈 --------------------------------------------------------------------------------- */
	//맴버 가져오는 메서드
		public List<MemberDTO> getMembers(int pnum){
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<MemberDTO> list = null;
			
			try {
				conn = getConnection();
				String sql = "select * from member where Mnum=? ";
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, pnum);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<MemberDTO>();
					do {
						//결과 있으니까 객체생성해서 담아주기
						MemberDTO member = new MemberDTO();
						member.setMnum(rs.getInt("Mnum"));
						member.setMid(rs.getString("mid"));
						member.setMimg(rs.getString("mimg"));
						member.setMpw(rs.getString("mpw"));
						member.setMname(rs.getString("mname"));
						member.setMtel(rs.getString("mtel"));
						member.setMemail(rs.getString("memail"));
						member.setMtype(rs.getString("type"));
						member.setMcon(rs.getInt("mcon"));
						member.setMreg(rs.getTimestamp("mreg"));
						list.add(member);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}
	//해당 페이지에 띄워줄 글 가져오기
		public List<MemberDTO> getArticles(int scon, int start , int end ) {
			List<MemberDTO> list = null;
			Connection conn =null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn=getConnection();
				String sql ="select B.* from (select rownum r, A.* from "
						+ "(select * from member where mcon=? order by mreg desc ) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, scon);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {	// 결과 있는지 체크 *+ 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList<MemberDTO>();	// 저장공간 생성 (결과없으면 저장공간도 차지하지않게하겠다.)   					
					
					do {
						MemberDTO article = new MemberDTO();
						
						article.setMnum(rs.getInt("mnum"));
						article.setMid(rs.getString("mid"));
						article.setMimg(rs.getString("mimg"));
						article.setMpw(rs.getString("mpw"));
						article.setMname(rs.getString("mname"));
						article.setMtel(rs.getString("mtel"));
						article.setMemail(rs.getString("memail"));
						article.setMtype(rs.getString("mtype"));
						article.setMcon(rs.getInt("mcon"));
						article.setMreg(rs.getTimestamp("mreg"));
						
						list.add(article);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
			 if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	        if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	        if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}
		public List getBuyers() {
			List list = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO buyer = null;
			try {
				conn = getConnection(); 
				String sql = "select * from member where mtype='buyer'"; 
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과가 있으면 
					list = new ArrayList();
					do {
						buyer = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
						buyer.setMnum(rs.getInt("mnum"));
						buyer.setMid(rs.getString("mid"));
						buyer.setMpw(rs.getString("mpw"));
						buyer.setMname(rs.getString("mname"));
						buyer.setMemail(rs.getString("memail"));
						buyer.setMreg(rs.getTimestamp("mreg"));
						buyer.setMimg(rs.getString("mimg"));
						buyer.setMtel(rs.getString("mtel"));
						buyer.setMtype(rs.getString("mtype"));
						
						list.add(buyer);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			
			return list;
		}
		public List getSellers() {
			List mnumList = null;
			List memList = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			int mnum = 0;
			try {
				conn = getConnection(); 
				String sql ="select mnum from sellregis where scon=1";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				mnumList = new ArrayList();
				if(rs.next()) {
					do {
						mnum = rs.getInt(1);
						mnumList.add(mnum);
					}while(rs.next());
				}
				
				sql = "select * from member where mnum=?"; 
				pstmt = conn.prepareStatement(sql);
				memList = new ArrayList();
				for(int i = 0; i<mnumList.size();i++) {
					pstmt.setInt(1, (int)mnumList.get(i));
					rs = pstmt.executeQuery();
					if(rs.next()) { // 결과가 있으면 
						do {
							seller = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
							seller.setMnum(rs.getInt("mnum"));
							seller.setMid(rs.getString("mid"));
							seller.setMpw(rs.getString("mpw"));
							seller.setMname(rs.getString("mname"));
							seller.setMemail(rs.getString("memail"));
							seller.setMreg(rs.getTimestamp("mreg"));
							seller.setMimg(rs.getString("mimg"));
							seller.setMtel(rs.getString("mtel"));
							seller.setMtype(rs.getString("mtype"));
							
							memList.add(seller);
						}while(rs.next());
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return memList;
		}
		
		public int getSelMemCount() {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			int count = 0;
			try {
				conn = getConnection(); 
				String sql ="select count(*) from sellregis where scon=1";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				System.out.println("1");
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return count;
		}
		
		public int getSelMemSearchCount(String search) {
			List mnumList = null;
			List memList = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			int mnum = 0;
			int count = 0;
			try {
				conn = getConnection(); 
				String sql ="select mnum from sellregis where scon=1";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				System.out.println("2");
				if(rs.next()) {
					mnumList = new ArrayList();
					do {
						mnum = rs.getInt(1);
						mnumList.add(mnum);
					}while(rs.next());
				}
				
				sql = "select count(*) from member where mnum=? and mid=?"; 
				pstmt = conn.prepareStatement(sql);
				memList = new ArrayList();
				for(int i = 0; i<mnumList.size();i++) {
					pstmt.setInt(1, (int)mnumList.get(i));
					pstmt.setString(2, search);
					rs = pstmt.executeQuery();
					System.out.println("3");
					if(rs.next()) {
						count = count + 1;
					}
				}
				if(rs.next()) { // 결과가 있으면 
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return count;
		}
		
		public List getSelMemList(int start,int end) {
			List mnumList = null;
			List memList = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			int mnum = 0;
			try {
				conn = getConnection(); 
				String sql ="select mnum from sellregis where scon=1";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				System.out.println("4");
				if(rs.next()) {
					mnumList = new ArrayList();
					do {
						mnum = rs.getInt(1);
						mnumList.add(mnum);
					}while(rs.next());
				}
				
				sql = "select B.* from (select rownum r, A.* from (select * from member where mnum=? order by mreg desc) A) B where r >= ? and r <= ?"; 
				pstmt = conn.prepareStatement(sql);
				memList = new ArrayList();
				for(int i = 0; i<mnumList.size();i++) {
					pstmt.setInt(1, (int)mnumList.get(i));
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs = pstmt.executeQuery();
					System.out.println("5");
					if(rs.next()) { // 결과가 있으면 
						do {
							seller = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
							seller.setMnum(rs.getInt("mnum"));
							seller.setMid(rs.getString("mid"));
							seller.setMpw(rs.getString("mpw"));
							seller.setMname(rs.getString("mname"));
							seller.setMemail(rs.getString("memail"));
							seller.setMreg(rs.getTimestamp("mreg"));
							seller.setMimg(rs.getString("mimg"));
							seller.setMtel(rs.getString("mtel"));
							seller.setMtype(rs.getString("mtype"));
							
							memList.add(seller);
						}while(rs.next());
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return memList;
		}
		
		public List getSelMemSearch(int start,int end,String search) {
			List mnumList = null;
			List memList = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			int mnum = 0;
			try {
				conn = getConnection(); 
				String sql ="select mnum from sellregis where scon=1";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				System.out.println("6");
				if(rs.next()) {
					mnumList = new ArrayList();
					do {
						mnum = rs.getInt(1);
						mnumList.add(mnum);
					}while(rs.next());
				}
				
				sql = "select B.* from (select rownum r, A.* from (select * from member where mnum=? and mid=? order by mreg desc) A) B where r >= ? and r <= ?"; 
				pstmt = conn.prepareStatement(sql);
				memList = new ArrayList();
				for(int i = 0; i<mnumList.size();i++) {
					pstmt.setInt(1, (int)mnumList.get(i));
					pstmt.setString(2, search);
					pstmt.setInt(3, start);
					pstmt.setInt(4, end);
					rs = pstmt.executeQuery();
					System.out.println("7");
					if(rs.next()) { // 결과가 있으면 
						do {
							seller = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
							seller.setMnum(rs.getInt("mnum"));
							seller.setMid(rs.getString("mid"));
							seller.setMpw(rs.getString("mpw"));
							seller.setMname(rs.getString("mname"));
							seller.setMemail(rs.getString("memail"));
							seller.setMreg(rs.getTimestamp("mreg"));
							seller.setMimg(rs.getString("mimg"));
							seller.setMtel(rs.getString("mtel"));
							seller.setMtype(rs.getString("mtype"));
							
							memList.add(seller);
						}while(rs.next());
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return memList;
		}
		
		public int getBuyMemCount() {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from member where mtype='buyer'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
			return count;
		}
		
		public int getBuyMemSearchCount(String search) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select count(*) from member where mtype='buyer' and mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, search);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
			return count;
		}
		
		public List getBuyMemList(int start,int end) {
			List list = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			try {
				conn = getConnection();
				String sql ="select B.* from (select rownum r, A.* from (select * from member where mtype='buyer' order by mreg desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				if(rs.next()) { // 결과가 있으면 
					list = new ArrayList();
					do {
						seller = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
						seller.setMnum(rs.getInt("mnum"));
						seller.setMid(rs.getString("mid"));
						seller.setMpw(rs.getString("mpw"));
						seller.setMname(rs.getString("mname"));
						seller.setMemail(rs.getString("memail"));
						seller.setMreg(rs.getTimestamp("mreg"));
						seller.setMimg(rs.getString("mimg"));
						seller.setMtel(rs.getString("mtel"));
						seller.setMtype(rs.getString("mtype"));
						
						list.add(seller);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return list;
		}
		
		public List getBuyMemSearch(int start,int end,String search) {
			List list = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			MemberDTO seller = null;
			try {
				conn = getConnection();
				String sql ="select B.* from (select rownum r, A.* from (select * from member where mtype='buyer' and mid=? order by mreg desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, search);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				if(rs.next()) { // 결과가 있으면 
					list = new ArrayList();
					do {
						seller = new MemberDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
						seller.setMnum(rs.getInt("mnum"));
						seller.setMid(rs.getString("mid"));
						seller.setMpw(rs.getString("mpw"));
						seller.setMname(rs.getString("mname"));
						seller.setMemail(rs.getString("memail"));
						seller.setMreg(rs.getTimestamp("mreg"));
						seller.setMimg(rs.getString("mimg"));
						seller.setMtel(rs.getString("mtel"));
						seller.setMtype(rs.getString("mtype"));
						
						list.add(seller);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return list;
		}
		
		
		public int getMidCheck(String mid) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select count(*) from member where mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
			}
			return count;
		}
		
		
}
