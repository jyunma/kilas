package com.intern.kilas.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecordNowVO {
	private String book_id;
	private String book_title;
	private String book_callnum;
	private Date record_borrowdate;
	private Date record_duedate;
	private int book_borrow;
	private String record_borrowby;
}
