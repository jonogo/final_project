package com.kh.project.kwon.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.kwon.service.SellerService_kwon;
import com.kh.project.kwon.util.MyFileUploader;
import com.kh.project.kwon.util.SellerUtil;
import com.kh.project.vo.SellerVo;

@Controller
@RequestMapping("/seller/*")
public class SellerController_kwon {
	
	@Autowired
	SellerService_kwon sellerService;
	
	//비동기 사진 교체
	@RequestMapping(value = "/updatesellerimg" , method = RequestMethod.POST)
	@ResponseBody
	public String updateSellerImg(HttpSession session, MultipartFile file, String deleteImg) {
		String seller_id = SellerUtil.getIdOnSession(session);
		try {
			String orgName = file.getOriginalFilename();
			byte[] bytes = file.getBytes();
			String saveFileName = 
				MyFileUploader.uploadFile(orgName, bytes);
			boolean b1 = sellerService.updateSellerImg(saveFileName, seller_id);
			if(b1) {
				SellerVo sellerVo =  (SellerVo)session.getAttribute("sellerInfo");
				sellerVo.setSeller_pic(saveFileName);
				session.setAttribute("sellerInfo", sellerVo);
				if(deleteImg != null) {
					File deletefile = new File(MyFileUploader.UPLOAD_PATH + deleteImg);
					deletefile.delete();				
				}
				return saveFileName;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	//개인정보 폼 이동
	@RequestMapping(value = "/profilechangeform" , method = RequestMethod.GET)
	public String profileChangeForm(HttpSession session, Model model) {
		String seller_id = SellerUtil.getIdOnSession(session);
		SellerVo sellerVo = 
			sellerService.getChangeInfoById(seller_id);
		model.addAttribute(sellerVo);
		return "/management/seller_profile_change";
	}
	
	//개인정보 비밀번호 확인
	@RequestMapping(value = "/nowPwCheck" , method = RequestMethod.POST)
	@ResponseBody
	public String nowPwCheck(String nowPw, HttpSession session) {
//		System.out.println(nowPw);
		String seller_id = SellerUtil.getIdOnSession(session);
		boolean result = sellerService.nowPwCheck(seller_id, nowPw);
		return String.valueOf(result);
	}
	
	//개인정보 갱신
	@RequestMapping(value = "/updatesellerinfo" , method = RequestMethod.POST)
	public String updateSellerInfo(HttpSession session, SellerVo sellerVo,
			RedirectAttributes rttr) {
		System.out.println(sellerVo);
		String seller_id = SellerUtil.getIdOnSession(session);
		sellerVo.setSeller_id(seller_id);
		boolean result = sellerService.updateSellerInfo(sellerVo);
		rttr.addFlashAttribute("infoResult", result);
		return "redirect:/manage/sellerpage";
	}
	
	
}
