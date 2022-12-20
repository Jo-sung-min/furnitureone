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

public class InquiryDAO {

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env= (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	public void insertInquiry(int pnum,String id,String question, String sid) {
		Connection conn = null; 
    	PreparedStatement pstmt = null; 
       	// 어느 글의 리뷰인지 알아야함   
    	try {
            conn = getConnection();
            String sql = "insert into inquiry(inum, pnum, mid, question, icon, qreg, sid)"
            		+ " values(inquiry_seq.nextval,?,?,?,0,sysdate,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pnum);
            pstmt.setString(2, id);
            pstmt.setString(3, question);
            pstmt.setString(4, sid);
            pstmt.executeUpdate();
            }catch(Exception e) {
               e.printStackTrace(); 
            }finally {
               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
            }
	}
	public void insertInquiry(int pnum,String id,String question, String sid, String check) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "insert into inquiry(inum, pnum, mid, question, icon, qreg, sid)"
					+ " values(inquiry_seq.nextval,?,?,?,1,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			pstmt.setString(3, question);
			pstmt.setString(4, sid);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	public void insertAnswer(int inum,String answer) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "update inquiry set answer=?, areg=sysdate where inum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, answer);
			pstmt.setInt(2, inum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	public List getInquiry(int pnum) {
		List list = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select * from inquiry where pnum=? order by qreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					list.add(dto);
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
	public int getInquiryCount(int pnum) {
		List list = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select * from inquiry where pnum=? order by qreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					dto.setSid(rs.getString("sid"));
					list.add(dto);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return list.size();
	}
	public List getInquiryList(int start,int end,int pnum) {
		List list = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from (select * from inquiry where pnum=? order by qreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					list.add(dto);
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
	public InquiryDTO getOneInquiry(int inum) {
		InquiryDTO inDTO = null;		
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql="select * from inquiry where inum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				inDTO = new InquiryDTO();
				inDTO.setIcon(rs.getInt("icon"));
				inDTO.setInum(rs.getInt("inum"));
				inDTO.setMid(rs.getString("mid"));
				inDTO.setPnum(rs.getInt("pnum"));
				inDTO.setQreg(rs.getTimestamp("qreg"));
				inDTO.setQuestion(rs.getString("question"));
				inDTO.setAnswer(rs.getString("answer"));
				inDTO.setAreg(rs.getTimestamp("areg"));
			}
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return inDTO;
	}
	
	public List getsellerInquiry(String id) {
		List pnumList = null;
		List inList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		int pnum = 0;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select pnum from product where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			pnumList = new ArrayList();
			if(rs.next()) {
				do {
					pnum = rs.getInt("pnum");
					pnumList.add(pnum);
				}while(rs.next());
			}
			sql="select * from inquiry where pnum=? and (answer is null or answer like'null') order by qreg";
			pstmt = conn.prepareStatement(sql);
			inList = new ArrayList();
			for(int i = 0 ; i < pnumList.size();i++) {
				pstmt.setInt(1, (int)pnumList.get(i));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					do {
						InquiryDTO dto = new InquiryDTO();
						dto.setIcon(rs.getInt("icon"));
						dto.setInum(rs.getInt("inum"));
						dto.setMid(rs.getString("mid"));
						dto.setPnum(rs.getInt("pnum"));
						dto.setQreg(rs.getTimestamp("qreg"));
						dto.setQuestion(rs.getString("question"));
						dto.setAnswer(rs.getString("answer"));
						dto.setAreg(rs.getTimestamp("areg"));
						inList.add(dto);
					}while(rs.next());
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return inList;
	}
	public List getMyQList(int start,int end,String id) {
		List pnumList = null;
		List inList = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		int pnum = 0;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from (select * from inquiry where sid=? and (answer is null or answer like'null') order by qreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				inList = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					dto.setSid(rs.getString("sid"));
					inList.add(dto);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace(); 
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return inList;
	}
	public int getMyQCount(String sid) {
		int count =0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select count(*) from inquiry where sid=? and (answer like 'null' or answer is null) order by qreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
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
	
	public List myQBuyer(String mid) {
		List list = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select * from inquiry where mid=? order by qreg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					dto.setSid(rs.getString("sid"));
					list.add(dto); 
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
	public List getBuyerQList(int start,int end,String mid) {
		List list = null;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from (select * from inquiry where mid=? order by qreg desc) A) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setIcon(rs.getInt("icon"));
					dto.setInum(rs.getInt("inum"));
					dto.setMid(rs.getString("mid"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setQreg(rs.getTimestamp("qreg"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					dto.setAreg(rs.getTimestamp("areg"));
					dto.setSid(rs.getString("sid"));
					list.add(dto); 
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
	public int getBuyerQCount(String mid) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 어느 글의 리뷰인지 알아야함   
		try {
			conn = getConnection();
			String sql = "select count(*) from inquiry where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
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
