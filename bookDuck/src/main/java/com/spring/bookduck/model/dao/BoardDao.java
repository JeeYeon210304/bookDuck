package com.spring.bookduck.model.dao;

import java.util.List;

import com.spring.bookduck.model.dto.CommentDto;
import com.spring.bookduck.model.dto.PageInfo;
import com.spring.bookduck.model.dto.PostDto;

public interface BoardDao {
	
	static String NAMESPACE = "boardMapper.";
	
	// 게시판 리스트 조회 (페이징 처리)
	public int selectListCount(int board_id);
	public List<PostDto> selectList(PageInfo pi, int board_id);
	
	// 게시글 상세조회
	public int increaseCount(int post_id);
	public PostDto selectOne(int post_id);
	
	// 게시글 작성
	public int insertNotice(PostDto dto);
	public int insertQNA(PostDto dto);
	
	// 게시글 수정
	public int updateBoard(PostDto dto);
	
	// 게시글 삭제
	public int deleteBoard(int post_id);
	
	// 댓글 조회
	List<CommentDto> selectCommentList(int post_id);

	//댓글 작성
	public int insertComment(CommentDto dto);
	public int increaseComment(int post_id);
}
