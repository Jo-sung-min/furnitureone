package web.team.one;

import java.sql.Timestamp;

public class QnaDTO {

	private int qnum;
	private String qtitle;
	private String qcontent;
	private int mnum;
	private String qimg;
	private String acontent;
	private int qreadcount;
	private Timestamp areg;
	private Timestamp qreg;
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	public String getQtitle() {
		return qtitle;
	}
	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public String getQimg() {
		return qimg;
	}
	public void setQimg(String qimg) {
		this.qimg = qimg;
	}
	public String getAcontent() {
		return acontent;
	}
	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}
	public int getQreadcount() {
		return qreadcount;
	}
	public void setQreadcount(int qreadcount) {
		this.qreadcount = qreadcount;
	}
	public Timestamp getAreg() {
		return areg;
	}
	public void setAreg(Timestamp areg) {
		this.areg = areg;
	}
	public Timestamp getQreg() {
		return qreg;
	}
	public void setQreg(Timestamp qreg) {
		this.qreg = qreg;
	}
	
	
	
	
}
