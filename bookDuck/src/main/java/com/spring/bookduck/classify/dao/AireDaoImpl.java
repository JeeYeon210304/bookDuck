package com.spring.bookduck.classify.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.spring.bookduck.classify.dto.AireDto;

public class AireDaoImpl implements AireDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AireDto> totalRe() {
		
		List<AireDto> list = new ArrayList<AireDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "totalre");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public AireDto findReOne(String memberId) {
		
		AireDto dto = new AireDto();
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"findone", memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return dto;
	}

	@Override
	public int insertRe(AireDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertRe", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int updateRe(AireDto dto) {

		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updateRe", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int deleteRe(String memberId) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"deleteRe", memberId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return res;
	}

}