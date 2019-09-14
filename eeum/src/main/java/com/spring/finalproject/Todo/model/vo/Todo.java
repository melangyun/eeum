package com.spring.finalproject.Todo.model.vo;

import java.sql.Date;

public class Todo {
	private int tNo;
	private String empNo;
	private String tImport;
	private Date tDate;
	private String tContent;
	private String tTitle;
	private Date tDone;
	private String tStatus;
	
	
	
	public Todo() {
		super();
	}



	public Todo(int tNo, String empNo, String tImport, Date tDate, String tContent, String tTitle, Date tDone,
			String tStatus) {
		super();
		this.tNo = tNo;
		this.empNo = empNo;
		this.tImport = tImport;
		this.tDate = tDate;
		this.tContent = tContent;
		this.tTitle = tTitle;
		this.tDone = tDone;
		this.tStatus = tStatus;
	}



	public int gettNo() {
		return tNo;
	}



	public void settNo(int tNo) {
		this.tNo = tNo;
	}



	public String getEmpNo() {
		return empNo;
	}



	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}



	public String gettImport() {
		return tImport;
	}



	public void settImport(String tImport) {
		this.tImport = tImport;
	}



	public Date gettDate() {
		return tDate;
	}



	public void settDate(Date tDate) {
		this.tDate = tDate;
	}



	public String gettContent() {
		return tContent;
	}



	public void settContent(String tContent) {
		this.tContent = tContent;
	}



	public String gettTitle() {
		return tTitle;
	}



	public void settTitle(String tTitle) {
		this.tTitle = tTitle;
	}



	public Date gettDone() {
		return tDone;
	}



	public void settDone(Date tDone) {
		this.tDone = tDone;
	}



	public String gettStatus() {
		return tStatus;
	}



	public void settStatus(String tStatus) {
		this.tStatus = tStatus;
	}



	@Override
	public String toString() {
		return "Todo [tNo=" + tNo + ", empNo=" + empNo + ", tImport=" + tImport + ", tDate=" + tDate + ", tContent="
				+ tContent + ", tTitle=" + tTitle + ", tDone=" + tDone + ", tStatus=" + tStatus + "]";
	}

	
}
