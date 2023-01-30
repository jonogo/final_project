package com.kh.project.kwon.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.project.kwon.dao.CommentSellerDao;
import com.kh.project.kwon.dao.ProductDao;
import com.kh.project.kwon.util.MyFileUploader;
import com.kh.project.kwon.util.SellerUtil;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.PagingDto;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;
import com.kh.project.vo.SizeVo;

@Service
public class ProductService {
	
	@Autowired
	ProductDao productDao;
	@Autowired
	CommentSellerDao commentSellerDao;
	
	@Transactional
	public boolean registProduct(ProductVo productVo, SizeVo sizeVo) {
		int pro_no = productDao.getPro_no();
		productVo.setPro_no(pro_no);
		List<ProductCountVo> list =
				SellerUtil.sizeVoToList(sizeVo.toString());
		String[] files = productVo.getFiles();
		boolean b1 = productDao.registProduct(productVo);
		boolean b2 = true;
		for(String file : files) {
//			System.out.println(file);
			ProductPicVo productPicVo = null;
			if(file == files[0]) {
				productPicVo = new ProductPicVo(pro_no, file, 1);
			} else {
				productPicVo = new ProductPicVo(pro_no, file, 0);
			}
			boolean result = productDao.registProductPic(productPicVo);
			b2 = b2 && result;
		}
		boolean b3 = true;
		for(ProductCountVo productCountVo : list) {
			productCountVo.setPro_no(pro_no);
			boolean result = productDao.registProductCount(productCountVo);
			b3 = b3 && result;
		}
		if(b1 && b2 && b3) {
			System.out.println("success");
			return true;
		}
		return false; 
	}
	
	public List<ProductVo> getProductList(PagingDto pagingDto, String seller_id) {
		List<ProductVo> list = productDao.getProductList(pagingDto, seller_id);
		return list;
	}
	
	public boolean getIsCorrectId(String seller_id, int pro_no) {
		return productDao.getIsCorrectId(seller_id, pro_no);
	}
	
	@Transactional
	public Map<String, Object> getProductInfo(int pro_no) {
		System.out.println(pro_no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productVo", productDao.getProductInfo(pro_no));
		map.put("listCount", productDao.getProductCountInfo(pro_no));
		map.put("listPic", productDao.getProductPicInfo(pro_no));
		map.put("listComment", commentSellerDao.getCommentListByPro_no(pro_no));
		map.put("starRating", commentSellerDao.getStarRatingByPro_no(pro_no));
		return map;
	}
	
	public boolean modifySize(ProductCountVo productCountVo) {
		boolean sizeExist = productDao.getSizeExist(productCountVo);
		if(sizeExist) {
			return productDao.modifySize(productCountVo);
		}
		return productDao.insertSize(productCountVo);
	}
	
	public boolean modifyName(int pro_no, String pro_name) {
		return productDao.modifyName(pro_no, pro_name);
	}

	public boolean modifyPrice(int pro_no, String pro_price) {
		return productDao.modifyPrice(pro_no, pro_price);
	}
	
	public boolean insertImageData(ProductPicVo productPicVo) {
		return productDao.registProductPic(productPicVo);
	}
	
	public boolean modifyImageData(String old_pro_pic, String new_pro_pic) {
		return productDao.modifyImageData(old_pro_pic, new_pro_pic);
	}

	public boolean deleteImageData(String deleteImg) {
		File file = new File(MyFileUploader.UPLOAD_PATH + deleteImg);
		boolean b1 = file.delete();
		boolean b2 = productDao.deleteImageData(deleteImg);
		return b1 && b2;
	}

	public int getProductCount(String seller_id, int pro_count_status) {
		return productDao.getProductCount(seller_id, pro_count_status);
	}

	public List<OrderVo> getProductRevenueBySellerId(String seller_id) {
		return productDao.getProductRevenueBySellerId(seller_id);
	}

	
}
