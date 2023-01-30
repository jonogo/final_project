package com.kh.project.sjw.controller;

import java.io.FileInputStream;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.sjw.service.SellerService_sjw;
import com.kh.project.vo.EmailDto;
import com.kh.project.vo.SellerVo;

@Controller
@RequestMapping("/seller/*")
public class SellerController_sjw {
	@Autowired
	private JavaMailSenderImpl mailSender;
	@Autowired
	SellerService_sjw sellerService;
	
	// 판매자 로그인 폼으로 이동
	@RequestMapping(value = "/login_form", method = RequestMethod.GET)
	public String login_form() {
		return "seller/login_form";
	}
	// 판매자 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String seller_id, String seller_pw, HttpSession session, RedirectAttributes rttr) {
		SellerVo sellerVo=sellerService.seller_login(seller_id, seller_pw);
		System.out.println("sellerVo:"+sellerVo);
		if(sellerVo==null) {
			rttr.addFlashAttribute("login_result", "fail");
			return "redirect:/seller/login_form";
		}
		SellerVo sellerInfoVo = sellerService.getSellerInfo(seller_id);
		sellerInfoVo.setSeller_id(seller_id);
		session.setAttribute("sellerInfo", sellerInfoVo);
		rttr.addFlashAttribute("login_result", "success");
		return "redirect:/manage/mainpage";//용대가 만든 사이트 입력
	}
	// 판매자 회원가입 폼으로 이동
	@RequestMapping(value = "/register_form", method = RequestMethod.GET)
	public String register_form() {
		return "seller/register_form";
	}
	
	// 회원가입 페이지에서 중복체크 버튼을 눌렀을 시 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/seller_checkId", method = RequestMethod.POST)
	public String seller_checkId(String seller_id) {
		boolean result=sellerService.seller_checkId(seller_id);
		return String.valueOf(result);
	}
	// 회원가입
	@RequestMapping(value = "/seller_registerMember", method = RequestMethod.POST)
	public String seller_registerMember(SellerVo sellerVo) {
		System.out.println(sellerVo);
		sellerService.seller_registerMember(sellerVo);
		return "redirect:/seller/login_form";
	}
	// 로그아웃
	@RequestMapping(value = "/seller_logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginInfo");
		return "redirect:/seller/login_form";
	}
	
	
	
	// 판매자 비밀번호 찾기 폼으로 이동
	@RequestMapping(value = "/seekPassword_form", method = RequestMethod.GET)
	public String seekPassword_form() {
		return "seller/seekPassword_form";
	}
	
	// 판매자 비밀번호 찾기
	@RequestMapping(value = "/seekPassword_seller", method = RequestMethod.GET)
	public String seekPassword(EmailDto emailDto, RedirectAttributes rttr) {
		System.out.println(emailDto);
		if(emailDto.getSeller_id()==null||emailDto.getSeller_id().equals("")||emailDto.getTo()==null||emailDto.getTo().equals("")) {
			System.out.println("1실행");
			rttr.addFlashAttribute("message","notvalid");
			return "redirect:/seller/seekPassword_form";
		}
		if(!sellerService.isExistMember(emailDto.getSeller_id(), emailDto.getTo())) {
			System.out.println("2실행");
			rttr.addFlashAttribute("message", "notfound");
			return "redirect:/seller/seekPassword_form";
		}
		String uuid=UUID.randomUUID().toString();
		String newPass=uuid.substring(0,uuid.indexOf("-"));
		System.out.println("newPass:"+newPass);
		if(sellerService.updatePassword_seller(emailDto.getSeller_id(), newPass)) {
			MimeMessagePreparator preparator= new MimeMessagePreparator() {
				@Override
				public void prepare(MimeMessage mimeMessage) throws Exception {
					MimeMessageHelper helper=new MimeMessageHelper(
							mimeMessage,
							false,
							"utf-8"
							);
					System.out.println("3실행");
					helper.setFrom(emailDto.getFrom());
					helper.setTo(emailDto.getTo());
					helper.setSubject("비밀번호 재설정 안내 메일");
					helper.setText("새로운 비밀번호:"+newPass);
				}
			};
			mailSender.send(preparator);
			System.out.println("메시지 잘보내짐");
		};
		return "redirect:/seller/login_form";
	}
	
	//이미지 내려보내기
	@ResponseBody
	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
	public byte[] displayImage(String seller_pic) {
		System.out.println("userpic:"+seller_pic);
		FileInputStream fis=null;
		try {
			fis=new FileInputStream(seller_pic);
			// org.apache.commons.io.IOUtils
			byte[] bytes=IOUtils.toByteArray(fis);
			return bytes;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {fis.close();}catch(Exception e) {}
		}
		return null;
	}
}
