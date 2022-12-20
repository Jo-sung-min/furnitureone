package web.team.one;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDAO {
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds =  (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	/* 성현--------------------------------------------------------------------------------------- */
	//상품판매중지
	public void sellStop(int pnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql="update product set pcon=1 where pnum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	// 상품 판매 재개
	public void reSell(int pnum) {
		Connection conn = null;
		PreparedStatement pstmt = null; 
		
		try {
			conn = getConnection();
			String sql="update product set pcon=0 where pnum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}

	public void allResell(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null; 
		
		try {
			conn = getConnection();
			String sql="update product set pcon=0 where mid=? and pstock >= 1";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	//내가 판매중인 상품 개수 가져오기
	public int getProductCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = getConnection();
			String sql="select count(*) from product where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	//내가 판매하는 상품 페이징처리용 상품 목록가져오기
	public List getProductList(int start, int end, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list = null;
		try {
			conn = getConnection();
			String sql="select B.* from (select rownum r, A.* from (select * from product where mid=? order by preg desc) A) B where r >= ? and r <= ?";
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
					dto.setPpick(rs.getInt("ppick"));
					dto.setMid(rs.getString("mid"));
					
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
	//상품 등록하기
	public void insertProduct(ProductDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql="insert into product (pnum,pimg,pname,pcolor,pprice,ptype,pstock,pcontent,mid) "
						+ "values(product_seq.nextval,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPimg());
			pstmt.setString(2, dto.getPname());
			pstmt.setString(3, dto.getPcolor());
			pstmt.setInt(4, dto.getPprice());
			pstmt.setString(5, dto.getPtype());
			pstmt.setInt(6, dto.getPstock());
			pstmt.setString(7, dto.getPcontent());
			pstmt.setString(8, dto.getMid());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	//원하는 상품 하나 가져오기
	public ProductDTO getOneProduct(int pnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO dto = null;
		try {
			conn = getConnection();
			String sql="select * from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
					dto = new ProductDTO();
					
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
					dto.setPpick(rs.getInt("ppick"));
					dto.setMid(rs.getString("mid"));
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
	//상품 정보 변경
	public void updateProduct(ProductDTO dto,int pnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql="update product set pname=?, pimg=?, pprice=?, pstock=?, pcontent=? where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPname());
			pstmt.setString(2, dto.getPimg());
			pstmt.setInt(3, dto.getPprice());
			pstmt.setInt(4, dto.getPstock());
			pstmt.setString(5, dto.getPcontent());
			pstmt.setInt(6, pnum);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
		}
	}
	//내가 판매중인 상품 전체 가져오기
		public List getMyProduct(String id) {
			ProductDTO dto = null;
			List list = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql ="select * from product where mid=? order by preg desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list  = new ArrayList();
					do {
						dto = new ProductDTO();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		//상품명을 검색했을때의 해당 개수 가져오기
		   public int getProductSearchCount(String search, String id) {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      int count = 0;
		      
		      try {
		         conn = getConnection();
		         String sql="select count(*) from product where mid=? and pname like '%"+search+"%'";
		         pstmt=conn.prepareStatement(sql);
		         pstmt.setString(1, id);
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
		   
		   
		   
		   
		   //상품명을 검색했을때의 해당 개수 가져오기(성민 7-22)
		   public int getProductSearchCount(String search) {
			   Connection conn = null;
			   PreparedStatement pstmt = null;
			   ResultSet rs = null;
			   int count = 0;
			   
			   try {
				   conn = getConnection();
				   String sql="select count(*) from product where pname like '%"+search+"%'";
				   pstmt=conn.prepareStatement(sql);
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
		   //검색했을때 목록 가져오기(7-22)
		   public List<ProductDTO> getProductSearch(int start,int end,String search) {
			   Connection conn = null;
			   PreparedStatement pstmt = null;
			   ResultSet rs = null;
			   List<ProductDTO> list = null;
			   
			   try {
				   conn = getConnection();
				   String sql="select B.* from (select rownum r, A.* from "
						   +"(select * from product where pname like '%"+search+"%')A)B"
						   + " where r >= ? and r <= ?";
				   pstmt=conn.prepareStatement(sql);
				   pstmt.setInt(1, start);
				   pstmt.setInt(2, end);
				   rs = pstmt.executeQuery();
				   
				   if(rs.next()) {
			            list = new ArrayList<ProductDTO>();
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
			               dto.setPpick(rs.getInt("ppick"));
			               dto.setMid(rs.getString("mid"));
			               
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
		   
		   
		   
		   //검색했을때의 정렬용 상품 목록 가져오기
		   public List getProductsSearch(int start,int end,String search,String id) {
		      
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
		               dto.setPpick(rs.getInt("ppick"));
		               dto.setMid(rs.getString("mid"));
		               
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
		
	/* 성민 --------------------------------------------------------------------------------- */
	//물건 찜 해주는 메서드 
		public void Pick(int pnum, String mid) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
				      
			try {
				conn = getConnection();
				String sql="select * from product where pnum=? and mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, mid);
				rs = pstmt.executeQuery(); 
				//결과가 있으면 1로 바꿔주기
				if(rs.next()) {
				 	sql = "update product set ppick=1 where pnum=? and mid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
				  	pstmt.setString(2, mid);
				  	pstmt.executeQuery();
				  	System.out.println("찜완료");
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
		public void NoPick(int pnum,String mid) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
					
			try {
				conn = getConnection();
				String sql="select * from product where pnum=? and mid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, mid);
				rs = pstmt.executeQuery(); 
				//결과가 있으면 0로 바꿔주기
				if(rs.next()) {
					sql = "update product set ppick=0 where pnum=? and mid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					pstmt.setString(2, mid);
					pstmt.executeQuery();
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
	//물건 총 찜갯수 세어주는 메서드
		public int AllPick(String pnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0 ;
			try {
				conn = getConnection();
				String sql = "select count(*) from product where pnum=? and ppick=1";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, pnum);
				rs = pstmt.executeQuery(); 
				//결과가 있으면 0로 바꿔주기
				if(rs.next()) {
					count = rs.getInt(1);
					System.out.println("상품의 찜 개수장전완료");
				}	 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
						
			}return count;
		}
	//모든 상품 세어주는 메서드(성민)
		public int getAllProductCount() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0;
			try {
				conn = getConnection();
				String sql="select count(*) from product ";
				pstmt=conn.prepareStatement(sql);
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
		
	
		
		
		
	// 페이징 처리해서 모든 리스트 가져와주는 메서드(성민)
		public List getAllProductList(int start, int end) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List list = null;
			try {
				conn = getConnection();
				String sql="select B.* from (select rownum r, A.* from (select * from product order by preg desc) A) B where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
	//색에 따른 best 3개 물품 가져오기(성민)
		public List<ProductDTO> getBestProduct(String color){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select B.* from (select A.* from (select * from product where pcon=0 and pcolor='"+color+"' order by preg desc) A order by pgrade desc)B order by psellst desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
						
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("Ppick"));
						dto.setMid(rs.getString("mid"));
								
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
		
		
		//1.판매량순 물품 가져오기(성민)
		public List<ProductDTO> getProductSell(){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select A.* from (select * from product where pcon=0 order by preg desc) A order by psellst desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		//1-1.판매량순 물품 가져오기(성민)
		public List<ProductDTO> getProductSell(int start, int end){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select C.* from (select rownum r, B.* from (select  A.* from (select * from product where pcon=0 order by preg desc) A order by psellst desc)B ) C where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		
		//2.리뷰평점순 물품 가져오기(성민)
		public List<ProductDTO> getProductRgrade(){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select A.* from (select * from product where pcon=0 order by preg desc) A order by pgrade desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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

		
		
		//2-1.리뷰평점순 물품 가져오기(성민)
		public List<ProductDTO> getProductRgrade(int start, int end){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select C.* from (select rownum r, B.* from (select  A.* from (select * from product where pcon=0 order by preg desc) A order by pgrade desc)B )C where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		
		//3.가격 낮은순 물품 가져오기(성민)
		public List<ProductDTO> getProductFprice(){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select A.* from (select * from product where pcon=0 order by preg desc) A order by pprice asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		
		
		
		
		
		//3-1.가격 낮은순 물품 가져오기(성민)
		public List<ProductDTO> getProductFprice(int start, int end){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select C.* from (select rownum r, B.* from (select A.* from (select * from product where pcon=0 order by preg desc) A order by pprice asc )B)C where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		
		//4.가격 높은순 물품 가져오기(성민)
		public List<ProductDTO> getProductEprice(){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select A.* from (select * from product where pcon=0 order by preg desc) A order by pprice desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		//4-1.가격 높은순 물품 가져오기(성민)
		public List<ProductDTO> getProductEprice(int start, int end){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select C.* from (select rownum r, B.* from (select  A.* from (select * from product where pcon=0 order by preg desc) A order by pprice desc)B )C where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		//4.가격 높은순 물품 가져오기(성민)
		public List<ProductDTO> getProductzzim(){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select A.* from (select * from product where pcon=0 order by preg desc) A order by ppick desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		//4-1.가격 높은순 물품 가져오기(성민)
		public List<ProductDTO> getProductzzim(int start, int end){
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> list = null;
			try {
				conn = getConnection();
				String sql="select C.* from (select rownum r, B.* from (select  A.* from (select * from product where pcon=0 order by preg desc) A order by ppick desc)B )C where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList<ProductDTO>();
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
						dto.setPpick(rs.getInt("ppick"));
						dto.setMid(rs.getString("mid"));
						
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
		
		
		
		

		// 페이징 처리해서 모든 리스트 가져와주는 메서드 (컬러 상세검색)(성민)
	      public List<ProductDTO> getAllProductList(int start, int end, String color) {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         List<ProductDTO> list = null;
	         try {
	            conn = getConnection();
	            String sql="select B.* from (select rownum r, A.* from (select * from product where pcon=0 and pcolor='"+color+"' order by preg desc) A) B where r >= ? and r <= ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, start);
	            pstmt.setInt(2, end);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	               list = new ArrayList<ProductDTO>();
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
	                  dto.setPpick(rs.getInt("ppick"));
	                  dto.setMid(rs.getString("mid"));
	                  
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
	      
	      
		
	      //상세 검색 물품 물품 타입만 1
	      public List<ProductDTO> getSearchTypeProductList(String productType) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and ptype='"+productType+"' order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      //상세 검색 물품 물품 타입만 1-1(페이징 처리)
	      public List<ProductDTO> getSearchTypeProductList(String productType, int start , int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and ptype='"+productType+"' order by preg desc)A)B"
	    				  + " where r >=? and r <=?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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
	      
	      
	      //상세 검색 물품 물품 색상만 2
	      public List<ProductDTO> getSearchColorProductList(String color1) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and pcolor='"+color1+"' order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      //상세 검색 물품 물품 색상만 2-1(페이징 처리)
	      public List<ProductDTO> getSearchColorProductList(String color1, int start , int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and pcolor='"+color1+"' order by preg desc)A)B"
	    				  + " where r >= ? and r <= ?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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
	      
	      
	      
	      //상세 검색 물품 물품 가격만 3
	      public List<ProductDTO> getSearchPriceProductList(int fPrice, int ePrice) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      
	      //상세 검색 물품 물품 가격만 3-1 페이징 처리
	      public List<ProductDTO> getSearchPriceProductList(int fPrice, int ePrice, int start, int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc)A)B"
	    				  + " where r >= ? and r <= ?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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
	      
	      
	      
	      //상세 검색 물품 물품 타입 & 가격 4 
	      public List<ProductDTO> getSearchProductList(String productType ,int fPrice, int ePrice) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and ptype='"+productType+"' and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      //상세 검색 물품 물품 타입 & 가격 4-1(페이징 처리
	      public List<ProductDTO> getSearchProductList(String productType ,int fPrice, int ePrice,int start,int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and ptype='"+productType+"' and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc)A)B"
	    				  + " where r >= ? and r <= ?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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

	      //상세 검색 물품 물품 타입 & 색상 5
	      public List<ProductDTO> getSearchProductList(String productType ,String color1) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and ptype='"+productType+"' and pcolor='"+color1+"' order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      //상세 검색 물품 물품 타입 & 색상 5-1(페이징 처리 완료)
	      public List<ProductDTO> getSearchProductList(String productType ,String color1,int start, int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and ptype='"+productType+"' and pcolor='"+color1+"' order by preg desc)A)B"
	    				  + " where r >= ? and r <= ?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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
	      
	      //상세 검색 물품 물품 색상 & 가격6
	      public List<ProductDTO> getSearchProductList(int fPrice, int ePrice,String color1) {
		         Connection conn = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         List<ProductDTO> list = null;
		         try {
		            conn = getConnection();
		            String sql="select * from product where pcon=0 and pcolor='"+color1+"' and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc";
		            pstmt = conn.prepareStatement(sql);
		            rs = pstmt.executeQuery();
		            if(rs.next()) {
		               list = new ArrayList<ProductDTO>();
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
		                  dto.setPpick(rs.getInt("ppick"));
		                  dto.setMid(rs.getString("mid"));
		                  
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
	      //상세 검색 물품 물품 색상 & 가격6
	      public List<ProductDTO> getSearchProductList(int fPrice, int ePrice,String color1, int start,int end) {
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  List<ProductDTO> list = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select B.* from (select rownum r, A.* from "
	    				  +"(select * from product where pcon=0 and pcolor='"+color1+"' and pprice>"+fPrice+" and pprice<"+ePrice+" order by preg desc)A)B"
	    				  + " where r >= ? and r <= ?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setInt(1, start);
	    		  pstmt.setInt(2, end);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  list = new ArrayList<ProductDTO>();
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
	    				  dto.setPpick(rs.getInt("ppick"));
	    				  dto.setMid(rs.getString("mid"));
	    				  
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
		
	      
			//재고 하나 내려주는 메서드 
			
			public int downStock(int Pnum, int buyst) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int stock = 0;
				try {
					conn = getConnection();
					String sql = "select pstock from Product where Pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Pnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						stock = rs.getInt(1)-buyst;
						System.out.println("stock:"+stock);
						
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}return stock;
			}
			
			
			
			//재고 업데이트 해주는 메서드 
			
			public void updateStock(int Pnum, int remainStock) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				try {
					conn = getConnection();
					String sql = "update product set pstock=? where Pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, remainStock);
					pstmt.setInt(2, Pnum);
					pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
			//판매량 업데이트 해주는 메서드 
			
			public void updateSellStock(int Pnum, int sellst) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				try {
					conn = getConnection();
					String sql = "update product set psellst=? where Pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, sellst);
					pstmt.setInt(2, Pnum);
					pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
					if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
				}
			}
				
		public int getPnum(int bnum){
	    	  int pnum = 0;
	    	  Connection conn = null;
	    	  PreparedStatement pstmt = null;
	    	  ResultSet rs = null;
	    	  try {
	    		  conn = getConnection();
	    		  String sql="select pnum from buy where bnum=?";
	    		  pstmt=conn.prepareStatement(sql);
	    		  pstmt.setInt(1, bnum);
	    		  rs = pstmt.executeQuery();
	    		  if(rs.next()) {
	    			  pnum = rs.getInt(1);
	    		  }
	    	  }catch(Exception e) {
	    		  e.printStackTrace();
	    	  }finally {
	    		  if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();};
	    		  if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
	    		  if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
	    	  }
	    	  
	    	  return pnum;
	      }
	      
	      
	   //평점 업데이트 해주는 메서드
			
		public void updatePgrade(double ave,int pnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = getConnection();
				String sql="update product set pgrade=? where pnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setDouble(1, ave);
				pstmt.setInt(2, pnum);
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();};
				if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();};
			}
		}
			
			
			
	      
}
	
	
	
	
	
	
	
	
	

