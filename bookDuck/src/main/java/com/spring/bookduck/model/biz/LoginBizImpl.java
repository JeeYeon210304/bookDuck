package com.spring.bookduck.model.biz;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bookduck.model.dao.LoginDao;
import com.spring.bookduck.model.dto.MemberDto;

@Service
public class LoginBizImpl implements LoginBiz {
	
	@Autowired
	private LoginDao dao;

	@Override
	public MemberDto login(MemberDto dto) {
		return dao.login(dto);
	}

	@Override
	public int join(MemberDto dto) {
		return dao.join(dto);
	}

	@Override
	public MemberDto snslogin(String member_email) {
		return null;
	}

	@Override
	public int updatePw(MemberDto dto) {
		return dao.updatePw(dto);
	}

	@Override
	public void leaveAccount(MemberDto dto) {
		dao.leaveAccount(dto);
	}

	@Override
	public int idCheck(MemberDto dto) {
		return dao.idCheck(dto);
	}

	@Override
	public MemberDto findId(MemberDto dto) {
		return dao.findId(dto);
	}

	@Override
	public void findPw(HttpServletResponse response, MemberDto dto) {
		
	}

}
