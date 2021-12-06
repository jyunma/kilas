package com.intern.kilas.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.intern.kilas.vo.AdminVO;
import com.intern.kilas.vo.BookVO;
import com.intern.kilas.vo.RecordNowVO;
import com.intern.kilas.vo.RecordVO;
import com.intern.kilas.vo.UserVO;

@Repository
@Mapper
public interface MainDAO {
	public AdminVO selectAdmin(String admin_id);
	public BookVO selectBook(String book_id);
	public UserVO selectUser(String user_id);
	public List<RecordNowVO> selectRecordByUser(String user_id);
	public List<RecordVO> selectHistoryByUser(String user_id);
	public RecordVO selectRecordByBook(String book_id);
	public int insertRecord(RecordVO recordVO);
	public int updateBorrow(String book_id);
	public int updateRecord(RecordVO recordVO);
	public int updateReturn(String book_id);
	public int insertAdmin(AdminVO newAdmin);
	public int insertBook(BookVO newBook);
	public int insertUser(UserVO newUser);
	public int updateAdmin(AdminVO admin);
	public int updateBook(BookVO book);
	public int updateUser(UserVO user);
	public List<BookVO> searchBookById(String keyword); 
	public List<BookVO> searchBookBytitle(String keyword); 
	public List<BookVO> searchBookByAuthor(String keyword); 
	public List<BookVO> searchBookByPublisher(String keyword); 
	public List<UserVO> searchUserByName(String keyword); 
	public List<UserVO> searchUserByPhone(String keyword); 
	public List<UserVO> searchUserByAddress(String keyword); 
	
}
