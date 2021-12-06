package com.intern.kilas.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookVO {
	private String book_id;
	private String book_title;
	private String book_author;
	private String book_publisher;
	private int book_year;
	private String book_callnum;
	private int book_borrow;
}
