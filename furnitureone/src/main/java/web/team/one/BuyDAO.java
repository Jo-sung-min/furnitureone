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

public class BuyDAO {
	//커넥션 연결해주는 메서드
		private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl");
			return ds.getConnection();
		}
	//구매시 구매양식 등록해주는 메서드
		public void insertBuy(BuyDTO buy) {
	    	Connection conn = null; 
	    	PreparedStatement pstmt = null; 
	       	// 어느 글의 리뷰인지 알아야함   
	    	try {
	            conn = getConnection();
	            String sql = "insert into buy values(buy_seq.nextval,?,?,?,?,?,?,?,?,sysdate,?,?)";
	            pstmt= conn.prepareStatement(sql);
	            pstmt.setInt(1, buy.getPnum());
	            pstmt.setInt(2, buy.getMnum());
	            pstmt.setString(3, buy.getBaddr());
	            pstmt.setInt(4, buy.getBbuyst());
	            pstmt.setString(5, buy.getBpaytype());
	            pstmt.setInt(6, buy.getBprice());
	            pstmt.setInt(7, buy.getBcon());
	            pstmt.setInt(8, buy.getBdelcon());
	            pstmt.setInt(9, buy.getSnum());
	            pstmt.setString(10, buy.getPname());
	            int result=pstmt.executeUpdate();
	            
	            System.out.println("insert update count:"+result);
	            }catch(Exception e) {
	               e.printStackTrace(); 
	            }finally {
	               if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
	               if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
	            }
	 	}
	/* 범석---------------------------------------------------------------------------------------------------- */		
	//구매 내역 하나 꺼내주는 메서드
		public BuyDTO getbuy(int bnum) {
			BuyDTO buy = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null; 
			try {
				conn = getConnection(); 
				String sql = "select * from buy where bnum=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bnum);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과가 있으면 
					buy = new BuyDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
					buy.setPnum(rs.getInt("pnum"));
					buy.setBnum(bnum);
					buy.setBaddr(rs.getString("baddr"));
					buy.setBbuyst(rs.getInt("bbuyst"));
					buy.setBpaytype(rs.getString("bpaytype"));
					buy.setBprice(rs.getInt("bprice"));  
					buy.setBcon(rs.getInt("bcon"));
					buy.setBdelcon(rs.getInt("bdelcon"));
					buy.setBreg(rs.getTimestamp("breg"));
					buy.setSnum(rs.getInt("snum"));
					buy.setPname(rs.getString("pname"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return buy; 
		}
	//내가 구매한 상품(구매자용)
		public List<BuyDTO> getBuyProduct(int mnum, int start, int end ){
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 구매상품 담아줄 객체
			List<BuyDTO> list = null;
			try {
				conn = getConnection();
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from buy where mnum=? order by breg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareCall(sql);
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<BuyDTO>(); 
					do {
						//결과 있으니까 객체생성해서 담아주기
						BuyDTO buy = new BuyDTO();
						buy.setPnum(rs.getInt("pnum"));
						buy.setBnum(rs.getInt("bnum"));
						buy.setBaddr(rs.getString("baddr"));
						buy.setBbuyst(rs.getInt("bbuyst"));
						buy.setBpaytype(rs.getString("bpaytype"));
						buy.setBprice(rs.getInt("bprice"));  
						buy.setBcon(rs.getInt("bcon"));
						buy.setBdelcon(rs.getInt("bdelcon"));
						buy.setBreg(rs.getTimestamp("breg"));
						buy.setSnum(rs.getInt("snum"));
						buy.setPname(rs.getString("pname"));
						list.add(buy); 
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

	   //상품명을 검색했을때의 해당 개수 가져오기
	   public int getBuyProductSearchCount(String search, int mnum) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int count = 0;
	      try {
	         conn = getConnection();
	         String sql="select count(*) from buy where mnum=? and pname like '%"+search+"%'";
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
	   //검색했을때의 정렬용 상품 목록 가져오기
	   public List getBuyProductsSearch(int start,int end,String search,String id) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      List list = null;
	      try {
               conn = getConnection();
               System.out.println("id : "+id);
               System.out.println("search : "+search);
               String sql="select B.* from (select rownum r, A.* from (select * from product where mid=? and pname like '%"+search+"%' order by preg desc) A) B where r >= ? and r <= ?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, id);
               pstmt.setInt(2, start);
               pstmt.setInt(3, end);
               rs = pstmt.executeQuery();
	         if(rs.next()) {
	            list = new ArrayList();
	            do {
	               ProductDTO dto = new ProductDTO();
	               dto.setPnum(rs.getInt("pnum"));
	               dto.setPimg(rs.getString("pimg"));
	               dto.setPname(rs.getString("pname"));
	               dto.setPsellst(rs.getInt("psellst"));
	               dto.setPcolor(rs.getString("pcolor"));
	               dto.setPtype(rs.getString("ptype"));
	               dto.setPstock(rs.getInt("pstock"));
	               dto.setPreg(rs.getTimestamp("preg"));
	               dto.setPcontent(rs.getString("pcontent"));
	               dto.setPprice(rs.getInt("pprice"));
	               dto.setPcon(rs.getInt("pcon"));
	               dto.setPgrade(rs.getInt("pgrade"));
	               dto.setPpick(rs.getInt("pgrade"));
	               dto.setMid(rs.getString("mid"));
	               dto.setPname(rs.getString("pname"));
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
	//내가 구매한 상품 개수 가져오기
		public int getProductCount(int mnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0;
			
			try {
				conn = getConnection();
				String sql="select count(*) from buy where mnum=?";
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
		//내가 구매한 상품 페이징처리용 상품 목록가져오기
		public List getBuyProductList(int start, int end, int mnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List list = null;
			try {
				conn = getConnection();
				String sql="select B.* from (select rownum r, A.* from (select * from buy where mnum=? order by breg desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList();
					do {
						BuyDTO buy = new BuyDTO();
						buy.setPnum(rs.getInt("pnum"));
						buy.setBnum(rs.getInt("bnum"));
						buy.setBaddr(rs.getString("baddr"));
						buy.setBbuyst(rs.getInt("bbuyst"));
						buy.setBpaytype(rs.getString("bpaytype"));
						buy.setBprice(rs.getInt("bprice"));  
						buy.setBcon(rs.getInt("bcon"));
						buy.setBdelcon(rs.getInt("bdelcon"));
						buy.setBreg(rs.getTimestamp("breg"));
						buy.setSnum(rs.getInt("snum"));
						buy.setPname(rs.getString("pname")); 
						list.add(buy);
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
	/* 성현--------------------------------------------------------------------------------------------------------- */		
		//배송상태변경(판매자용)
			public void changeDelcon(int bnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				
				try {
					conn = getConnection();
					String sql="update buy set bdelcon=1 where bnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, bnum);
					pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
			//내가 판매중인 상품중에 배송중에 있는 상품(판매자용)
			public List getDelProduct(int snum) {
				BuyDTO dto = null;
				List list = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = getConnection();
					String sql = "select * from buy where snum=? and bdelcon=0 order by breg desc";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, snum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							dto = new BuyDTO();
							dto.setMnum(rs.getInt("mnum"));
							dto.setBnum(rs.getInt("bnum"));
							dto.setPnum(rs.getInt("pnum"));
							dto.setSnum(snum);
							dto.setBaddr(rs.getString("baddr"));
							dto.setBbuyst(rs.getInt("bbuyst"));
							dto.setBpaytype(rs.getString("bpaytype"));
							dto.setBprice(rs.getInt("bprice"));
							dto.setBcon(rs.getInt("bcon"));
							dto.setBdelcon(rs.getInt("bdelcon"));
							dto.setBreg(rs.getTimestamp("breg"));
							dto.setPname(rs.getString("pname"));
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
		//현재 배송중인 상품의 개수 가져오기
			public int getDelProductCount(int snum) {
				int count = 0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
			  	try {
			     	conn = getConnection();
			      	String sql = "select count(*) from buy where snum=? and bdelcon=0";
			     	pstmt = conn.prepareStatement(sql);
			     	pstmt.setInt(1, snum);
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
	//현재 배송중인 상품을 정렬해서 보여주기 위한 목록 가져오기
			public List getDelProductList(int start, int end, int snum) {
			    Connection conn = null;
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    List list = null;
			    try {
			       conn = getConnection();
			       String sql="select B.* from (select rownum r, A.* from (select * from buy where snum=? order by breg desc) A) B where r >= ? and r <= ?";
			       pstmt = conn.prepareStatement(sql);
			       pstmt.setInt(1, snum);
			       pstmt.setInt(2, start);
			       pstmt.setInt(3, end);
			       rs = pstmt.executeQuery();
			         
			       if(rs.next()) {
			          list = new ArrayList();
			          do {
			             BuyDTO dto = new BuyDTO();
			               
			             dto = new BuyDTO();
			             dto.setMnum(rs.getInt("mnum"));
			             dto.setBnum(rs.getInt("bnum"));
			             dto.setPnum(rs.getInt("pnum"));
			             dto.setSnum(snum);
			             dto.setBaddr(rs.getString("baddr"));
			             dto.setBbuyst(rs.getInt("bbuyst"));
			             dto.setBpaytype(rs.getString("bpaytype"));
			             dto.setBprice(rs.getInt("bprice"));
			             dto.setBcon(rs.getInt("bcon"));
			             dto.setBdelcon(rs.getInt("bdelcon"));
			             dto.setBreg(rs.getTimestamp("breg"));
			             dto.setPname(rs.getString("pname"));
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
			   //검색한 상품명의 배송중인 상품 개수가져오기 
			   public int getDelProductSearchCount(String search,int snum) {
			      int count = 0;
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      try {
			         conn = getConnection();
			         String sql = "select count(*) from buy where snum=? and bdelcon=0 and pname=?";
			         pstmt = conn.prepareStatement(sql);
			         pstmt.setInt(1, snum);
			         pstmt.setString(2, search);
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
			   //배송중인 상품의 정렬해서 보여주기 위한 목록 가져오기
			   public List getDelProDucts(int start,int end,int snum) {
			      BuyDTO dto = null;
			      List list = null;
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      try {
			         conn = getConnection();
			         String sql = "select B.* from (select rownum r, A.* from (select * from buy where snum=? and bdelcon=0 order by breg desc) A) B where r >= ? and r <= ?";
			         pstmt = conn.prepareStatement(sql);
			         pstmt.setInt(1, snum);
			         pstmt.setInt(2, start);
			         pstmt.setInt(3, end);
			         rs = pstmt.executeQuery();
			         if(rs.next()) {
			            list = new ArrayList();
			            do {
			               dto = new BuyDTO();
			               dto.setMnum(rs.getInt("mnum"));
			               dto.setBnum(rs.getInt("bnum"));
			               dto.setPnum(rs.getInt("pnum"));
			               dto.setSnum(snum);
			               dto.setBaddr(rs.getString("baddr"));
			               dto.setBbuyst(rs.getInt("bbuyst"));
			               dto.setBpaytype(rs.getString("bpaytype"));
			               dto.setBprice(rs.getInt("bprice"));
			               dto.setBcon(rs.getInt("bcon"));
			               dto.setBdelcon(rs.getInt("bdelcon"));
			               dto.setBreg(rs.getTimestamp("breg"));
			               dto.setPname(rs.getString("pname"));
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
			   //검색한 상품명의 상품 정렬을 위한 목록 가져오기 
			   public List getDelProDuctsSearch(int start,int end, String search, int snum) {
			      BuyDTO dto = null;
			      List list = null;
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      try {
			         conn = getConnection();
			         String sql = "select B.* from (select rownum r, A.* from (select * from buy where snum=? and bdelcon=0 and pname=? order by breg desc) A) B where r >= ? and r <= ?";
			         pstmt = conn.prepareStatement(sql);
			         pstmt.setInt(1, snum);
			         pstmt.setString(2, search);
			         pstmt.setInt(3, start);
			         pstmt.setInt(4, end);
			         rs = pstmt.executeQuery();
			         if(rs.next()) {
			            list = new ArrayList();
			            do {
			               dto = new BuyDTO();
			               dto.setMnum(rs.getInt("mnum"));
			               dto.setBnum(rs.getInt("bnum"));
			               dto.setPnum(rs.getInt("pnum"));
			               dto.setSnum(snum);
			               dto.setBaddr(rs.getString("baddr"));
			               dto.setBbuyst(rs.getInt("bbuyst"));
			               dto.setBpaytype(rs.getString("bpaytype"));
			               dto.setBprice(rs.getInt("bprice"));
			               dto.setBcon(rs.getInt("bcon"));
			               dto.setBdelcon(rs.getInt("bdelcon"));
			               dto.setBreg(rs.getTimestamp("breg"));
			               dto.setPname(rs.getString("pname"));
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
			   
			  public List getAllOrders() {
				  BuyDTO dto = null;
			      List list = null;
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      try {
			         conn = getConnection();
			         String sql ="select * from buy order by breg desc";
			         pstmt = conn.prepareStatement(sql);
			         rs = pstmt.executeQuery();
			         if(rs.next()) {
			            list = new ArrayList();
			            	do {
				              dto = new BuyDTO();
				              dto.setMnum(rs.getInt("mnum"));
				              dto.setBnum(rs.getInt("bnum"));
				              dto.setPnum(rs.getInt("pnum"));
				              dto.setSnum(rs.getInt("snum"));
				              dto.setBaddr(rs.getString("baddr"));
				              dto.setBbuyst(rs.getInt("bbuyst"));
				              dto.setBpaytype(rs.getString("bpaytype"));
				              dto.setBprice(rs.getInt("bprice"));
				              dto.setBcon(rs.getInt("bcon"));
				              dto.setBdelcon(rs.getInt("bdelcon"));
				              dto.setBreg(rs.getTimestamp("breg"));
				              dto.setPname(rs.getString("pname"));
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
			   
			  public int getOrderSearchCount(int mnum) {
					int count = 0;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
				  	try {
				     	conn = getConnection();
				      	String sql = "select count(*) from buy where mnum=? or snum=?";
				      	pstmt = conn.prepareStatement(sql);
				      	pstmt.setInt(1, mnum);
				      	pstmt.setInt(2, mnum);
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
			  
				public int getOrderCount() {
					int count = 0;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql = "select count(*) from buy";
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
				
				public List getOrderSearch(int start,int end,int mnum) {
					List list = null;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql="select B.* from (select rownum r, A.* from (select * from buy where mnum=? or snum=? order by breg desc) A) B where r >= ? and r <= ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						pstmt.setInt(2, mnum);
						pstmt.setInt(3, start);
						pstmt.setInt(4, end);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList();
							do {
								BuyDTO buy = new BuyDTO();
								buy.setPnum(rs.getInt("pnum"));
								buy.setMnum(rs.getInt("mnum"));
								buy.setBnum(rs.getInt("bnum"));
								buy.setBaddr(rs.getString("baddr"));
								buy.setBbuyst(rs.getInt("bbuyst"));
								buy.setBpaytype(rs.getString("bpaytype"));
								buy.setBprice(rs.getInt("bprice"));  
								buy.setBcon(rs.getInt("bcon"));
								buy.setBdelcon(rs.getInt("bdelcon"));
								buy.setBreg(rs.getTimestamp("breg"));
								buy.setSnum(rs.getInt("snum"));
								buy.setPname(rs.getString("pname"));
								list.add(buy);
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
				
				public List getOrderList(int start,int end) {
					List list = null;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql="select B.* from (select rownum r, A.* from (select * from buy order by breg desc) A) B where r >= ? and r <= ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, end);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList();
							do {
								BuyDTO buy = new BuyDTO();
								buy.setPnum(rs.getInt("pnum"));
								buy.setMnum(rs.getInt("mnum"));
								buy.setBnum(rs.getInt("bnum"));
								buy.setBaddr(rs.getString("baddr"));
								buy.setBbuyst(rs.getInt("bbuyst"));
								buy.setBpaytype(rs.getString("bpaytype"));
								buy.setBprice(rs.getInt("bprice"));  
								buy.setBcon(rs.getInt("bcon"));
								buy.setBdelcon(rs.getInt("bdelcon"));
								buy.setBreg(rs.getTimestamp("breg"));
								buy.setSnum(rs.getInt("snum"));
								buy.setPname(rs.getString("pname"));
								list.add(buy);
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
				//구매 내역 하나 꺼내주는 메서드
				public BuyDTO getbuyreview(int pnum) {
					BuyDTO buy = null; 
					Connection conn = null; 
					PreparedStatement pstmt = null; 
					ResultSet rs = null; 
					try {
						conn = getConnection(); 
						String sql = "select * from buy where pnum=?"; 
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pnum);
						
						rs = pstmt.executeQuery(); 
						if(rs.next()) { // 결과가 있으면 
							buy = new BuyDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
							buy.setPnum(pnum);
							buy.setBnum(rs.getInt("bnum"));
							buy.setBaddr(rs.getString("baddr"));
							buy.setBbuyst(rs.getInt("bbuyst"));
							buy.setBpaytype(rs.getString("bpaytype"));
							buy.setBprice(rs.getInt("bprice"));  
							buy.setBcon(rs.getInt("bcon"));
							buy.setBdelcon(rs.getInt("bdelcon"));
							buy.setBreg(rs.getTimestamp("breg"));
							buy.setSnum(rs.getInt("snum"));
							buy.setPname(rs.getString("pname"));
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
						if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
						if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
					}
					return buy; 
				}
				
				public int getbuyCount(int mnum) {
					int count = 0;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql = "select count(*) from buy where mnum=?";
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
				//상품명을 검색했을때의 해당 개수 가져오기
				public int getBuySearchCount(String search, int mnum) {
					int count = 0;
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						conn = getConnection();
						String sql = "select count(*) from buy where mnum=? and pname like '%"+search+"%'";
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
				
		 public List getBuySearch(int start,int end,String search ,int mnum) {
				List list = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = getConnection();
					String sql="select B.* from (select rownum r, A.* from (select * from buy where mnum=? and pname like '%"+search+"%' order by breg desc) A) B where r >= ? and r <= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							BuyDTO buy = new BuyDTO();
							buy.setPnum(rs.getInt("pnum"));
							buy.setMnum(mnum);
							buy.setBnum(rs.getInt("bnum"));
							buy.setBaddr(rs.getString("baddr"));
							buy.setBbuyst(rs.getInt("bbuyst"));
							buy.setBpaytype(rs.getString("bpaytype"));
							buy.setBprice(rs.getInt("bprice"));  
							buy.setBcon(rs.getInt("bcon"));
							buy.setBdelcon(rs.getInt("bdelcon"));
							buy.setBreg(rs.getTimestamp("breg"));
							buy.setSnum(rs.getInt("snum"));
							buy.setPname(rs.getString("pname"));
							list.add(buy);
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
		 public List getBuyList(int start,int end, int mnum) {
				List list = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					conn = getConnection();
					String sql="select B.* from (select rownum r, A.* from (select * from buy where mnum=? order by breg desc) A) B where r >= ? and r <= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							BuyDTO buy = new BuyDTO();
							buy.setPnum(rs.getInt("pnum"));
							buy.setMnum(mnum);
							buy.setBnum(rs.getInt("bnum"));
							buy.setBaddr(rs.getString("baddr"));
							buy.setBbuyst(rs.getInt("bbuyst"));
							buy.setBpaytype(rs.getString("bpaytype"));
							buy.setBprice(rs.getInt("bprice"));  
							buy.setBcon(rs.getInt("bcon"));
							buy.setBdelcon(rs.getInt("bdelcon"));
							buy.setBreg(rs.getTimestamp("breg"));
							buy.setSnum(rs.getInt("snum"));
							buy.setPname(rs.getString("pname"));
							
							list.add(buy);
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
		 public List getBuy(int mnum) {
			  BuyDTO dto = null;
		      List list = null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         conn = getConnection();
		         String sql ="select * from buy where mnum = ? order by breg desc";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, mnum);
		         rs = pstmt.executeQuery();
		         if(rs.next()) {
		            list = new ArrayList();
		            	do {
			              dto = new BuyDTO();
			              dto.setMnum(mnum);
			              dto.setBnum(rs.getInt("bnum"));
			              dto.setPnum(rs.getInt("pnum"));
			              dto.setSnum(rs.getInt("snum"));
			              dto.setBaddr(rs.getString("baddr"));
			              dto.setBbuyst(rs.getInt("bbuyst"));
			              dto.setBpaytype(rs.getString("bpaytype"));
			              dto.setBprice(rs.getInt("bprice"));
			              dto.setBcon(rs.getInt("bcon"));
			              dto.setBdelcon(rs.getInt("bdelcon"));
			              dto.setBreg(rs.getTimestamp("breg"));
			              dto.setPname(rs.getString("pname"));
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
		
		// 회원 정보 수정 메서드
		public int bconUpdate(int bnum) {
			int result = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			try {
				conn = getConnection(); 
				String sql = "update buy set bcon=1 where bnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bnum);
				result = pstmt.executeUpdate(); // 잘되면 리턴1, 잘안되면 리턴0 
				System.out.println("update bcon result : "+result);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
				if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
			}
			return result; 
		}
}
