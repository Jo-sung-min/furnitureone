package web.team.one;

import java.sql.Timestamp;

public class ReviewDTO {
	
	private int rnum;
	private String rimg;
	private int pnum;
	private String rcontent;
	private int mnum;
	private String rgrade;
	private Timestamp rreg;
	private String mid;
	private int rcon;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getRimg() {
		return rimg;
	}
	public void setRimg(String rimg) {
		this.rimg = rimg;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getRgrade() {
		return rgrade;
	}
	public void setRgrade(String rgrade) {
		this.rgrade = rgrade;
	}
	public Timestamp getRreg() {
		return rreg;
	}
	public void setRreg(Timestamp rreg) {
		this.rreg = rreg;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getRcon() {
		return rcon;
	}
	public void setRcon(int rcon) {
		this.rcon = rcon;
	}
	 
	
	
	
	
}
