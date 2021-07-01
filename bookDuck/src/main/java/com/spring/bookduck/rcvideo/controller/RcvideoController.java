package com.spring.bookduck.rcvideo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.bookduck.model.dto.MemberDto;
import com.spring.bookduck.rcvideo.biz.RcvideoBiz;
import com.spring.bookduck.rcvideo.dto.RcvideoDto;
import com.spring.bookduck.scrap.biz.ScrapBiz;
import com.spring.bookduck.scrap.dto.ScrapDto;

@Controller
public class RcvideoController {

	@Autowired
	private RcvideoBiz biz;
	
	@Autowired
	private ScrapBiz scbiz;

	@RequestMapping("rcinsertres.do")
	public String rcinsertres(HttpSession session, HttpServletRequest request,Model model) {
		
		
		String title = request.getParameter("title");
		String isbn = request.getParameter("isbn");
		String coverLargeUrl = request.getParameter("coverLargeUrl");
		String author = request.getParameter("author");
		String categoryId = request.getParameter("categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		
		return "rcvideo/rcinsertres";
	}

	@RequestMapping("rcinsert.do")
	public String rcinsert(HttpSession session, HttpServletRequest request,RcvideoDto rcdto,Model model) {
		String title = request.getParameter("book_title");
		String isbn = request.getParameter("book_isbn");
		String coverLargeUrl = request.getParameter("book_coverLargeUrl");
		String author = request.getParameter("book_author");
		String categoryId = request.getParameter("book_categoryId");
		
		ScrapDto scdto = new ScrapDto();
		
		scdto.setBook_isbn(isbn);
		scdto.setBook_title(title);
		scdto.setBook_coverLargeUrl(coverLargeUrl);
		scdto.setBook_author(author);
		scdto.setBook_categoryId(categoryId);
		model.addAttribute("scrapDto",scdto);
		System.out.println(title+isbn+coverLargeUrl+author+categoryId);
		if(biz.rcinsert(rcdto)>0) {
			model.addAttribute("rclist",biz.rcselectone(isbn));
			return "book/recommendBook";
		}
			
		return "redirect";
	}
	
	@RequestMapping("deletercvideo.do")
	public String rcdelete(int rcvideo_no,ScrapDto scdto) {
		
		if(biz.rcdelete(rcvideo_no)>0) {
			return "book/recommendBook";
		}
		
		return "book/recommendBook";
	}

}













