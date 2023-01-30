package com.kh.project.kwon.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.SellerVo;

public class SellerUtil {
	public static String getIdOnSession(HttpSession session) {
		SellerVo sellerVo = 
				(SellerVo)session.getAttribute("sellerInfo");
		return sellerVo.getSeller_id(); 
	}
	
	public static List<ProductCountVo> sizeVoToList(String toStringCount) {
		List<ProductCountVo> list = new ArrayList<ProductCountVo>();
		System.out.println(toStringCount);
		toStringCount = toStringCount.substring(
				toStringCount.indexOf("(") + 1, toStringCount.indexOf(")"));
		String[] strs = toStringCount.split(", ");
		for(String s : strs) {
			if(s.endsWith("=0")) continue;
			String[] s2 = s.split("=");
			s2[0] = s2[0].substring(s2[0].indexOf("_") + 1);
			ProductCountVo productCountVo =
					new ProductCountVo(0,
					Integer.parseInt(s2[0]), Integer.parseInt(s2[1]));
			list.add(productCountVo);
		}
//		System.out.println(list);
		return list;
	}
}
