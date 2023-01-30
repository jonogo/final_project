package com.kh.project.kwon.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.project.kwon.service.CommentSellerService;
import com.kh.project.kwon.service.ManageService;
import com.kh.project.kwon.service.OrderSellService;
import com.kh.project.kwon.service.ProductService;
import com.kh.project.kwon.service.QuestionSellerService;
import com.kh.project.kwon.service.SellerService_kwon;
import com.kh.project.kwon.util.MyFileUploader;
import com.kh.project.kwon.util.SellerUtil;
import com.kh.project.vo.CommentVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.PagingDto;
import com.kh.project.vo.ProductVo;
import com.kh.project.vo.QuestionVo;
import com.kh.project.vo.SellerVo;

@Controller
@RequestMapping("/manage/*")
public class ManageController {
	
	@Autowired
	ManageService manageService;
	@Autowired
	ProductService productService;
	@Autowired
	OrderSellService orderSellService;
	@Autowired
	SellerService_kwon sellerService;
	@Autowired
	QuestionSellerService questionSellerService;
	@Autowired
	CommentSellerService commentSellerService;
	
	//메인 페이지 이동
	@RequestMapping(value = "/mainpage", method = RequestMethod.GET)
	public String getMain(HttpSession session, Model model) {
		String seller_id = SellerUtil.getIdOnSession(session);
		model.addAllAttributes(orderSellService.getMainMap(seller_id));
		model.addAttribute(
				"tableList", productService.getProductRevenueBySellerId(seller_id));
		model.addAttribute(
				"newQuestion", questionSellerService.getNewQuestionCount(seller_id));
		
		session.setAttribute(
				"pageInfo", "mainpage");
		return "/management/mainpage";
	}
	
	//상품 등록 페이지 이동
	@RequestMapping(value = "/registproduct", method = RequestMethod.GET)
	public String getProductInsert(HttpSession session) {
		session.setAttribute("pageInfo", "product_insert");
		return "/management/product_insert";
	}
	
	//상품 목록 페이지 이동
	@RequestMapping(value = "/listproduct", method = RequestMethod.GET)
	public String getListProduct(HttpSession session, Model model, PagingDto pagingDto) {
		String seller_id = SellerUtil.getIdOnSession(session);
		pagingDto.setPagingInfo(
				pagingDto.getPage(),
				pagingDto.getPerPage(), 
				productService.getProductCount(seller_id, pagingDto.getPro_count_status()));
		List<ProductVo> list = productService.getProductList(pagingDto, seller_id);
		model.addAttribute("list", list);
		model.addAttribute("pagingDto", pagingDto);
		session.setAttribute("pageInfo", "product_list");
		return "/management/product_list";
	}
	
	//주문 목록 페이지 이동
	@RequestMapping(value = "/listsellorder", method = RequestMethod.GET)
	public String getOrderListBySellerId(HttpSession session, Model model, PagingDto pagingDto) {
		String seller_id = SellerUtil.getIdOnSession(session);;
		pagingDto.setPagingInfo(
				pagingDto.getPage(),
				pagingDto.getPerPage(), 
				orderSellService.getOrderCount(seller_id, pagingDto.getOrder_step()));
		List<OrderVo> list = 
				orderSellService.getOrderListBySellerId(seller_id, pagingDto);
		model.addAttribute("list", list);
		model.addAttribute("pagingDto", pagingDto);
		session.setAttribute("pageInfo", "order_list");
		return "/management/order_list";
	}
	
	//문의 페이지 이동
	@RequestMapping(value = "/listquestion", method = RequestMethod.GET)
	public String getQuestListBySellerId(HttpSession session, Model model, PagingDto pagingDto) {
		String seller_id = SellerUtil.getIdOnSession(session);;
		
		pagingDto.setPagingInfo(
				pagingDto.getPage(),
				pagingDto.getPerPage(), 
				questionSellerService.getQuestionCount(seller_id));
		List<QuestionVo> list = 
				questionSellerService.getQuestionListById(seller_id, pagingDto);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("list", list);
		session.setAttribute("pageInfo", "quest_list");
		return "/management/question_list";
	}
	
	//개인정보 페이지 이동
	@RequestMapping(value = "/sellerpage", method = RequestMethod.GET)
	public String getSellerPage(HttpSession session, Model model) {
		String seller_id = SellerUtil.getIdOnSession(session);
		SellerVo sellerVo = 
			sellerService.getInfoById(seller_id);
		List<OrderVo> boardList = orderSellService.getOrderListforBoard(seller_id);
		model.addAttribute("sellerVo", sellerVo);
		model.addAttribute("boardList", boardList);
		session.setAttribute("pageInfo", "seller_info");
		return "/management/seller_info";
	}
	
	//댓글 목록 페이지 이동
	@RequestMapping(value = "/listcomment", method = RequestMethod.GET)
	public String getCommentListBySellerId(HttpSession session, Model model, PagingDto pagingDto) {
		String seller_id = SellerUtil.getIdOnSession(session);
		pagingDto.setPagingInfo(
				pagingDto.getPage(),
				pagingDto.getPerPage(), 
				commentSellerService.getCommentCount(seller_id));
		List<CommentVo> list = 
				commentSellerService.getCommentListBySellerId(seller_id, pagingDto);
		model.addAttribute("commentList", list);
		model.addAttribute("pagingDto", pagingDto);
		session.setAttribute("pageInfo", "comment_list");
		return "/management/comment_list";
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String sellerLogout(HttpSession session) {
		session.removeAttribute("sellerInfo");
		return "redirect:/seller/login_form";
	}
	
	//이미지 보이기
	@RequestMapping(value = "/displayImg", method = RequestMethod.GET)
	@ResponseBody
	public byte[] displayImage(String attach_file) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(MyFileUploader.UPLOAD_PATH + attach_file);
			byte[] bytes = IOUtils.toByteArray(fis);
			return bytes;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {fis.close();} catch (IOException e) {e.printStackTrace();}
		}
		return null;
	}
	
}
