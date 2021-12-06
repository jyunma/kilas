package com.intern.kilas.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
	private String user_id;
	private String user_name;
	private String user_phone;
	private String user_address;
}
