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

public class QnaDAO {
	//커넥션 연결해주는 메서드
		private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
		//Qna insert
		public void insertQna(QnaDTO qna) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql = "insert into qna values(qna_seq.nextval, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, qna.getQtitle());
				pstmt.setInt(2, qna.getQnum());
				
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
				public int qnaCount(int qnum) {
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int count = 0 ;
					
					try {
						conn = getConnection();
						String sql = "select count(*) from qna where qnum=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, qnum);
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
				public int qnaSearchCount(String sel, String search) {
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
				public List<QnaDTO> getQna(int qnum, int start, int end ){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					// qna 담아줄 객체
					List<QnaDTO> list = null;
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from qna where qnum=? order by qreg desc) A) B "
								+ "where r >= ? and r <= ?";
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, qnum);
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
						rs=pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList<QnaDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								QnaDTO qna = new QnaDTO();
								qna.setMnum(rs.getInt("Mnum"));
								qna.setQnum(rs.getInt("Qnum"));
								qna.setQtitle(rs.getString("Qtitle"));
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
				public int getQnum(String title) {
					int qnum = 0;
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null; 
					try {
						conn = getConnection(); 
				        String sql = "select qnum from qna where qtitle=?"; 
				        pstmt = conn.prepareStatement(sql);
				        pstmt.setString(1, title);
				        rs = pstmt.executeQuery(); 
				        
				        if(rs.next()) {
				        	qnum= rs.getInt(1);
				        }
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try{ rs.close(); }catch(Exception e) { e.printStackTrace(); }
				        if(pstmt != null) try{ pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
				        if(conn != null) try{ conn.close(); }catch(Exception e) { e.printStackTrace(); }
				    }
				    return qnum;
				}
		
		
		
		
		
}
