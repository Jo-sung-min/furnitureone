package web.team.one;

import java.sql.Timestamp;

public class ProductDTO {
	private int pnum;
	private String pimg;
	private String pname;
	private String pcolor;
	private int pprice;
	private String ptype;
	private int pstock;
	private int psellst;
	private int ppick;
	private String pcontent;
	private int pgrade;
	private int pcon;
	private	Timestamp preg;
	private String mid;
	
	public int getPnum() {return pnum;}
	public void setPnum(int pnum) {this.pnum = pnum;}
	
	public String getPimg() {return pimg;}
	public void setPimg(String pimg) {this.pimg = pimg;}
	
	public String getPname() {return pname;}
	public void setPname(String pname) {this.pname = pname;}
	
	public String getPcolor() {return pcolor;}
	public void setPcolor(String pcolor) {this.pcolor = pcolor;}
	
	public int getPprice() {return pprice;}
	public void setPprice(int pprice) {this.pprice = pprice;}
	
	public String getPtype() {return ptype;}
	public void setPtype(String ptype) {this.ptype = ptype;}
	
	public int getPstock() {return pstock;}
	public void setPstock(int pstock) {this.pstock = pstock;}
	
	public int getPsellst() {return psellst;}
	public void setPsellst(int psellst) {this.psellst = psellst;}
	
	public int getPpick() {return ppick;}
	public void setPpick(int ppick) {this.ppick = ppick;}
	
	public String getPcontent() {return pcontent;}
	public void setPcontent(String pcontent) {this.pcontent = pcontent;}
	
	public int getPgrade() {return pgrade;}
	public void setPgrade(int pgrade) {this.pgrade = pgrade;}
	
	public int getPcon() {return pcon;}
	public void setPcon(int pcon) {this.pcon = pcon;}
	
	public Timestamp getPreg() {return preg;}
	public void setPreg(Timestamp preg) {this.preg = preg;}
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	
	
}