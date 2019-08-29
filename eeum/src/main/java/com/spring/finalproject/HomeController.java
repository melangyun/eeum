package com.spring.finalproject;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
//	private Logger logger = LoggerFactory.getLogger(LoggerAspect.class);
	
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}

//	@GetMapping("/")
//	public String index(HttpServletRequest request) {
//	    logger.debug("###INDEX PAGE###");
//	    String rtnPage = "index";
//	    String ipAddress = request.getHeader("X-FORWARDED-FOR");
//	    if (ipAddress == null) {
//	        ipAddress = request.getRemoteAddr();
//	    }
//	    logger.info(ipAddress + " : " + rtnPage);
//	    return rtnPage;
//	}

}
