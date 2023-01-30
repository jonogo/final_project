package com.kh.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingBasketVo {
	private String userid;
	private String pro_name;
	private int pro_no;
	private String pro_pic;
	private int pro_price;
	private int pro_quantity;
	private int pro_size;
}
