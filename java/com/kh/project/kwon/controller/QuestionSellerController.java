package com.kh.project.kwon.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.project.kwon.service.QuestionSellerService;
import com.kh.project.vo.QuestionVo;

@Controller
@RequestMapping("/questionseller/*")
public class QuestionSellerController {
	
	@Autowired
	QuestionSellerService questionSellerService;
	
	//답글 등록
	@RequestMapping(value = "/submitansewer", method = RequestMethod.POST, produces="application/text;charset=utf8")
	@ResponseBody
	public String submitAnsewer(QuestionVo questionVo) {
//		System.out.println(questionVo);
		Timestamp timestamp =
				questionSellerService.updateAnswer(questionVo);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 a HH시 mm분");
		String date = dateFormat.format(timestamp);
//		System.out.println(date);
		return date;
	}
}
