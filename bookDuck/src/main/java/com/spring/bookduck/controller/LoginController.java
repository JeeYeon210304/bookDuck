package com.spring.bookduck.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.bookduck.model.biz.LoginBiz;
import com.spring.bookduck.model.dao.LoginDao;
import com.spring.bookduck.model.dao.LoginDaoImpl;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class LoginController {
	
	private Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginBiz biz;
	
	@RequestMapping("/loginform.do")
	public String loginForm() {
		logger.info("[Controller] : loginform.do");
		return "member/login";
	}
	
	@RequestMapping(value="/ajaxlogin.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> ajaxLogin(HttpSession session, @RequestBody MemberDto dto){
		
		logger.info("[Controller] : ajaxlogin.do");
		MemberDto res = biz.login(dto);
		boolean check = false;
		if(res !=null) {
			session.setAttribute("login", res);
			check=true;
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		
		return map;
		
	}
	
	@RequestMapping("/joinform.do")
	public String JoinForm() {
		logger.info("[Controller] : joinform.do");
		return "member/joinform";
	}
	
	@RequestMapping(value = "/memberIdChk", method=RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPost(String member_id) throws Exception{
		logger.info("[Controller] : memberIdChk");
		int res = biz.idCheck(member_id);
		logger.info("결과값="+res);
		if(res!=0) {
			return "fail"; //중복 아이디 존재
		}else {
			return "success"; //중복 아이디x
		}
		
	}
	
	@RequestMapping(value="/reg.do", method=RequestMethod.POST)
	public String Reg(MemberDto dto) {
		logger.info("[Controller] : reg.do");
		if(biz.join(dto)>0) {
			return "redirect:loginform.do";
		}
		return "redirect:joinform.do";
	}
	
}