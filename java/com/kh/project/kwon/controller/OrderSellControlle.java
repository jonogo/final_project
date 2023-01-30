package com.kh.project.kwon.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.kwon.service.OrderSellService;
import com.kh.project.kwon.util.SellerUtil;

@Controller
@RequestMapping("/ordersell/*")
public class OrderSellControlle {
	
	@Autowired
	OrderSellService orderService;
	
	//상세보기로 이동
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String getMain(HttpSession session, Model model, int order_no) {
		String seller_id = SellerUtil.getIdOnSession(session);
		boolean isCorrectId = orderService.getIsCorrectId(seller_id, order_no);
		if(!isCorrectId) {
			return "redirect:/manage/listproduct";
		}
		if(session.getAttribute("pageInfo") != "order_list") {
			session.setAttribute("pageInfo", "order_list");
		}
		Map<String, Object> map = orderService.getOrderInfoByNo(order_no);
		model.addAttribute("map", map);
		return "/management/order_detail";
	}
	
	//주문상태 갱신
	@RequestMapping(value = "/modifystep", method = RequestMethod.POST)
	public String ModifyStep(int order_no, int order_step, RedirectAttributes rttr) {
		boolean result = orderService.ModifyStep(order_no, order_step);
		rttr.addFlashAttribute("stepResult", result);
		return "redirect:/ordersell/detail?order_no=" + order_no;
	}
	
	//운송장 번호 등록
	@Transactional
	@RequestMapping(value = "/setTracking", method = RequestMethod.POST)
	public String setTracking(int order_no, int order_step, String tracking_no,
			RedirectAttributes rttr) {
		boolean b1 = orderService.ModifyStep(order_no, order_step);
		boolean b2 = orderService.SetTracking(order_no, tracking_no);
		rttr.addFlashAttribute("stepResult", b1 && b2);
		return "redirect:/ordersell/detail?order_no=" + order_no;
	}
}
