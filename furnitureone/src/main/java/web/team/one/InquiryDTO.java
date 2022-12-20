package web.team.one;

import java.sql.Timestamp;

public class InquiryDTO {
	private int inum;
	private int pnum;
	private String mid;
	private String question;
	private String answer;
	private int icon;
	private Timestamp qreg;
	private Timestamp areg;
	private String sid;
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getIcon() {
		return icon;
	}
	public void setIcon(int icon) {
		this.icon = icon;
	}
	public Timestamp getQreg() {
		return qreg;
	}
	public void setQreg(Timestamp qreg) {
		this.qreg = qreg;
	}
	public Timestamp getAreg() {
		return areg;
	}
	public void setAreg(Timestamp areg) {
		this.areg = areg;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	
	
	
}
