package com.intern.kilas.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.intern.kilas.service.MainService;
import com.intern.kilas.vo.AdminVO;
import com.intern.kilas.vo.BookVO;
import com.intern.kilas.vo.HistoryVO;
import com.intern.kilas.vo.RecordNowVO;
import com.intern.kilas.vo.RecordVO;
import com.intern.kilas.vo.UserVO;

@Controller
public class MainController {
	@Autowired
	MainService mainService;
	
	//login페이지
	@RequestMapping(value = "/main/login", method = RequestMethod.POST)
	public String loginPagePost(String admin_id, String admin_pass, HttpSession session, Model model) {
		AdminVO admin = (AdminVO)mainService.selectAdmin(admin_id);
		if (admin != null) {													//	id 있음
			if(admin.getAdmin_pass().equals(admin_pass)) {						//	비밀번호 일치
				session.setAttribute("admin", admin);
			}else {																//	비밀번호 불일치
				model.addAttribute("message", "아이디 혹은 비밀번호를 확인해주세요.");
				model.addAttribute("where", 0);
				return "messagePage";
			}
		}else {																	//	id 없음
			model.addAttribute("message", "아이디 혹은 비밀번호를 확인해주세요.");
			model.addAttribute("where", 0);
			return "messagePage";
		}
		
		return "redirect:/main";
	}
	//logout페이지
	@RequestMapping(value = "/main/logout")
	public String logoutPage(HttpSession session) {
		session.setAttribute("admin", null);
		return "redirect:/main";
	}
	
	//메인 페이지
	@RequestMapping("/main")
	public String mainPage(Model model, @RequestParam(required = false)String user_id, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {												// 	로그인 체크
			return "login";
		}else {
			model.addAttribute("admin", admin);
			if(user_id != null || user_id != "") {										// 유저 정보 있음
				UserVO user = mainService.selectUser(user_id);
				model.addAttribute("user", user);
				model.addAttribute("recordList", mainService.selectRecordByUser(user_id));
				List<HistoryVO> historyList= new ArrayList<>();
				List<RecordVO> recordList = mainService.selectHistoryByUser(user_id);
				for (RecordVO recordVO : recordList) {
					HistoryVO history = new HistoryVO(recordVO.getUser_id(), mainService.selectBook(recordVO.getBook_id()).getBook_title(), mainService.selectBook(recordVO.getBook_id()).getBook_callnum(), recordVO.getBook_id(), recordVO.getRecord_borrowdate(), recordVO.getRecord_duedate(), recordVO.getRecord_returndate(), recordVO.getRecord_borrowby(), recordVO.getRecord_returnby());
					historyList.add(history);
				}
				model.addAttribute("historyList", historyList);
			}
			return "main";
		}
	}
	//처리 버튼 클릭
	@RequestMapping(value = "/main/execute", method = RequestMethod.POST)
	public String executePage(Model model, String book_id, @RequestParam(required = false) String user_id, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		BookVO book = mainService.selectBook(book_id);
		model.addAttribute("book", book);
		if (book == null) {
			model.addAttribute("message", "등록번호를 다시 확인해 주세요.");
			model.addAttribute("messageType", 0);
			if(user_id != null) {									
				UserVO user = mainService.selectUser(user_id);
				model.addAttribute("user", user);
				model.addAttribute("recordList", mainService.selectRecordByUser(user_id));
				model.addAttribute("history", mainService.selectHistoryByUser(user_id));
			}
		}else {
			if(user_id != null) {										// 유저 정보 있음
				UserVO user = mainService.selectUser(user_id);
				model.addAttribute("user", user);
				model.addAttribute("recordList", mainService.selectRecordByUser(user_id));
				List<HistoryVO> historyList= new ArrayList<>();
				List<RecordVO> recordList = mainService.selectHistoryByUser(user_id);
				for (RecordVO recordVO : recordList) {
					HistoryVO history = new HistoryVO(recordVO.getUser_id(), mainService.selectBook(recordVO.getBook_id()).getBook_title(), mainService.selectBook(recordVO.getBook_id()).getBook_callnum(), recordVO.getBook_id(), recordVO.getRecord_borrowdate(), recordVO.getRecord_duedate(), recordVO.getRecord_returndate(), recordVO.getRecord_borrowby(), recordVO.getRecord_returnby());
					historyList.add(history);
				}
				model.addAttribute("historyList", historyList);
				if (book.getBook_borrow()==1) {											//	대출중
					List<RecordNowVO> userRecordList = mainService.selectRecordByUser(user_id);
					boolean hasRecord = false;
					for (RecordNowVO record : userRecordList) {									//	대출 목록에 있는 지 확인
						if(record.getBook_id().equalsIgnoreCase(book_id)) {
							hasRecord=true;
							break;
						}
					}
					if (hasRecord) {																//	대출목록에 있음
						model.addAttribute("message",book.getBook_title()+" 도서를 반납하시겠습니까?");
						model.addAttribute("messageType",1);
						model.addAttribute("msgFunction", 1);
					}else {																			//	대출목록에 없음
						model.addAttribute("message", "해당 도서는 다른 이용자가 대출중인 도서입니다.");
						model.addAttribute("messageType",0);
					}
				}else if (book.getBook_borrow()==0) {									//	비치중
					model.addAttribute("message",book.getBook_title()+" 도서를 대출하시겠습니까?");
					model.addAttribute("messageType",1);
					model.addAttribute("msgFunction", 0);
				}
				
			}else {														// 유저 정보 없음
				if (book.getBook_borrow()==1) {											//대출중
					RecordVO record = mainService.selectRecordByBook(book_id);
					UserVO user = mainService.selectUser(record.getUser_id());
					return "redirect:/main?user_id="+user.getUser_id();
				}else {																	//비치중
					model.addAttribute("message", "이용자를 선택해 주세요.");
					model.addAttribute("messageType",0);
				}
			}
		}
		return "execute";
	}
	
