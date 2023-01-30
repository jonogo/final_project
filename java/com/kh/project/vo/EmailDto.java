package com.kh.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmailDto {
	private String userid;
	private String seller_id;
	private String from="mosat159@gmail.com";
	private String to;
	private String subject;
	private String content;
}
