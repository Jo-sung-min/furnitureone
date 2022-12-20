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

public class CartDAO {
	//커넥션 연결해주는 메서드
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env= (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	//장바구니 insert
	public void insertCart(CartDTO cart) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "insert into cart values(cart_seq.nextval, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getPnum());
			pstmt.setInt(2, cart.getMnum());
			pstmt.setInt(3, cart.getCcount());
			pstmt.setString(4, cart.getPname());
			int result = pstmt.executeUpdate();
			System.out.println("insert cart result : "+result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	//장바구니 선택 삭제
	public int deleteCart(int cnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from cart where cnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);

			result = pstmt.executeUpdate();
			System.out.println("delete cart result : "+result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	//장바구니 비우기
	public int clearCart(int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from cart where mnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return result;
	}
	
	public CartDTO selectCart(int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart = null;
		try {
			conn = getConnection(); 
			String sql = "select * from cart where mnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cart = new CartDTO();
				cart.setMnum(mnum);
				cart.setPnum(rs.getInt("pnum"));
				cart.setCnum(rs.getInt("cnum"));
				cart.setCcount(rs.getInt("ccount"));
				cart.setPname(rs.getString("Pname"));
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return cart;
	}
	
	public List<CartDTO> selectAllCartList(int mnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> list = new ArrayList<CartDTO>();
		try {
			conn = getConnection();

			String sql = "select * from Cart where mnum = ? order by cnum desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setMnum(mnum);
				cart.setPnum(rs.getInt("pnum"));
				cart.setCnum(rs.getInt("cnum"));
				cart.setCcount(rs.getInt("ccount"));
				cart.setPname(rs.getString("Pname"));
				list.add(cart);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return list;
	}
	//내가 장바구니에 담은 상품(구매자용)
	public List<CartDTO> getCart(int mnum, int start, int end ){
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 구매상품 담아줄 객체
		List<CartDTO> list = null;
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from cart where mnum=? order by cnum desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareCall(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<CartDTO>(); 
				do {
					//결과 있으니까 객체생성해서 담아주기
					CartDTO cart = new CartDTO();
					cart.setMnum(mnum);
					cart.setPnum(rs.getInt("pnum"));
					cart.setCnum(rs.getInt("cnum"));
					cart.setCcount(rs.getInt("ccount"));
					cart.setPname(rs.getString("Pname"));
					list.add(cart); 
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
	
	  public int getCartCount(int mnum) {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		  	try {
		     	conn = getConnection();
		      	String sql = "select count(*) from cart where mnum=?";
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
	
	  public List getCartSearch(int start,int end,String search ,int mnum) {
			List list = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql="select B.* from (select rownum r, A.* from (select * from cart where mnum=? and pname like '%"+search+"%' order by cnum desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList();
					do {
						CartDTO cart = new CartDTO();
						cart.setMnum(mnum);
						cart.setPnum(rs.getInt("pnum"));
						cart.setCnum(rs.getInt("cnum"));
						cart.setCcount(rs.getInt("ccount"));
						cart.setPname(rs.getString("Pname"));
						
						list.add(cart);
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
	//상품명을 검색했을때의 해당 개수 가져오기
	   public int getCartSearchCount(String search, int mnum) { 
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int count = 0;
	      
	      try {
	         conn = getConnection();
	         String sql="select count(*) from cart where mnum=? and pname like '%"+search+"%'";
	         pstmt=conn.prepareStatement(sql);
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
	  public int getCartCount() {
			int count = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "select count(*) from cart";
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
	
	  public List getCartList(int start,int end, int mnum) {
			List list = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql="select B.* from (select rownum r, A.* from (select * from cart where mnum=? order by cnum desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList();
					do {
						CartDTO cart = new CartDTO();
						cart.setMnum(rs.getInt("mnum"));
						cart.setPnum(rs.getInt("pnum"));
						cart.setCnum(rs.getInt("cnum"));
						cart.setCcount(rs.getInt("ccount"));
						cart.setPname(rs.getString("Pname"));
						
						list.add(cart);
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
	
}