	//대출기능
	@RequestMapping(value = "/main/borrow", method = RequestMethod.POST)
	public String borrowPage(String book_id, String user_id, HttpSession session) {
		AdminVO record_borrowby = (AdminVO) session.getAttribute("admin");
		mainService.borrowBook(book_id,user_id, record_borrowby.getAdmin_id());
		return "redirect:/main?user_id="+user_id;
	}
	
	//반납기능
	@RequestMapping(value = "/main/return", method = RequestMethod.POST)
	public String returnPage(String book_id, String user_id, HttpSession session) {
		AdminVO record_returnby = (AdminVO) session.getAttribute("admin");
		mainService.returnBook(book_id,user_id, record_returnby.getAdmin_id());
		return "redirect:/main?user_id="+user_id;
	}
	
	//관리자 등록
	@RequestMapping(value = "/main/addAdmin", method = RequestMethod.GET)
	public String addAdmin(HttpSession session, Model model) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin.getAdmin_role()!=1) {										// 상급관리자가 아니다
			model.addAttribute("message", "권한이 없습니다.");
			model.addAttribute("where", 0);
			return "messagePage";
		}else {
			return "addAdmin";
		}
	}
	@RequestMapping(value = "/main/addAdmin", method = RequestMethod.POST)
	public String addAdminPost(Model model, String admin_name, String admin_pass, String admin_id, String admin_role) {
		try {
			int intAdmin_role = Integer.parseInt(admin_role);
			AdminVO newAdmin = new AdminVO(admin_id, admin_pass, admin_name, intAdmin_role);
			int add = mainService.insertAdmin(newAdmin);
			if(add == 1) {
				model.addAttribute("message", "관리자 등록이 완료되었습니다.");
				model.addAttribute("where", 0);
			}
		} catch (Exception e) {
			model.addAttribute("message", "관리자 등록에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		return "messagePage";
	}
	
	//도서 등록
	@RequestMapping(value = "/main/addBook", method = RequestMethod.GET)
	public String addBook(HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		return "addBook";
	}
	@RequestMapping(value = "/main/addBook", method = RequestMethod.POST)
	public String addBookPost(Model model, String book_id, String book_title, String book_author, String book_publisher, String book_year, String book_callnum) {
		try {
			int year = Integer.parseInt(book_year);
			BookVO newBook = new BookVO(book_id, book_title, book_author, book_publisher, year, book_callnum, 0);
			int add = mainService.insertBook(newBook);
			if(add == 1) {
				model.addAttribute("message", "도서 등록이 완료되었습니다.");
				model.addAttribute("where", 1);
				model.addAttribute("book_id", newBook.getBook_id());
			}
		}
		catch (Exception e) {
			model.addAttribute("message", "도서 등록에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		return "messagePage";
	}
	
	//이용자 등록
	@RequestMapping(value = "/main/addUser", method = RequestMethod.GET)
	public String addUser(HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		return "addUser";
	}
	@RequestMapping(value = "/main/addUser", method = RequestMethod.POST)
	public String addUserPost(UserVO newUser, Model model) {
		try {
			int add = mainService.insertUser(newUser);
		
			if(add == 1) {
				model.addAttribute("message", "이용자 등록이 완료되었습니다.");
				model.addAttribute("where", 2);
				model.addAttribute("user_id", newUser.getUser_id());
			}
		}
		catch (Exception e) {
			model.addAttribute("message", "이용자 등록에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		
		return "messagePage";
	}
	
	
	
	
	//관리자 수정
	@RequestMapping(value = "/main/updateAdmin", method = RequestMethod.GET)
	public String updateAdminGet(Model model, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		model.addAttribute("admin", admin);
		return "updateAdmin";
	}
	@RequestMapping(value = "/main/updateAdmin", method = RequestMethod.POST)
	public String updateAdminPost(Model model, HttpSession session, String admin_name, String admin_pass, String admin_id, String admin_role) {
		try {
			int role = Integer.parseInt(admin_role);
			AdminVO admin = new AdminVO(admin_id, admin_pass, admin_name, role);
			int update = mainService.updateAdmin(admin);
			if(update == 1) {
				session.setAttribute("admin", admin);
				model.addAttribute("message", "관리자 수정이 완료되었습니다.");
				model.addAttribute("where", 0);
			}
		} catch (Exception e) {
			model.addAttribute("message", "관리자 수정에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		return "messagePage";
	}
		
	//도서 수정
	@RequestMapping(value = "/main/updateBook", method = RequestMethod.GET)
	public String updateBookGet(Model model, @RequestParam String book_id, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		BookVO book = mainService.selectBook(book_id);
		model.addAttribute("book", book);
		return "updateBook";
	}
	@RequestMapping(value = "/main/updateBook", method = RequestMethod.POST)
	public String updateBookPost(Model model, String book_id, String book_title, String book_author, String book_publisher, String book_year, String book_callnum) {
		try {
			int year = Integer.parseInt(book_year);
			BookVO oldBook = mainService.selectBook(book_id);
			BookVO newBook = oldBook;
			newBook.setBook_author(book_author);
			newBook.setBook_callnum(book_callnum);
			newBook.setBook_publisher(book_publisher);
			newBook.setBook_title(book_title);
			newBook.setBook_year(year);
			int update = mainService.updateBook(newBook);
			if(update == 1) {
				model.addAttribute("message", "도서 수정이 완료되었습니다.");
				model.addAttribute("where", 1);
				model.addAttribute("book_id", newBook.getBook_id());
			}
		}
		catch (Exception e) {
			model.addAttribute("message", "도서 수정에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		return "messagePage";
	}
	
	//이용자 수정
	@RequestMapping(value = "/main/updateUser", method = RequestMethod.GET)
	public String updateUserGet(Model model, @RequestParam String user_id, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		UserVO user = mainService.selectUser(user_id);
		model.addAttribute("user", user);
		return "updateUser";
	}
	@RequestMapping(value = "/main/updateUser", method = RequestMethod.POST)
	public String updateUserPost(Model model, UserVO user) {
		try {
			int update = mainService.updateUser(user);
		
			if(update == 1) {
				model.addAttribute("message", "이용자 수정이 완료되었습니다.");
				model.addAttribute("where", 2);
				model.addAttribute("user_id", user.getUser_id());
			}
		}
		catch (Exception e) {
			model.addAttribute("message", "이용자 수정에 실패했습니다.");
			model.addAttribute("where", 0);
		}
		
		return "messagePage";
	}
	
	// 도서 검색
	@RequestMapping(value="/main/searchBook", method = RequestMethod.GET)
	public String searchBookPage(Model model, @RequestParam(required = false) String field, @RequestParam(required = false) String keyword, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		if (keyword != null) {
			List<BookVO> rstList;
			model.addAttribute("keyword", keyword);
			keyword = "%"+keyword+"%";
			switch (field) {
				case "청구기호":
					rstList = mainService.searchBookById(keyword);
					model.addAttribute("rstList", rstList);
					break;
				case "도서명":
					rstList = mainService.searchBookBytitle(keyword);
					model.addAttribute("rstList", rstList);
					break;
				case "저자":
					rstList = mainService.searchBookByAuthor(keyword);
					model.addAttribute("rstList", rstList);
					break;
				case "출판사":
					rstList = mainService.searchBookByPublisher(keyword);
					model.addAttribute("rstList", rstList);
					break;
			}
			
		}
		return "searchBook";
	}
	
	// 이용자 검색
	@RequestMapping(value="/main/searchUser", method = RequestMethod.GET)
	public String searchUserPage(Model model, @RequestParam(required = false) String field, @RequestParam(required = false) String keyword, HttpSession session) {
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		if(admin == null) {
			return "redirect:/main";
		}
		if (keyword != null) {
			List<UserVO> rstList;
			model.addAttribute("keyword", keyword);
			keyword = "%"+keyword+"%";
			switch (field) {
			case "이름":
				rstList = mainService.searchUserByName(keyword);
				model.addAttribute("rstList", rstList);
				break;
			case "연락처":
				rstList = mainService.searchUserByPhone(keyword);
				model.addAttribute("rstList", rstList);
				break;
			case "주소":
				rstList = mainService.searchUserByAddress(keyword);
				model.addAttribute("rstList", rstList);
				break;
			}
		}
		return "searchUser";
	}

	
}




 