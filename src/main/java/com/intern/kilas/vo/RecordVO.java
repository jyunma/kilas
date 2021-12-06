package com.intern.kilas.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecordVO {
	private String user_id;
	private String book_id;
	private Date record_borrowdate;
	private Date record_duedate;
	private Date record_returndate;
	private String record_borrowby;
	private String record_returnby;

	//대출 시 듀데이트 설정
	public RecordVO(String user_id, String book_id, Date record_borrowdate, String record_borrowby) {
		super();
		this.user_id = user_id;
		this.book_id = book_id;
		this.record_borrowdate = record_borrowdate;
		this.record_borrowby = record_borrowby;
	}
	
	
}
