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

public class HwanDAO {
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds =  (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	//환불 신청 등록
	public void insertHwan(HwanDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql="insert into hwan values(hwan_seq.nextval,?,0,?,sysdate,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBnum());
			pstmt.setString(2, dto.getHreason());
			pstmt.setInt(3, dto.getMnum());
			pstmt.setInt(4, dto.getSnum());
			pstmt.setString(5, dto.getPname());
			
			int result = pstmt.executeUpdate();
			
			System.out.println("insert hwan count:"+result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	//환불 상태 꺼내오기
	public HwanDTO gethwan(int bnum) {
		HwanDTO hwan = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from hwan where bnum=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { // 결과가 있으면 
				hwan = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
				hwan.setBnum(bnum);
				hwan.setHcon(rs.getInt("hcon"));
				hwan.setHnum(rs.getInt("hnum"));
				hwan.setHreason(rs.getString("hreason"));
				hwan.setHreg(rs.getTimestamp("hreg"));
				hwan.setHnum(rs.getInt("mnum"));
				hwan.setHnum(rs.getInt("snum"));
				hwan.setHreason(rs.getString("pname"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return hwan; 
	}
	
	public int cancle(int Bnum) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null;
		try {
			conn = getConnection(); 
			String sql = "delete from hwan where Bnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Bnum);
			result = pstmt.executeUpdate(); // 잘되면 리턴1, 잘안되면 리턴0 
			System.out.println("cancle result : "+result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return result; 
	}
	
	
	
	public List getMyHwan(int snum) {
		List list = null;
		HwanDTO hwanDTO = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from hwan where snum=? and hcon=0 order by hreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum); 
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과가 있으면 
				list = new ArrayList();
				do {
					hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					hwanDTO.setHnum(rs.getInt("hnum"));
					hwanDTO.setBnum(rs.getInt("bnum"));
					hwanDTO.setHcon(rs.getInt("hcon"));
					hwanDTO.setHreason(rs.getString("hreason"));
					hwanDTO.setHreg(rs.getTimestamp("hreg"));
					hwanDTO.setMnum(rs.getInt("mnum"));
					hwanDTO.setSnum(rs.getInt("snum"));
					hwanDTO.setPname(rs.getString("pname"));
					list.add(hwanDTO);
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
	
	public void hwanOk(int hnum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "update hwan set hcon=1 where hnum=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hnum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
	}
	public void hwanNo(int hnum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "update hwan set hcon=2 where hnum=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hnum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
	}
	/*  --------------------   */
	
	public List getBuyerHwan(int mnum) {
		List list = null;
		HwanDTO hwanDTO = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from hwan where mnum=? order by hreg desc"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과가 있으면 
				list= new ArrayList();
				do { 
					hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					hwanDTO.setHnum(rs.getInt("hnum"));
					hwanDTO.setBnum(rs.getInt("bnum"));
					hwanDTO.setHcon(rs.getInt("hcon"));
					hwanDTO.setHreason(rs.getString("hreason"));
					hwanDTO.setHreg(rs.getTimestamp("hreg"));
					hwanDTO.setMnum(rs.getInt("mnum"));
					hwanDTO.setSnum(rs.getInt("snum"));
					hwanDTO.setPname(rs.getString("pname"));
					list.add(hwanDTO);
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
	public int getHwanSearchCount(String search, int snum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int count = 0;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from hwan where snum=? and hcon=0 and pname like '%"+search+"%' order by hreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			rs = pstmt.executeQuery(); 
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
	public List getHwanSearch(int start,int end,String search,int snum) {
		List list = null;
		HwanDTO hwanDTO = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from hwan where snum=? and hcon=0 and pname like '%"+search+"%' order by hreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			rs = pstmt.executeQuery(); 
			list = new ArrayList();
				if(rs.next()) { // 결과가 있으면 
					do {
						hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
						hwanDTO.setHnum(rs.getInt("hnum"));
						hwanDTO.setBnum(rs.getInt("bnum"));
						hwanDTO.setHcon(rs.getInt("hcon"));
						hwanDTO.setHreason(rs.getString("hreason"));
						hwanDTO.setHreg(rs.getTimestamp("hreg"));
						hwanDTO.setMnum(rs.getInt("mnum"));
						hwanDTO.setSnum(rs.getInt("snum"));
						hwanDTO.setPname(rs.getString("pname"));
						list.add(hwanDTO);
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
	public int getHwanCount(int snum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int count=0;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from hwan where snum=? and hcon=0 order by hreg desc"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			rs = pstmt.executeQuery(); 
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
	public List getHwanList(int start,int end,int snum) {
		List list = null;
		HwanDTO hwanDTO = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from (select * from hwan where snum=? and hcon=0 order by hreg desc) A) B where r >= ? and r <= ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과가 있으면 
				list = new ArrayList();
				do {
					hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					hwanDTO.setHnum(rs.getInt("hnum"));
					hwanDTO.setBnum(rs.getInt("bnum"));
					hwanDTO.setHcon(rs.getInt("hcon"));
					hwanDTO.setHreason(rs.getString("hreason"));
					hwanDTO.setHreg(rs.getTimestamp("hreg"));
					hwanDTO.setMnum(rs.getInt("mnum"));
					hwanDTO.setSnum(rs.getInt("snum"));
					hwanDTO.setPname(rs.getString("pname"));
					list.add(hwanDTO);
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
	public int getHwanSearchCountB(String search, int mnum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int count = 0;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from hwan where mnum=? and pname like '%"+search+"%' order by hreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery(); 
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
	public List getHwanSearchB(int start,int end,String search,int mnum) {
		List list = null;
		HwanDTO hwanDTO = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from (select * from hwan where mnum=? and pname like '%"+search+"%' order by hreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); 
			list = new ArrayList();
			if(rs.next()) { // 결과가 있으면 
				do {
					hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					hwanDTO.setHnum(rs.getInt("hnum"));
					hwanDTO.setBnum(rs.getInt("bnum"));
					hwanDTO.setHcon(rs.getInt("hcon"));
					hwanDTO.setHreason(rs.getString("hreason"));
					hwanDTO.setHreg(rs.getTimestamp("hreg"));
					hwanDTO.setMnum(rs.getInt("mnum"));
					hwanDTO.setSnum(rs.getInt("snum"));
					hwanDTO.setPname(rs.getString("pname"));
					list.add(hwanDTO);
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
	public int getHwanCountB(int mnum) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int count = 0;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from hwan where mnum=? order by hreg desc"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery(); 
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
	public List getHwanListB(int start,int end,int mnum) {
		List list = null;
		HwanDTO hwanDTO = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from (select * from hwan where mnum=? order by hreg desc) A) B where r >= ? and r <= ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과가 있으면 
				list = new ArrayList();
				do {
					hwanDTO = new HwanDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					hwanDTO.setHnum(rs.getInt("hnum"));
					hwanDTO.setBnum(rs.getInt("bnum"));
					hwanDTO.setHcon(rs.getInt("hcon"));
					hwanDTO.setHreason(rs.getString("hreason"));
					hwanDTO.setHreg(rs.getTimestamp("hreg"));
					hwanDTO.setMnum(rs.getInt("mnum"));
					hwanDTO.setSnum(rs.getInt("snum"));
					hwanDTO.setPname(rs.getString("pname"));
					list.add(hwanDTO);
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
	
}
