package com.kh.project.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ProductVo {
	private int pro_no;
	private int pro_price;
	private int pro_count;
	private int pro_revenue;
	private int cnt;
	private String pro_name;
	private String pro_status;
	private String pro_category;
	private String seller_id;
	private Date regdate;
	private String[] files;
	private String mainpic;
}
