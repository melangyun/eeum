package com.spring.finalproject.Board.model.vo;

public class Calendar {
	private int cNo;
	private String empNo;
	private String cDate;//시작일
	private String cType;//캘린더 유형
	private String cTitle;//일정 제목
	private String cStatus;//일정 상태
	private String cFDate;// 일정 종료일
	
	
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
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
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
	public Calendar(int cNo, String empNo, String cDate, String cType, String cTitle, String cStatus, String cFDate) {
		super();
		this.cNo = cNo;
		this.empNo = empNo;
		this.cDate = cDate;
		this.cType = cType;
		this.cTitle = cTitle;
		this.cStatus = cStatus;
		this.cFDate = cFDate;
	}
	public Calendar() {
		super();
	}

	@Override
	public String toString() {
		return "Calendar [cNo=" + cNo + ", empNo=" + empNo + ", cDate=" + cDate + ", cType=" + cType + ", cTitle="
				+ cTitle + ", cStatus=" + cStatus + ", cFDate=" + cFDate + "]";
	}
}
