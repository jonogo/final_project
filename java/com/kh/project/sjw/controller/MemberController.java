package com.kh.project.sjw.controller;

import java.io.FileInputStream;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.sjw.service.MemberService;
import com.kh.project.sjw.service.PageService;
import com.kh.project.sjw.util.MyFileUploader;
import com.kh.project.vo.EmailDto;
import com.kh.project.vo.MemberVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.QuestionVo;
import com.kh.project.vo.ShoppingBasketVo;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private JavaMailSenderImpl mailSender;
	@Autowired
	MemberService memberService;
	@Autowired
	PageService pageService;
	
	// 구매자 로그인 폼으로 이동
	@RequestMapping(value = "/login_form", method = RequestMethod.GET)
	public String login_form() {
		return "member/login_form";
	}
	
	// 판매자 로그인 폼으로 이동
	@RequestMapping(value = "/seller_login_form", method = RequestMethod.GET)
	public String seller_login_form() {
		return "member/seller_login_form";
	}
	// 구매자 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String userid, String userpw, HttpSession session, RedirectAttributes rttr, Model model) {
		String page="";
		MemberVo memberVo=memberService.login(userid, userpw);
		System.out.println("memberVo:"+memberVo);
		if(memberVo==null) {
			rttr.addFlashAttribute("login_result", "fail");
			page = "redirect:/member/login_form";
		}else {
			session.setAttribute("loginInfo", memberVo);
			System.out.println("로그인 성공:"+memberVo);
			rttr.addFlashAttribute("login_result", "success");
			page="redirect:/board/main";
		}
		return page;
	}
	// 회원가입 폼으로 이동
	@RequestMapping(value = "/register_form", method = RequestMethod.GET)
	public String register_form() {
		return "member/register_form";
	}
	
	// 회원가입 페이지에서 중복체크 버튼을 눌렀을 시 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.POST)
	public String checkId(String userid) {
		boolean result=memberService.checkId(userid);
		return String.valueOf(result);
	}
	
	// 회원가입
	@RequestMapping(value = "/registerMember", method = RequestMethod.POST)
	public String registerMember(MemberVo memberVo, MultipartFile file, RedirectAttributes rttr) {
		System.out.println("file:"+file);
		String originalFilename=file.getOriginalFilename();
		System.out.println("originalFilename:"+originalFilename);
		long size=file.getSize();
		System.out.println("size:"+size);
		String name=file.getName();
		System.out.println("name:"+name);
		try {
		String userpic=MyFileUploader.uploadFile(originalFilename, file.getBytes());
		memberVo.setUserpic(userpic);
		System.out.println("memberVo:"+memberVo);	
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(memberVo);
		memberService.registerMember(memberVo);
		return "redirect:/member/login_form";
	}
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginInfo");
		return "redirect:/board/main";
	}
	
	// 구매자 비밀번호 찾기 폼으로 이동
	@RequestMapping(value = "/seekPassword_form", method = RequestMethod.GET)
	public String seekPassword_form() {
		return "member/seekPassword_form";
	}
	
	// 구매자 비밀번호 찾기
	@RequestMapping(value = "/seekPassword_customer", method = RequestMethod.GET)
	public String seekPassword(EmailDto emailDto, RedirectAttributes rttr) {
		System.out.println(emailDto);
		if(emailDto.getUserid()==null||emailDto.getUserid().equals("")||emailDto.getTo()==null||emailDto.getTo().equals("")) {
			System.out.println("1실행");
			rttr.addFlashAttribute("message","notvalid");
			return "redirect:/member/seekPassword_form";
		}
		if(!memberService.isExistMember_customer(emailDto.getUserid(), emailDto.getTo())) {
			System.out.println("2실행");
			rttr.addFlashAttribute("message", "notfound");
			return "redirect:/member/seekPassword_form";
		}
		String uuid=UUID.randomUUID().toString();
		String newPass=uuid.substring(0,uuid.indexOf("-"));
		System.out.println("newPass:"+newPass);
		if(memberService.updatePassword_customer(emailDto.getUserid(), newPass)) {
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
		return "redirect:/member/login_form";
	}
	
	
	// 사진 업로드
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "application/text;charset=utf-8")
	@ResponseBody
	public String uploadAjax(MultipartFile file) throws Exception {
		System.out.println("file:"+file);
		String originalFilename=file.getOriginalFilename();
		System.out.println("orginalFilename:"+originalFilename);
		byte[] bytes=file.getBytes();
		String saveFilename=MyFileUploader.uploadFile(originalFilename, bytes);
		return saveFilename;
	}
	
	// 이미지 출력
	@ResponseBody
	@RequestMapping(value = "/displayImage", method = RequestMethod.GET)
	public byte[] displayImage(String userpic) {
		FileInputStream fis=null;
		System.out.println("userpic:"+userpic);
		try {
			fis=new FileInputStream(MyFileUploader.UPLOADPATH+userpic);
			// org.apache.commons.io.IOUtils
			byte[] bytes=IOUtils.toByteArray(fis);
			System.out.println("bytes:"+bytes);
			return bytes;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {fis.close();}catch(Exception e) {}
		}
		return null;
	}
}
