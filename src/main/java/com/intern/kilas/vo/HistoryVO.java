package com.intern.kilas.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HistoryVO {
	private String user_id;
	private String book_title;
	private String book_callnum;
	private String book_id;
	private Date record_borrowdate;
	private Date record_duedate;
	private Date record_returndate;
	private String record_borrowby;
	private String record_returnby;

}
