package com.spring.finalproject.Board.model.vo;

import java.sql.Date;

public class Board {
	private int bNo;
	private String empNo;
	private String empName;//db에 없음
	private String bType;
	private String bTitle;
	private String bContent;
	private int bCount;
	private Date bDate;
	private Date modifyDate;
	//상태 status vo에 없음
	
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getbType() {
		return bType;
	}
	public void setbType(String bType) {
		this.bType = bType;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public int getbCount() {
		return bCount;
	}
	public void setbCount(int bCount) {
		this.bCount = bCount;
	}
	public Date getbDate() {
		return bDate;
	}
	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public Board(int bNo, String empNo, String empName, String bType, String bTitle, String bContent, int bCount,
			Date bDate, Date modifyDate) {
		super();
		this.bNo = bNo;
		this.empNo = empNo;
		this.empName = empName;
		this.bType = bType;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCount = bCount;
		this.bDate = bDate;
		this.modifyDate = modifyDate;
	}
	public Board() {
		super();
	}
	@Override
	public String toString() {
		return "Board [bNo=" + bNo + ", empNo=" + empNo + ", empName=" + empName + ", bType=" + bType + ", bTitle="
				+ bTitle + ", bContent=" + bContent + ", bCount=" + bCount + ", bDate=" + bDate + ", modifyDate="
				+ modifyDate + "]";
	}
	

}
