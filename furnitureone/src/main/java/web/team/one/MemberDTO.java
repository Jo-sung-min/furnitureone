package web.team.one;

import java.sql.Timestamp;

public class MemberDTO {

	private int mnum;
	private String mid;
	private String mimg;
	private String mpw;
	private String mname;
	private String mtel;
	private String memail;
	private String mtype;
	private int mcon;
	private Timestamp mreg;
	
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMimg() {
		return mimg;
	}
	public void setMimg(String mimg) {
		this.mimg = mimg;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public int getMcon() {
		return mcon;
	}
	public void setMcon(int mcon) {
		this.mcon = mcon;
	}
	public Timestamp getMreg() {
		return mreg;
	}
	public void setMreg(Timestamp mreg) {
		this.mreg = mreg;
	}
	
	
}
