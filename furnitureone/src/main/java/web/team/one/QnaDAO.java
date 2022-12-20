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
		
		
		//질문 인서트
		public void insertQna(QnaDTO qna) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql = "insert into qna(qnum, qtitle, qcontent, mnum,qimg, qreg) values(qna_seq.nextval, ?, ?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, qna.getQtitle());
				pstmt.setString(2, qna.getQcontent());
				pstmt.setInt(3, qna.getMnum());
				pstmt.setString(4, qna.getQimg());
				pstmt.setTimestamp(5, qna.getQreg());
				
				int result = pstmt.executeUpdate();
				System.out.println("insert update count: "+result);
				
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
					if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
				}
			}
		
		
		//답변 인서트
		public void insertAnswer(QnaDTO qna , int qnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select * from qna where qnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qnum);
				rs= pstmt.executeQuery();
				
				if(rs.next()) {
				sql ="update qna set acontent=? ,areg=? where qnum=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, qna.getAcontent());
				pstmt.setTimestamp(2, qna.getAreg());
				pstmt.setInt(3, qnum);
				pstmt.executeUpdate();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
			}
		}
		
		
		
		//Qna에 등록된 리뷰 세어주는 메서드
				public int qnaCount() {
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int count = 0 ;
					
					try {
						conn = getConnection();
						String sql = "select count(*) from qna";
						pstmt=conn.prepareStatement(sql);
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
				
				
				
				
				
				
				
				
				//검색카운드 가져오기
				public int qnaSearchCount(String search) {
					int count = 0 ;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
						
					try {
						conn = getConnection();
						String sql = "select count(*) from qna where qtitle like '%"+search+"%'";
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
				
				
				//검색있으면 가져올 매서드
				public List<QnaDTO> getQnaSearch(int start, int end, String search) {
					List<QnaDTO> list = null;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from qna where qtitle like '%"+search+"%') A) B "
								+ "where r >= ? and r <= ?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs= pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList<QnaDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								QnaDTO qna = new QnaDTO();
								qna.setQtitle(rs.getString("Qtitle"));
								qna.setQnum(rs.getInt("Qnum"));
								qna.setQcontent(rs.getString("Qcontent"));
								qna.setAcontent(rs.getString("Acontent"));
								qna.setMnum(rs.getInt("Mnum"));
								qna.setQimg(rs.getString("Qimg"));
								qna.setQreadcount(rs.getInt("Qreadcount"));
								qna.setQreg(rs.getTimestamp("Qreg"));
								qna.setAreg(rs.getTimestamp("Areg"));
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
				
				//각 상품에 등록된 qna들 가져오는 메서드 (페이징 처리 완료)
				public List<QnaDTO> getQna(int start, int end ){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					// qna 담아줄 객체
					List<QnaDTO> list = null;
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from qna order by qreg desc) A) B "
								+ "where r >= ? and r <= ?";
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs=pstmt.executeQuery();
						
						if(rs.next()) {
							list = new ArrayList<QnaDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								QnaDTO qna = new QnaDTO();
								qna.setQtitle(rs.getString("Qtitle"));
								qna.setQnum(rs.getInt("Qnum"));
								qna.setQcontent(rs.getString("Qcontent"));
								qna.setAcontent(rs.getString("Acontent"));
								qna.setMnum(rs.getInt("Mnum"));
								qna.setQimg(rs.getString("Qimg"));
								qna.setQreadcount(rs.getInt("Qreadcount"));
								qna.setQreg(rs.getTimestamp("Qreg"));
								qna.setAreg(rs.getTimestamp("Areg"));
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
				
				
				
				//각 qna하나 가져오는 메서드 
				public QnaDTO getQna(int qnum){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					// qna 담아줄 객체
					QnaDTO qna = null;
					try {
						conn = getConnection();
						String sql = "select * from qna where qnum=? ";
								
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, qnum);
						rs=pstmt.executeQuery();
						
						if(rs.next()) {
								qna = new QnaDTO();
								qna.setQtitle(rs.getString("Qtitle"));
								qna.setQnum(rs.getInt("Qnum"));
								qna.setQcontent(rs.getString("Qcontent"));
								qna.setAcontent(rs.getString("Acontent"));
								qna.setMnum(rs.getInt("Mnum"));
								qna.setQimg(rs.getString("Qimg"));
								qna.setQreadcount(rs.getInt("Qreadcount"));
								qna.setQreg(rs.getTimestamp("Qreg"));
								qna.setAreg(rs.getTimestamp("Areg"));
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
					return qna;
				}
				
				
				
				//조회수 올려주는메서드 
				public int addReadCount(int qnum){
					int count = 0;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql = "select qreadcount from qna where qnum=? ";
						
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, qnum);
						rs=pstmt.executeQuery();
						
						if(rs.next()) {
							count = rs.getInt(1)+1;
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
				
				//조회수 올린거 적용해주는 
				public void setReadCount(int readCount, int qnum){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					try {
						conn = getConnection();
						String sql = "update qna set qreadcount=? where qnum=?";
						
						
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, readCount);
						pstmt.setInt(2, qnum);
						pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
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
