package com.spring.finalproject.Mail.model.vo;

import java.sql.Date;

public class Mail {
	private int mailNo;
	private String empNo;
	private String empName;//디비에 없음 - 받는사람 읽기용.-보낸이 이름
	private String recieveEmp;
	private String eType;
	private String eTitle;
	private String eContent;
	private Date eRTime;//읽은시간
	private Date sendTime;
	private String eStatus;
	private String recieveEmpName;//받는이 이름
	
	public int getMailNo() {
		return mailNo;
	}
	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
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
	public String getRecieveEmp() {
		return recieveEmp;
	}
	public void setRecieveEmp(String recieveEmp) {
		this.recieveEmp = recieveEmp;
	}
	public String geteType() {
		return eType;
	}
	public void seteType(String eType) {
		this.eType = eType;
	}
	public String geteTitle() {
		return eTitle;
	}
	public void seteTitle(String eTitle) {
		this.eTitle = eTitle;
	}
	public String geteContent() {
		return eContent;
	}
	public void seteContent(String eContent) {
		this.eContent = eContent;
	}
	public Date geteRTime() {
		return eRTime;
	}
	public void seteRTime(Date eRTime) {
		this.eRTime = eRTime;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	public String geteStatus() {
		return eStatus;
	}
	public void seteStatus(String eStatus) {
		this.eStatus = eStatus;
	}
	public String getRecieveEmpName() {
		return recieveEmpName;
	}
	public void setRecieveEmpName(String recieveEmpName) {
		this.recieveEmpName = recieveEmpName;
	}
	public Mail(int mailNo, String empNo, String empName, String recieveEmp, String eType, String eTitle,
			String eContent, Date eRTime, Date sendTime, String eStatus, String recieveEmpName) {
		super();
		this.mailNo = mailNo;
		this.empNo = empNo;
		this.empName = empName;
		this.recieveEmp = recieveEmp;
		this.eType = eType;
		this.eTitle = eTitle;
		this.eContent = eContent;
		this.eRTime = eRTime;
		this.sendTime = sendTime;
		this.eStatus = eStatus;
		this.recieveEmpName = recieveEmpName;
	}
	
	
	
	public Mail() {
		super();
	}
	@Override
	public String toString() {
		return "Mail [mailNo=" + mailNo + ", empNo=" + empNo + ", empName=" + empName + ", recieveEmp=" + recieveEmp
				+ ", eType=" + eType + ", eTitle=" + eTitle + ", eContent=" + eContent + ", eRTime=" + eRTime
				+ ", sendTime=" + sendTime + ", eStatus=" + eStatus + ", recieveEmpName=" + recieveEmpName + "]";
	}
	
	
	
	
}
