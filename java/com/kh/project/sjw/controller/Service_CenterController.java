package com.kh.project.sjw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.project.sjw.service.PageService;
import com.kh.project.sjw.service.Service_CenterService;
import com.kh.project.vo.QuestionVo;

@Controller
@RequestMapping("/service_center/*")
public class Service_CenterController{

	@Autowired
	Service_CenterService service_centerService;
	
	@Autowired
	PageService pageService;

	// 문의 작성으로 이동
	@RequestMapping(value = "/service_question", method = RequestMethod.GET)
	public String service_question(int pro_no, Model model) {
		System.out.println(pro_no);
		model.addAttribute("pro_no", pro_no);
		return "service_center/service_question";
	}
	
	// 문의 내용 보내기
	@RequestMapping(value = "/send_question", method = RequestMethod.POST)
	public String send_question(QuestionVo questionVo, Model model, String userid, String pro_no)  {
		System.out.println(questionVo);
		System.out.println("pro_no"+pro_no);
		service_centerService.send_question(questionVo);
		List<QuestionVo>serviceList=pageService.serviceList(userid);
		System.out.println(serviceList);
		model.addAttribute("serviceList", serviceList);
		model.addAttribute("userid", userid);
		return "redirect:/page/service_center";
	}
}
