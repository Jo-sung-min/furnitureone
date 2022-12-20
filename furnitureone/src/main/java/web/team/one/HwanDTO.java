package web.team.one;

import java.sql.Timestamp;

public class HwanDTO {
	
	private int hnum;
	private int bnum;
	private int hcon;
	private String hreason;
	private Timestamp hreg;
	private int mnum;
	private int snum;
	private String pname;
	public int getHnum() {
		return hnum;
	}
	public void setHnum(int hnum) {
		this.hnum = hnum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getHcon() {
		return hcon;
	}
	public void setHcon(int hcon) {
		this.hcon = hcon;
	}
	public String getHreason() {
		return hreason;
	}
	public void setHreason(String hreason) {
		this.hreason = hreason;
	}
	public Timestamp getHreg() {
		return hreg;
	}
	public void setHreg(Timestamp hreg) {
		this.hreg = hreg;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	
}
