package com.spring.finalproject.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.finalproject.Employee.model.vo.Employee;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		
		if(loginEmp==null) {
			logger.info("비로그인 상태에서 [" + request.getRequestURI()+"]에 접근하려고 함");
			
			request.setAttribute("msg", "게시판 기능은 대부분 로그인을 하셔야 이용하실 수 있습니다.");
			request.getRequestDispatcher("/WEB-INF/Views/home.jsp").forward(request, response);
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
}
