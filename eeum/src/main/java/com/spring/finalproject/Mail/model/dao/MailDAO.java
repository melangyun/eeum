package com.spring.finalproject.Mail.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Mail.model.vo.Mail;

@Repository("mDAO")
public class MailDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Employee> searchEmp(String search) {
		return (ArrayList)sqlSession.selectList("mMapper.searchEmp",search);
	}

	public int sendEmail(Mail mail) {
		return sqlSession.insert("mMapper.sendEmail",mail);
	}

	public int SearchMListCount(HashMap<String,String> map) {
		return sqlSession.selectOne("mMapper.SearchMListCount",map);
	}

	public ArrayList<Mail> selectMSearchList(PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mMapper.selectMSearchList",map,rowBounds);
	}

	public int updateMail(Mail mail) {
		return sqlSession.update("mMapper.updateMail", mail);
	}

	public int updateReadTime(String mailNo) {
		return sqlSession.update("mMapper.updateReadTime",mailNo);
	}

	public int SearchBListCount(HashMap<String, String> map) {
		return sqlSession.selectOne("mMapper.SearchBListCount",map);
	}

	public ArrayList<Mail> selectBSearchList(PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("mMapper.selectBSearchList",map,rowBounds);
	}


}
