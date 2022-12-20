package web.team.one;

import java.sql.Timestamp;

public class NoticeDTO {



	private int nnum;
	private String ntitle;
	private String ncontent;
	private String nimg;
	private int nreadcount;
	private Timestamp nreg;
	
	public int getNnum() {
		return nnum;
	}
	public void setNnum(int nnum) {
		this.nnum = nnum;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public String getNimg() {
		return nimg;
	}
	public void setNimg(String nimg) {
		this.nimg = nimg;
	}
	public int getNreadcount() {
		return nreadcount;
	}
	public void setNreadcount(int nreadcount) {
		this.nreadcount = nreadcount;
	}
	public Timestamp getNreg() {
		return nreg;
	}
	public void setNreg(Timestamp nreg) {
		this.nreg = nreg;
	}
}	
