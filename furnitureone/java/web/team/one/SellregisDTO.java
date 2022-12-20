package web.team.one;

import java.sql.Timestamp;

public class SellregisDTO {

		private int mnum;
		private String scompany;
		private String saddr;
		private String scall;
		private String srepresent;
		private String shwanaddr;
		private int sbnum;
		private int scon;
		private Timestamp sreg;
		
		public int getMnum() {
			return mnum;
		}
		public void setMnum(int mnum) {
			this.mnum = mnum;
		}
		public String getScompany() {
			return scompany;
		}
		public void setScompany(String scompany) {
			this.scompany = scompany;
		}
		public String getSaddr() {
			return saddr;
		}
		public void setSaddr(String saddr) {
			this.saddr = saddr;
		}
		public String getScall() {
			return scall;
		}
		public void setScall(String scall) {
			this.scall = scall;
		}
		public String getSrepresent() {
			return srepresent;
		}
		public void setSrepresent(String srepresent) {
			this.srepresent = srepresent;
		}
		public String getShwanaddr() {
			return shwanaddr;
		}
		public void setShwanaddr(String shwanaddr) {
			this.shwanaddr = shwanaddr;
		}
		public int getSbnum() {
			return sbnum;
		}
		public void setSbnum(int sbnum) {
			this.sbnum = sbnum;
		}
		public int getScon() {
			return scon;
		}
		public void setScon(int scon) {
			this.scon = scon;
		}
		public Timestamp getSreg() {
			return sreg;
		}
		public void setSreg(Timestamp sreg) {
			this.sreg = sreg;
		}
}