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
public class SellerVo {
	private String seller_id;
	private String seller_name;
	private String seller_person;
	private String seller_pw;
	private String seller_email;
	private String seller_phone;
	private String seller_addr;
	private String seller_pic;
	private Date regdate;
}
