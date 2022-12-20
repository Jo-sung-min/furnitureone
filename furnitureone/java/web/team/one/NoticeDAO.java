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

public class NoticeDAO {
	//커넥션 연결해주는 메서드
		private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
		//notice insert
		public void insertnotice(NoticeDTO notice) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql = "insert into notice values(notice_seq.nextval, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, notice.getNtitle());
				pstmt.setInt(2, notice.getNnum());
				
				int result = pstmt.executeUpdate();
				
				System.out.println("insert update count: "+result);
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
					if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
				}
			}
		//Qna에 등록된 리뷰 세어주는 메서드
				public int noticeCount(int nnum) {
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int count = 0 ;
					
					try {
						conn = getConnection();
						String sql = "select count(*) from notice where nnum=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, nnum);
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
				// 검색한 리뷰의 총 개수
				public int noticeSearchCount(String sel, String search) {
					int count = 0 ;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
						
					try {
						conn = getConnection();
						String sql = "select count(*) from qna where "+sel+" like '%"+search+"%'";
						pstmt=conn.prepareStatement(sql);
							
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
				//각 상품에 등록된 qna들 가져오는 메서드 (페이징 처리 완료)
				public List<NoticeDTO> getnotice(int qnum, int start, int end ){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					// qna 담아줄 객체
					List<NoticeDTO> list = null;
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from notice where nnum=? order by nreg desc) A) B "
								+ "where r >= ? and r <= ?";
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, qnum);  
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
						rs=pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList<NoticeDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								NoticeDTO qna = new NoticeDTO();
								qna.setNnum(rs.getInt("Nnum"));
								qna.setNtitle(rs.getString("Ntitle"));
								list.add(qna);
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
				
				//qnum 가져오기	
				public int getNnum(String title) {
					int nnum = 0;
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null; 
					try {
						conn = getConnection(); 
				        String sql = "select nnum from notice where ntitle=?"; 
				        pstmt = conn.prepareStatement(sql);
				        pstmt.setString(1, title);
				        rs = pstmt.executeQuery(); 
				        
				        if(rs.next()) {
				        	nnum= rs.getInt(1);
				        }
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try{ rs.close(); }catch(Exception e) { e.printStackTrace(); }
				        if(pstmt != null) try{ pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				        if(conn != null) try{ conn.close(); }catch(Exception e) { e.printStackTrace(); }
				    }
				    return nnum;
				}
		
		
}
