package web.team.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ZzimDAO {

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds =  (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	
	//물건 찜 했는지 세어주는 메서드 
			public int zzimCount(int pnum, int mnum) {
				int count=0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;   
				
				try {
					conn = getConnection();
					String sql="select * from zzim where pnum=? and mnum=? and zcon=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					rs= pstmt.executeQuery();
					
					if(rs.next()) {
						count=1; // 이미 찜을 했을떄
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}return count;
			}
			
			//물건 찜자체가 있는지 세어주는 메서드 
			public int fzzimCount(int pnum, int mnum) {
				int count=0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;   
				
				try {
					conn = getConnection();
					String sql="select * from zzim where pnum=? and mnum=? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					rs= pstmt.executeQuery();
					
					if(rs.next()) {
						count=1; // 찜한 이력이 있을떄
					}
					
				}catch(Exception e) {
					e.printStackTrace();
					
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}return count;
			}
			
			
			//물건 처음찜 해주는 메서드 
			public void FstZzim(int pnum, int mnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				
				try {
					conn = getConnection();
					String sql="insert into zzim values(?,?,1)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					pstmt.executeUpdate(); 
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
			
		//물건 찜 해주는 메서드 
			public void ScdZzim(int pnum, int mnum ) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
						
				try {
					conn = getConnection();
					String sql="select * from zzim where pnum=? and mnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					rs = pstmt.executeQuery(); 
					//결과가 있으면 0로 바꿔주기
					
					if(rs.next()) {
						sql = "update zzim set zcon=1 where pnum=? and mnum=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pnum);
						pstmt.setInt(2, mnum);
						pstmt.executeUpdate();
						System.out.println("찜");
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
			
			
			
			//물건 찜 취소해주는 메서드 
			public void NoZzim(int pnum, int mnum  ) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql="select * from zzim where pnum=? and mnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					rs = pstmt.executeQuery(); 
					//결과가 있으면 0로 바꿔주기
					
					if(rs.next()) {
						sql = "update zzim set zcon=0 where pnum=? and mnum=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pnum);
						pstmt.setInt(2, mnum);
						pstmt.executeUpdate();
						System.out.println("찜해제");
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
	
			
			//아이디랑 물품 넘버 받고 찜 상태 리턴 해주는 메서드
	
			public int getZzimCon (int pnum, int mnum) {
				int zzimCon =0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql="select * from zzim where pnum=? and mnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, mnum);
					rs = pstmt.executeQuery(); 
					
					if(rs.next()) {
						zzimCon=rs.getInt("zcon");
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}return zzimCon;
			}
			
			
			
			// 상품명 받고 찜 겟수 세어주는 메서드
			public int getPickCount (int pnum) {
				int pickCount =0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql="select count(*) from zzim where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery(); 
					if(rs.next()) {
						pickCount=rs.getInt(1);
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}return pickCount;
				
			}
			
			
			//물건 정보 받고 ppick+1 하나 올려주는 메서드
			
			public void addPpick (int pnum) {
				int pickCount =0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql="select ppick from product where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery(); 
					if(rs.next()) {
						if(rs.getInt(1)>0) {
							pickCount=rs.getInt(1)+1;
						}else {
							pickCount=1;	
						}
						sql="update product set ppick=? where pnum=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pickCount);
						pstmt.setInt(2, pnum);
						pstmt.executeUpdate();
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
				
			}
			
			
			// Ppick 내려주는 메서드
			public void downPpick(int pnum) {
				int pickCount =0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					String sql="select ppick from product where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery(); 
					if(rs.next()) {
						if(rs.getInt(1)>0) {
							pickCount=rs.getInt(1)-1;
						}else {
							pickCount=0;	
						}
						sql="update product set ppick=? where pnum=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pickCount);
						pstmt.setInt(2, pnum);
						pstmt.executeUpdate();
					}	 
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
				
			}
			
			
			
	
}
