package com.kh.project.kim.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.project.kim.service.CommentService;
import com.kh.project.vo.BasketVo;
import com.kh.project.vo.CommentVo;
import com.kh.project.vo.MemberVo;

@RestController
@RequestMapping("/comment/*")
public class CommentController {

	@Autowired
	private CommentService commentService;

	@RequestMapping(value = "/insertComment", method = RequestMethod.POST)
	// @ResponseBody
	public String insertComment(CommentVo commentVo, HttpSession session) {
		commentVo.setUserid(((MemberVo) session.getAttribute("loginInfo")).getUserid());
		System.out.println("commentVo:" + commentVo);
		boolean result = commentService.insertComment(commentVo);
		return String.valueOf(result);
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	// @ResponseBody
	public List<CommentVo> list(int pro_no) {
		System.out.println("comment list");
		return commentService.list(pro_no);
	}

	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(int cno, int pro_no) {
		System.out.println("cno:" + cno);
		boolean result = commentService.deleteComment(cno, pro_no);
		return String.valueOf(result);
	}

	@RequestMapping(value = "/modifyComment", method = RequestMethod.POST)
	public String modifyComment(CommentVo commentVo) {
		System.out.println("commentVo:" + commentVo);
		boolean result = commentService.modifyComment(commentVo);
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/insertBasket", method = RequestMethod.POST)
	public String insertBasket(BasketVo basketVo, HttpSession session) {
		System.out.println("dd");
		System.out.println(basketVo);
		return commentService.insertBasket(basketVo);
	}
}
