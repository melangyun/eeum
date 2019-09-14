package com.spring.finalproject.Mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Mail.model.vo.Mail;

public interface MailService {
	
	//사원검색
	ArrayList<Employee> searchEmp(String search);

	//메일 전송
	int sendEmail(Mail mail);

	int SearchMListCount(HashMap<String,String> map);

	ArrayList<Mail> selectMSearchList(PageInfo pi, HashMap<String, String> map);

	int updateMail(Mail mail);

	int updateReadTime(String mailNo);

	int SearchBListCount(HashMap<String, String> map);

	ArrayList<Mail> selectBSearchList(PageInfo pi, HashMap<String, String> map);



}
