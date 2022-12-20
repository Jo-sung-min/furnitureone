package web.team.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SellregisDAO {

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds =  (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	/* 성현-------------------------------------------------------------------------------------- */
	//판매자 승인요청
	public void insertSeller(SellregisDTO dto, int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql ="insert into sellregis values(?,?,?,?,?,?,?,0,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setString(2, dto.getScompany());
			pstmt.setString(3, dto.getSaddr());
			pstmt.setString(4, dto.getScall());
			pstmt.setString(5, dto.getSrepresent());
			pstmt.setString(6, dto.getShwanaddr());
			pstmt.setInt(7, dto.getSbnum());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	//판매자 승인 요청 시 보낸 정보 가져오기
	public SellregisDTO getSeller(int mnum) {
		SellregisDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select * from sellregis where mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new SellregisDTO();
				dto.setMnum(mnum);
				dto.setScompany(rs.getString("scompany"));
				dto.setSaddr(rs.getString("saddr"));
				dto.setScall(rs.getString("scall"));
				dto.setSrepresent(rs.getString("srepresent"));
				dto.setShwanaddr(rs.getString("shwanaddr"));
				dto.setSbnum(rs.getInt("sbnum"));
				dto.setScon(rs.getInt("scon"));
				dto.setSreg(rs.getTimestamp("sreg"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return dto;
	}	
	
	public List getRegisSeller() {
		List list = null;
		SellregisDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select * from sellregis where scon=0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					dto = new SellregisDTO();
					dto.setMnum(rs.getInt("mnum"));
					dto.setScompany(rs.getString("scompany"));
					dto.setSaddr(rs.getString("saddr"));
					dto.setScall(rs.getString("scall"));
					dto.setSrepresent(rs.getString("srepresent"));
					dto.setShwanaddr(rs.getString("shwanaddr"));
					dto.setSbnum(rs.getInt("sbnum"));
					dto.setScon(rs.getInt("scon"));
					dto.setSreg(rs.getTimestamp("sreg"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return list;
	}
	
	public void approveRegis(int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql ="update sellregis set scon=1 where mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	public List getRegisSearch(int start,int end,int mnum) {
		List list = null;
		SellregisDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select B.* from (select rownum r, A.* from (select * from sellregis where mnum=? and scon=0 order by sreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					dto = new SellregisDTO();
					dto.setMnum(rs.getInt("mnum"));
					dto.setScompany(rs.getString("scompany"));
					dto.setSaddr(rs.getString("saddr"));
					dto.setScall(rs.getString("scall"));
					dto.setSrepresent(rs.getString("srepresent"));
					dto.setShwanaddr(rs.getString("shwanaddr"));
					dto.setSbnum(rs.getInt("sbnum"));
					dto.setScon(rs.getInt("scon"));
					dto.setSreg(rs.getTimestamp("sreg"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return list;
	}
	
	public List getRegisList(int start,int end) {
		List list = null;
		SellregisDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select B.* from (select rownum r, A.* from (select * from sellregis where scon=0 order by sreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					dto = new SellregisDTO();
					dto.setMnum(rs.getInt("mnum"));
					dto.setScompany(rs.getString("scompany"));
					dto.setSaddr(rs.getString("saddr"));
					dto.setScall(rs.getString("scall"));
					dto.setSrepresent(rs.getString("srepresent"));
					dto.setShwanaddr(rs.getString("shwanaddr"));
					dto.setSbnum(rs.getInt("sbnum"));
					dto.setScon(rs.getInt("scon"));
					dto.setSreg(rs.getTimestamp("sreg"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return list;
	}
	
	public int getRegisCount() {
		int count =0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select count(*) from sellregis where scon=0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return count;
	}
	public int getRegisSearchCount(int mnum) {
		int count =0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql ="select count(*) from sellregis where mnum=? and scon=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
		return count;
	}
	
}
