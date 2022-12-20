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
		
		//Notice insert
		public void insertNotice(NoticeDTO notice) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql = "insert into notice(nnum, ntitle, ncontent, nimg, nreg) values(notice_seq.nextval, ?, ?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, notice.getNtitle());
				pstmt.setString(2, notice.getNcontent());
				pstmt.setString(3, notice.getNimg());
				pstmt.setTimestamp(4, notice.getNreg());
				
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
				public int noticeCount() {
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int count = 0 ;
					
					try {
						conn = getConnection();
						String sql = "select count(*) from notice";
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
				public int noticeSearchCount( String search) {
					int count = 0 ;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
						
					try {
						conn = getConnection();
						String sql = "select count(*) from notice where ntitle like '%"+search+"%'";
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
				
				
				
				//검색했을때 목록 가져오기
				public List<NoticeDTO> getnoticeSearch( int start, int end, String search) {
					List<NoticeDTO> list=null;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r , A.* from(select * from notice where ntitle like '%"+search+"%')A)B where r>=? and r<=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs= pstmt.executeQuery();
						if(rs.next()) {
								list = new ArrayList<NoticeDTO>();
								do{
									NoticeDTO notice = new NoticeDTO();
									notice.setNnum(rs.getInt("nnum"));
									notice.setNtitle(rs.getString("ntitle"));
									notice.setNcontent(rs.getString("ncontent"));
									notice.setNimg(rs.getString("nimg"));
									notice.setNreadcount(rs.getInt("nreadcount"));
									notice.setNreg(rs.getTimestamp("nreg"));
									list.add(notice);
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
				
				
				//검색있으면 가져올 매서드
				public List<NoticeDTO> getNoticeSearch(int start, int end, String search) {
					List<NoticeDTO> list = null;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from notice where 'ncontent' like '%"+search+"%') A) B "
								+ "where r >= ? and r <= ?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs= pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList<NoticeDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								NoticeDTO notice = new NoticeDTO();
								notice.setNtitle(rs.getString("Ntitle"));
								notice.setNnum(rs.getInt("Nnum"));
								notice.setNcontent(rs.getString("Ncontent"));
								notice.setNimg(rs.getString("Nimg"));
								notice.setNreadcount(rs.getInt("Nreadcount"));
								notice.setNreg(rs.getTimestamp("Nreg"));
								list.add(notice);
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
				
				//각 상품에 등록된 notice들 가져오는 메서드 (페이징 처리 완료)
				public List<NoticeDTO> getNotice(int start, int end ){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					// notice 담아줄 객체
					List<NoticeDTO> list = null;
					try {
						conn = getConnection();
						String sql = "select B.* from (select rownum r, A.* from "
								+ "(select * from notice order by nreg desc) A) B "
								+ "where r >= ? and r <= ?";
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs=pstmt.executeQuery();
						
						if(rs.next()) {
							list = new ArrayList<NoticeDTO>();
							do {
								//결과 있으니까 객체생성해서 담아주기
								NoticeDTO notice = new NoticeDTO();
								notice.setNtitle(rs.getString("Ntitle"));
								notice.setNnum(rs.getInt("Nnum"));
								notice.setNcontent(rs.getString("Ncontent"));
								notice.setNimg(rs.getString("Nimg"));
								notice.setNreadcount(rs.getInt("Nreadcount"));
								notice.setNreg(rs.getTimestamp("Nreg"));
								list.add(notice);
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
				
				
				
				
				//공지사항 하나만 가져오기
				public NoticeDTO getNotice(int nnum){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					NoticeDTO notice = null;
					try {
						conn = getConnection();
						String sql = "select * from notice where nnum=? ";
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, nnum);
						rs=pstmt.executeQuery();
						
						if(rs.next()) {
								notice = new NoticeDTO();
								notice.setNnum(rs.getInt("Nnum"));
								notice.setNtitle(rs.getString("Ntitle"));
								notice.setNcontent(rs.getString("Ncontent"));
								notice.setNimg(rs.getString("Nimg"));
								notice.setNreadcount(rs.getInt("Nreadcount"));
								notice.setNreg(rs.getTimestamp("Nreg"));
							}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
					return notice;
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
		
		
				//조회수 올려주는메서드 
				public int addReadCount(int qnum){
					int count = 0;
					Connection conn = null; 
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql = "select nreadcount from notice where nnum=? ";
						
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
				public void setReadCount(int readCount, int nnum){
					Connection conn = null; 
					PreparedStatement pstmt = null;
					try {
						conn = getConnection();
						String sql = "update notice set nreadcount=? where nnum=?";
						
						
						pstmt = conn.prepareCall(sql);
						pstmt.setInt(1, readCount);
						pstmt.setInt(2, nnum);
						pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
						if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
					}
				}
				
				
				
		
		
		
}
