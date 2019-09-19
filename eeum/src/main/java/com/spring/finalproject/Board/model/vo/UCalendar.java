package com.spring.finalproject.Board.model.vo;

public class UCalendar {
	private int cNo;
	private String empNo;
	private String cDate;//시작일
	private String cTitle;//일정 제목
	private String cStatus;//일정 상태
	private String cFDate;// 일정 종료일
	private String sEmp; // 공유받은 emp
	
	
	
	public UCalendar() {
		super();
	}
	public UCalendar(int cNo, String empNo, String cDate, String cTitle, String cStatus, String cFDate, String sEmp) {
		super();
		this.cNo = cNo;
		this.empNo = empNo;
		this.cDate = cDate;
		this.cTitle = cTitle;
		this.cStatus = cStatus;
		this.cFDate = cFDate;
		this.sEmp = sEmp;
	}
	@Override
	public String toString() {
		return "Calendar [cNo=" + cNo + ", empNo=" + empNo + ", cDate=" + cDate + ", cTitle=" + cTitle + ", cStatus="
				+ cStatus + ", cFDate=" + cFDate + ", sEmp=" + sEmp + "]";
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	public String getcTitle() {
		return cTitle;
	}
	public void setcTitle(String cTitle) {
		this.cTitle = cTitle;
	}
	public String getcStatus() {
		return cStatus;
	}
	public void setcStatus(String cStatus) {
		this.cStatus = cStatus;
	}
	public String getcFDate() {
		return cFDate;
	}
	public void setcFDate(String cFDate) {
		this.cFDate = cFDate;
	}
	public String getsEmp() {
		return sEmp;
	}
	public void setsEmp(String sEmp) {
		this.sEmp = sEmp;
	}
}
