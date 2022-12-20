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

public class ReviewDAO {
		//커넥션 연결해주는 메서드
		private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
		/* 성민-----------------------------------------------------------------------------  */
		//리뷰 하나 등록해주는 메서드
		//리뷰 등록시 ID 나 물품정보는 Pro 페이지에서 처리
		public void insertReview(ReviewDTO review) {
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			// 어느 글의 리뷰인지 알아야함	
			try {
			conn = getConnection();
			String sql = "insert into review values(review_seq.nextval,?,?,?,?,?,sysdate,?,1)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, review.getRimg());
			pstmt.setInt(2, review.getPnum());
			pstmt.setString(3, review.getRcontent());
			pstmt.setInt(4, review.getMnum());
			pstmt.setString(5, review.getRgrade());
			pstmt.setString(6, review.getMid());
			
			int result=pstmt.executeUpdate();
			
			System.out.println("insert update count:"+result);
			}catch(Exception e) {
				e.printStackTrace(); 
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		}
		//상품의 등록된 리뷰 세어주는 메서드
		public int reviewCount(int pnum) {
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0 ;
			
			try {
				conn = getConnection();
				String sql = "select count(*) from review where pnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
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
		//검색한 리뷰의 총 개수(성민)
		public int reviewSearchCount(String sel, String search) {
			int count = 0 ;
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
				
			try {
				conn = getConnection();
				String sql = "select count(*) from review where "+sel+" like '%"+search+"%'";
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
		//각 상품에 등록된 리뷰들 가져오는 메서드 (페이징 처리 완료)(성민)
		public List<ReviewDTO> getReview(int pnum, int start, int end ){
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 리뷰 담아줄 객체
			List<ReviewDTO> list = null;
			try {
				conn = getConnection();
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from review where pnum=? order by rreg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<ReviewDTO>();
					do {
						//결과 있으니까 객체생성해서 담아주기
						ReviewDTO review = new ReviewDTO();
						review.setMnum(rs.getInt("Mnum"));
						review.setPnum(rs.getInt("Pnum"));
						review.setRcontent(rs.getString("Rcontent"));
						review.setRgrade(rs.getString("rgrade"));
						review.setRimg(rs.getString("rimg"));
						review.setRnum(rs.getInt("rnum"));
						review.setRreg(rs.getTimestamp("rreg"));
						review.setMid(rs.getString("mid"));
						review.setRcon(rs.getInt("rcon"));
						list.add(review);
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
		//각 상품에 등록된 리뷰들 검색해서 가져오는 메서드 (페이징 처리 완료)(성민)
		public List<ReviewDTO> getReviewSearch(int pnum,int start, int end, String sel, String search){
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 리뷰 담아줄 객체
			List<ReviewDTO> list = null;
			try {
				conn = getConnection();
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from review where pnum=? and "+sel+" like '%"+search+"%' order by rreg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<ReviewDTO>();
					do {
						//결과 있으니까 객체생성해서 담아주기
						ReviewDTO review = new ReviewDTO();
						review.setMnum(rs.getInt("Mnum"));
						review.setPnum(rs.getInt("Pnum"));
						review.setRcontent(rs.getString("Rcontent"));
						review.setRgrade(rs.getString("rgrade"));
						review.setRimg(rs.getString("rimg"));
						review.setRnum(rs.getInt("rnum"));
						review.setRreg(rs.getTimestamp("rreg"));
						review.setMid(rs.getString("mid"));
						review.setRcon(rs.getInt("rcon"));
						list.add(review);
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
		//물건 번호받고 리뷰 best 3개 뽑는 메서드 평점순 & 최근 기간순(성민)
		public List<ReviewDTO> getBestReview(int pnum){
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 리뷰 담아줄 객체
			List<ReviewDTO> list = null;
			try {
				conn = getConnection();
				String sql ="select B.* from (select rownum r, A.* from (select * from review order by rgrade desc) A) B where pnum=? order by rreg desc"; 
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, pnum);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<ReviewDTO>();
					do {
						//결과 있으니까 객체생성해서 담아주기
						ReviewDTO review = new ReviewDTO();
						review.setMnum(rs.getInt("Mnum"));
						review.setPnum(rs.getInt("Pnum"));
						review.setMid(rs.getString("Mid"));
						review.setRcontent(rs.getString("Rcontent"));
						review.setRgrade(rs.getString("rgrade"));
						review.setRimg(rs.getString("rimg"));
						review.setRnum(rs.getInt("rnum"));
						review.setRreg(rs.getTimestamp("rreg"));
						review.setMid(rs.getString("mid"));
						review.setRcon(rs.getInt("rcon"));
						list.add(review);
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
		
		
		
		   //평점 구해주는 메서드
		
			public double getAvePgrade(int Pnum, int count){
		    	  Connection conn = null;
		    	  PreparedStatement pstmt = null;
		    	  ResultSet rs = null;
		    	  double average = 0.0; 
		    	  try {
		    		  conn = getConnection();
		    		  String sql="select rgrade from review where Pnum=?";
		    		  pstmt=conn.prepareStatement(sql);
		    		  pstmt.setInt(1, Pnum);
		    		  rs = pstmt.executeQuery();
		    		  
		    		  if(rs.next()) {
		    			  do {
		    				  average += rs.getInt("rgrade");
		    			  }while(rs.next());
		    		  }
		    	  }catch(Exception e) {
		    		  e.printStackTrace();
		    	  }finally {
		    		  if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
		    		  if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
		    		  if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		    	  }
		    	  
		    	  return (double)(average/count);
		      }
		
			//rcon 가져오기	
			public int getRcon(String mid) {
				int rcon = 0;
				Connection conn = null; 
				PreparedStatement pstmt = null; 
				ResultSet rs = null; 
				try {
					conn = getConnection(); 
			        String sql = "select rcon from review where mid=?"; 
			        pstmt = conn.prepareStatement(sql);
			        pstmt.setString(1, mid);
			        rs = pstmt.executeQuery(); 
			        
			        if(rs.next()) {
			        	rcon = rs.getInt(1);
			        }
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try{ rs.close(); }catch(Exception e) { e.printStackTrace(); }
			        if(pstmt != null) try{ pstmt.close(); }catch(Exception e) { e.printStackTrace(); }
			        if(conn != null) try{ conn.close(); }catch(Exception e) { e.printStackTrace(); }
			    }
			    return rcon;
			}
			//환불 상태 꺼내오기
			public ReviewDTO getReview(String mid) {
				ReviewDTO reviewdto = null; 
				Connection conn = null; 
				PreparedStatement pstmt = null; 
				ResultSet rs = null; 
				try {
					conn = getConnection(); 
					String sql = "select * from review where mid=?"; 
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, mid);
					rs = pstmt.executeQuery(); 
					
					if(rs.next()) { // 결과가 있으면 
						//결과 있으니까 객체생성해서 담아주기
						ReviewDTO review = new ReviewDTO();
						review.setMnum(rs.getInt("Mnum"));
						review.setPnum(rs.getInt("Pnum"));
						review.setMid(rs.getString("Mid"));
						review.setRcontent(rs.getString("Rcontent"));
						review.setRgrade(rs.getString("rgrade"));
						review.setRimg(rs.getString("rimg"));
						review.setRnum(rs.getInt("rnum"));
						review.setRreg(rs.getTimestamp("rreg"));
						review.setMid(rs.getString("mid"));
						review.setRcon(rs.getInt("rcon"));
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
					if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
					if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
				}
				return reviewdto; 
			}
	
}
