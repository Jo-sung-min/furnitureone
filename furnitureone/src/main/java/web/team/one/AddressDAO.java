package web.team.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AddressDAO {
	//커넥션 연결해주는 메서드
		private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
	//주소 하나 등록해주는 메서드			
		public void insertAddress(MemberDTO member, AddressDTO address) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			// 어느 글의 리뷰인지 알아야함	
			
			try {
			conn = getConnection();
			String sql = "insert into address values(address_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member.getMnum());
			pstmt.setString(2, address.getMaddr());
			int result = pstmt.executeUpdate();
			
			System.out.println("insert member result : "+result);
			
			}catch(Exception e) {
				e.printStackTrace(); 
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			
		}
	// 주소 하나 가져와주는 메서드
		public List<AddressDTO> getAddress(int Mnum) {
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			//주소 담아줄 객체
			List<AddressDTO> list = null;
			try {
			conn = getConnection();
			String sql = "select * from address where mnum=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, Mnum);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<AddressDTO>();
				do {
					AddressDTO address= new AddressDTO();
					address.setMaddr(rs.getString("Maddr"));
					list.add(address);
				}while(rs.next());
			}
			}catch(Exception e) {
				e.printStackTrace(); 
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
				
			}return list;
		}
	//주소 하나만 가져오는 메서드
		public AddressDTO getOneAddress(int Mnum) {
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			AddressDTO address=null;
			//주소 담아줄 객체
			try {
				conn = getConnection();
				String sql = "select * from address where mnum=?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, Mnum);
				rs=pstmt.executeQuery();
				if(rs.next()) {
						address =new AddressDTO(); 
						address.setMaddr(rs.getString("Maddr"));
				}
			}catch(Exception e) {
				e.printStackTrace(); 
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
				
			}return address;
		}
		//등록된 주소 세어주는 메서드
		public int addressCount(int mnum) {
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0 ;
			try {
				conn = getConnection();
				String sql = "select count(*) from address where mnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				pstmt.executeQuery();
				
				rs= pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}

	
}
