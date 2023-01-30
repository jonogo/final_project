package com.kh.project.kim.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.project.kim.service.BoardService;
import com.kh.project.kim.service.CommentService;
import com.kh.project.kwon.util.MyFileUploader;
import com.kh.project.sjw.service.MemberService;
import com.kh.project.vo.BoardPagingDto;
import com.kh.project.vo.CommentVo;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String listArticle(Model model, BoardPagingDto boardPagingDto) {
		System.out.println(boardPagingDto);
		boardPagingDto.setPagingInfo(boardPagingDto.getPage(), boardPagingDto.getPerPage(),
				boardService.getCount(boardPagingDto));
		model.addAttribute("boardPagingDto", boardPagingDto);
		List<ProductVo> list = boardService.listArticle(boardPagingDto);
		model.addAttribute("list", list);

		return "/board/main";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String main(HttpSession session, RedirectAttributes rttr) {
		System.out.println(session.getAttribute("preOrderList"));
		rttr.addFlashAttribute("success", "success");
		return "redirect:/board/main";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String getArticle(int pro_no, BoardPagingDto boardPagingDto,
			Model model, HttpSession session) {
		ProductVo productVo = boardService.selectByPro_no(pro_no);
		model.addAttribute("productVo", productVo);
		
		List<ProductPicVo> propics = boardService.list(pro_no);
		model.addAttribute("propics", propics);

		List<CommentVo> commentlist = commentService.list(pro_no);
		model.addAttribute("commentlist", commentlist);

		List<ProductCountVo> productCountList = boardService.pro_size_count(pro_no);
		model.addAttribute("productCountList", productCountList);
		System.out.println(productVo);
		model.addAttribute("boardPagingDto", boardPagingDto);
		double avgStar = commentService.getStarRatingByPro_no(pro_no);
		model.addAttribute("avgStar", String.valueOf(avgStar));
		return "board/detail";
	}

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
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
