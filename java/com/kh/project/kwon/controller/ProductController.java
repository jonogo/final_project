package com.kh.project.kwon.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.kwon.service.ProductService;
import com.kh.project.kwon.util.MyFileUploader;
import com.kh.project.kwon.util.SellerUtil;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;
import com.kh.project.vo.SizeVo;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	//상품 등록창
	@RequestMapping(value = "/registproduct" , method = RequestMethod.POST)
	public String insertProduct(HttpSession session, ProductVo productVo,
			SizeVo sizeVo, RedirectAttributes rttr) {
		String seller_id = SellerUtil.getIdOnSession(session);
		productVo.setSeller_id(seller_id);
		boolean result = productService.registProduct(productVo, sizeVo);
		rttr.addFlashAttribute("registResult", result);
		return "redirect:/manage/registproduct";
	}
	
	//상품 파일 업로드
	@RequestMapping(value = "/fileupload" , method = RequestMethod.POST,
			produces = "application/text;charset=utf-8")
	@ResponseBody
	public String fileUpload(HttpSession session, MultipartFile file) {
		try {
			String orgName = file.getOriginalFilename();
			byte[] bytes = file.getBytes();
			String saveFileName = 
					MyFileUploader.uploadFile(orgName, bytes);
			return saveFileName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	//등록창 이미지 삭제
	@RequestMapping(value = "/deleteImg", method = RequestMethod.POST)
	@ResponseBody
	public String deleteImage(String deleteImg) {
		File file = new File(MyFileUploader.UPLOAD_PATH + deleteImg);
		boolean result = file.delete();
		return String.valueOf(result);
	}
	
	//상품 상세 정보 이동
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String getDetailProduct(HttpSession session, Model model, int pro_no) {
		String seller_id = SellerUtil.getIdOnSession(session);
		boolean isCorrectId = productService.getIsCorrectId(seller_id, pro_no);
		if(!isCorrectId) {
			return "redirect:/manage/listproduct";
		}
		if(session.getAttribute("pageInfo") != "product_list") {
			session.setAttribute("pageInfo", "product_list");
		}
		Map<String, Object> map = productService.getProductInfo(pro_no);
		model.addAllAttributes(map);
		return "/management/product_detail";
	}
	// 사이즈 변경
	@RequestMapping(value = "/modifysize", method = RequestMethod.POST)
	@ResponseBody
	public String modifySize(ProductCountVo productCountVo) {
//		System.out.println(productCountVo);
		boolean result = productService.modifySize(productCountVo);
		return String.valueOf(result);
	}
	
	//상품 이름 교체
	@RequestMapping(value = "/modifyName", method = RequestMethod.POST)
	@ResponseBody
	public String modifyName(int pro_no, String pro_name) {
//		System.out.println(pro_name);
		boolean result = productService.modifyName(pro_no, pro_name);
		return String.valueOf(result);
	}
	
	//상품 가격 교체
	@RequestMapping(value = "/modifyPrice", method = RequestMethod.POST)
	@ResponseBody
	public String modifyPrice(int pro_no, String pro_price) {
//		System.out.println(pro_price);
		boolean result = productService.modifyPrice(pro_no, pro_price);
		return String.valueOf(result);
	}
	
	//수정창 이미지 추가
	@RequestMapping(value = "/insertImgData", method = RequestMethod.POST)
	@ResponseBody
	public String insertImageData(int pro_no, MultipartFile file) {
		try {
			String orgName = file.getOriginalFilename();
			byte[] bytes = file.getBytes();
			String saveFileName = 
				MyFileUploader.uploadFile(orgName, bytes);
			ProductPicVo productPicVo = 
					new ProductPicVo(pro_no, saveFileName, 0);
			boolean result = 
					productService.insertImageData(productPicVo);
			if(result) {				
				return saveFileName;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	//수정창 이미지 교체
	@RequestMapping(value = "/modifyImgData", method = RequestMethod.POST)
	@ResponseBody
	public String modifyImageData(String deleteImg, MultipartFile file) {
		String saveFileName = null;
		try {
			String orgName = file.getOriginalFilename();
			byte[] bytes = file.getBytes();
			saveFileName = 
				MyFileUploader.uploadFile(orgName, bytes);
			boolean b1 = productService.modifyImageData(deleteImg, saveFileName);
			File deletefile = new File(MyFileUploader.UPLOAD_PATH + deleteImg);
			boolean b2 = deletefile.delete();
			if(b1 && b2) {
				return saveFileName;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "fail";
	}
	
	//수정창 이미지 삭제
	@RequestMapping(value = "/deleteImgData", method = RequestMethod.POST)
	@ResponseBody
	public String deleteImageData(String deleteImg) {
		boolean result = productService.deleteImageData(deleteImg);
		return String.valueOf(result);
	}
}
