package com.kh.project.sjw.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.project.sjw.service.PageService;
import com.kh.project.sjw.util.MyFileUploader;
import com.kh.project.vo.MemberVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.QuestionVo;
import com.kh.project.vo.ShoppingBasketVo;

@Controller
@RequestMapping("/page/*")
public class PageController {
	@Autowired
	PageService pageService;
	
	//마이 페이지로 이동
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage() {
		return "page/myPage";
	}
	
	//배송조회 이동
	@RequestMapping(value = "/myPage_delivery", method = RequestMethod.GET)
	public String delivery_page(String userid, Model model) {
		List<OrderVo> orderList= pageService.orderList(userid);
		model.addAttribute("orderList", orderList);
		return "page/myPage_delivery";
	}
	
	//장바구니 이동
	@RequestMapping(value = "/myPage_shopping_basket", method = RequestMethod.GET)
	public String shopping_basket_page() {
		return "page/myPage_shopping_basket";
	}
	
	//정보 수정하기
	@RequestMapping(value = "/modifyMember", method = RequestMethod.POST)
	public String modifyMember(MemberVo memberVo, MultipartFile file, HttpSession session){
		String originalFilename=file.getOriginalFilename();
		long size=file.getSize();
		String name=file.getName();
		String preUserpic=memberVo.getPreUserpic();
		if(originalFilename.trim().equals("")) {
			memberVo.setUserpic(preUserpic);
		}else {
			try {
				File file1 = new File(preUserpic);
				if(file1.exists()) { // 파일이 존재하면
					file1.delete(); // 파일 삭제	
				}
				String userpic=MyFileUploader.uploadFile(originalFilename, file.getBytes());
				memberVo.setUserpic(userpic);
				System.out.println("memberVo:"+memberVo);	
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		pageService.modifyMember(memberVo);
		session.setAttribute("loginInfo", memberVo);
		return "redirect:/page/myPage";
	}
	
	//장바구니 아이템 삭제
	@RequestMapping(value = "/delete_shopping_basket", method = RequestMethod.GET)
	public String delete_shopping_basket(String userid, String pro_no, HttpSession session) {
		pageService.delete_shopping_basket_list(userid, pro_no);
		List<ShoppingBasketVo> list=pageService.shopping_basket_list(userid);
		session.setAttribute("shopping_basket", list);
		return "redirect:/page/myPage_shopping_basket";
	}
	
	//장바구니 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "/shopping_basket_list", method = RequestMethod.GET)
	public List<ShoppingBasketVo> shopping_basket_list(String userid, Model model) {
		List<ShoppingBasketVo>shopping_basket=pageService.shopping_basket_list(userid);
		model.addAttribute("shopping_basket", shopping_basket);
		return shopping_basket;
	}
	
	//나의 문의로 이동
	@RequestMapping(value = "/service_center", method = RequestMethod.GET)
	public String service_center(String userid, Model model) {
		List<QuestionVo>serviceList=pageService.serviceList(userid);
		model.addAttribute("serviceList", serviceList);
		System.out.println(serviceList);
		return "page/myPage_service_center";
	}
	

	// 주문 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "/orderList", method = RequestMethod.POST)
	public String order(
			@RequestParam(value="pro_nos[]") int[] pro_nos,
			@RequestParam(value="order_counts[]") int[] order_counts,
			@RequestParam(value="order_sizes[]") int[] order_sizes,
			String order_addr,String userid, Model model) {
		List<OrderVo> orderList = new ArrayList<OrderVo>();
		for(int i=0;i<pro_nos.length;i++) {
			OrderVo orderVo=new OrderVo();
			orderVo.setPro_no(pro_nos[i]);
			orderVo.setOrder_count(order_counts[i]);
			orderVo.setOrder_size(order_sizes[i]);
			orderVo.setUserid(userid);
			orderVo.setOrder_addr(order_addr);
			int orderSeq=pageService.orderSeq();
			orderVo.setOrder_no(orderSeq);
			boolean result=pageService.order(orderVo);
			orderList.add(orderVo);
			if(result) {
				System.out.println("성공");
			}
			model.addAttribute("orderList",orderList);
		}
		return "success";
	}
	
	//주문하기 직전 주문할 물건 가져오기
	@ResponseBody
	@RequestMapping(value = "/preOrderList", method = RequestMethod.POST)
	public String order(
			@RequestParam(value="pro_nos[]") String[] pro_no,
			@RequestParam(value="pro_sizes[]") String[] pro_size,
			String userid, Model model,
			HttpSession session) {
		System.out.println(userid);
		List<OrderVo> preOrderList=new ArrayList<>();
		for(int i=0;i<pro_no.length;i++) {
			OrderVo orderVo=pageService.preOrder(userid, pro_no[i], pro_size[i]);
			preOrderList.add(orderVo);
		}
		session.setAttribute("preOrderList", preOrderList);
		return "success";
	}
	
	// 주문하는 사이트로 이동
	@RequestMapping(value = "/myPageOrder", method = RequestMethod.GET)
	public String myPageOrder(HttpSession session) {
		if(session.getAttribute("preOrderList")==null) {
			return "page/myPage_shopping_basket";
		}
		return "page/myPageOrder";
	}
	
}
