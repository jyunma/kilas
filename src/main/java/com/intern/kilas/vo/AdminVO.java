package com.intern.kilas.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminVO {
	private String admin_id;
	private String admin_pass;
	private String admin_name;
	private int admin_role;
	
}
