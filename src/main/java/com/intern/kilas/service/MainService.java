package com.intern.kilas.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.intern.kilas.dao.MainDAO;
import com.intern.kilas.vo.AdminVO;
import com.intern.kilas.vo.BookVO;
import com.intern.kilas.vo.RecordNowVO;
import com.intern.kilas.vo.RecordVO;
import com.intern.kilas.vo.UserVO;

@Service
public class MainService {
	@Autowired
	MainDAO mainDAO;
	
	public AdminVO selectAdmin(String admin_id) {
		return mainDAO.selectAdmin(admin_id);
	}
	public BookVO selectBook(String book_id) {
		return mainDAO.selectBook(book_id);
	}
	public UserVO selectUser(String user_id) {
		return mainDAO.selectUser(user_id);
	}
	public List<RecordNowVO> selectRecordByUser(String user_id) {
		return mainDAO.selectRecordByUser(user_id);
	}
	public List<RecordVO> selectHistoryByUser(String user_id) {
		return mainDAO.selectHistoryByUser(user_id);
	}
	public RecordVO selectRecordByBook(String book_id) {
		return mainDAO.selectRecordByBook(book_id);
	}
	public int borrowBook(String book_id, String user_id, String record_borrowby) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String ss=sdf.format(new java.util.Date());
		Date record_borrowdate = Date.valueOf(ss);
		
		java.util.Date dt = new java.util.Date();
		Calendar c = Calendar.getInstance();
		c.setTime(dt);
		c.add(Calendar.DATE, 14);
		dt = c.getTime();
		String ss2=sdf.format(dt);
		Date record_duedate = Date.valueOf(ss2);
		
		RecordVO record = new RecordVO(user_id, book_id, record_borrowdate, record_borrowby);
		record.setRecord_duedate(record_duedate);
		mainDAO.insertRecord(record);																//대출기록 생성
		return mainDAO.updateBorrow(book_id);														//책 상태 = 대출중
	}
	public int returnBook(String book_id, String user_id, String record_returnby) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String ss=sdf.format(new java.util.Date());
		Date record_returndate = Date.valueOf(ss);
		
		RecordVO record = mainDAO.selectRecordByBook(book_id);
		record.setRecord_returndate(record_returndate);
		record.setRecord_returnby(record_returnby);
		mainDAO.updateRecord(record);																//대출기록 반납일 수정
		return mainDAO.updateReturn(book_id);														//책 상태 = 비치중
	}
	
	public int insertAdmin(AdminVO newAdmin) {
		return mainDAO.insertAdmin(newAdmin);
	}
	public int insertBook(BookVO newBook) {
		return mainDAO.insertBook(newBook);
	}
	public int insertUser(UserVO newUser) {
		return mainDAO.insertUser(newUser);
	}
	
	public int updateAdmin(AdminVO admin) {
		return mainDAO.updateAdmin(admin);
	}
	public int updateBook(BookVO book) {
		return mainDAO.updateBook(book);
	}
	public int updateUser(UserVO user) {
		return mainDAO.updateUser(user);
	}
	
	public List<BookVO> searchBookById(String keyword){
		return mainDAO.searchBookById(keyword);
	}
	public List<BookVO> searchBookBytitle(String keyword){
		return mainDAO.searchBookBytitle(keyword);
	}
	public List<BookVO> searchBookByAuthor(String keyword){
		return mainDAO.searchBookByAuthor(keyword);
	}
	public List<BookVO> searchBookByPublisher(String keyword){
		return mainDAO.searchBookByPublisher(keyword);
	}
	public List<UserVO> searchUserByName(String keyword){
		return mainDAO.searchUserByName(keyword);
	}
	public List<UserVO> searchUserByPhone(String keyword){
		return mainDAO.searchUserByPhone(keyword);
	}
	public List<UserVO> searchUserByAddress(String keyword){
		return mainDAO.searchUserByAddress(keyword);
	}
}
