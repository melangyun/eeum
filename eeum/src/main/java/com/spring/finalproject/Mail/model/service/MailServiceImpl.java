package com.spring.finalproject.Mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Mail.model.dao.MailDAO;
import com.spring.finalproject.Mail.model.vo.Mail;

@Service("mService")
public class MailServiceImpl implements MailService{
	
	@Autowired MailDAO mDAO;
	
	//사원검색
	@Override
	public ArrayList<Employee> searchEmp(String search) {
		return mDAO.searchEmp(search);
	}
	
	//메일 전송
	@Override
	public int sendEmail(Mail mail) {
		return mDAO.sendEmail(mail);
	}

	@Override
	public int SearchMListCount(HashMap<String,String> map) {
		return mDAO.SearchMListCount(map);
	}

	@Override
	public ArrayList<Mail> selectMSearchList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectMSearchList(pi,map);
	}

	@Override
	public int updateMail(Mail mail) {
		return mDAO.updateMail(mail);
	}

	@Override
	public int updateReadTime(String mailNo) {
		return mDAO.updateReadTime(mailNo);
	}

	@Override
	public int SearchBListCount(HashMap<String, String> map) {
		return mDAO.SearchBListCount(map);
	}

	@Override
	public ArrayList<Mail> selectBSearchList(PageInfo pi, HashMap<String, String> map) {
		return mDAO.selectBSearchList(pi,map);
	}


}
