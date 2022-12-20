package web.team.one;

import java.sql.Timestamp;

public class BuyDTO {
	private int bnum;
	private int pnum;
	private int mnum;
	private String baddr;
	private int bbuyst;
	private String bpaytype;
	private int bprice;
	private int bcon;
	private int bdelcon;
	private	Timestamp breg;
	private int snum;
	private String pname;
	
	
	public int getBnum() {return bnum;}
	public void setBnum(int bnum) {this.bnum = bnum;}
	
	public int getPnum() {return pnum;}
	public void setPnum(int pnum) {this.pnum = pnum;}
	
	public int getMnum() {return mnum;}
	public void setMnum(int mnum) {this.mnum = mnum;}
	
	public String getBaddr() {return baddr;}
	public void setBaddr(String baddr) {this.baddr = baddr;}
	
	public int getBbuyst() {return bbuyst;}
	public void setBbuyst(int bbuyst) {this.bbuyst = bbuyst;}
	
	public String getBpaytype() {return bpaytype;}
	public void setBpaytype(String bpaytype) {this.bpaytype = bpaytype;}
	
	public int getBprice() {return bprice;}
	public void setBprice(int bprice) {this.bprice = bprice;}
	
	public int getBcon() {return bcon;}
	public void setBcon(int bcon) {this.bcon = bcon;}
	
	public int getBdelcon() {return bdelcon;}
	public void setBdelcon(int bdelcon) {this.bdelcon = bdelcon;}
	
	public Timestamp getBreg() {return breg;}
	public void setBreg(Timestamp breg) {this.breg = breg;}
	
	public int getSnum() {return snum;}
	public void setSnum(int snum) {this.snum = snum;}
	
	public String getPname() {return pname;}
	public void setPname(String pname) {this.pname = pname;}
	
}
