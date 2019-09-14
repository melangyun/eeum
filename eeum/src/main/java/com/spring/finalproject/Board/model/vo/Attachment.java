package com.spring.finalproject.Board.model.vo;

public class Attachment {
	private String aNo;
	private String aType;
	private String origin;
	private String change;
	//uploadDate field 없음, statuas, bno, apno, eno없음
	
	public Attachment() {
		super();
	}
	
	
	public Attachment(String aNo, String aType, String origin, String change) {
		super();
		this.aNo = aNo;
		this.aType = aType;
		this.origin = origin;
		this.change = change;
	}
	
	@Override
	public String toString() {
		return "Attachment [aNo=" + aNo + ", aType=" + aType + ", origin=" + origin + ", change=" + change + "]";
	}
	public String getaNo() {
		return aNo;
	}
	public void setaNo(String aNo) {
		this.aNo = aNo;
	}
	public String getaType() {
		return aType;
	}
	public void setaType(String aType) {
		this.aType = aType;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getChange() {
		return change;
	}
	public void setChange(String change) {
		this.change = change;
	}
	
	
}
