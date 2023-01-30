package com.kh.project.vo;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVo {
	private int point;
	private String userid;
	private String userpw;
	private String username;
	private String email;
	private String userpic;
	private String user_addr1;
	private String user_addr2;
	private String user_addr3;
	private Timestamp regdate;
	private String preUserpic;
}
