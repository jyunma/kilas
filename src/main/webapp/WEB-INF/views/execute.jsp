<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>처리[${sessionScope.admin.admin_name}]</title>
 
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Bootstrap core CSS
  <link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  -->

  <!-- Custom fonts for this template
  <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
   -->
  <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

  <!-- Custom styles for this template 
  <link href="/css/clean-blog.min.css" rel="stylesheet">
  -->
  
     <!-- 템플릿 외 추가 글꼴 -->
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<style>
	  @font-face {
	    font-family: 'BBTreeGL';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_nine_@1.1/BBTreeGL.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	  }
	  
	  @font-face {
	    font-family: 'ChosunSg';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ChosunSg.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	  }
     
      @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

</style>  

	<style type="text/css">
		span.info {
			color: grey;
			font-size: 22px;
		}
		button.btn-outline-success{
			padding: 10px 15px;
		}
		.btn-outline-success {
			color: #2e3c82;
			border-color: #2e3c82;
		}
		
		.btn-outline-success:hover {
			color: #fff;
			background-color: #162051;
			border-color: #162051;
		}
		.btn-outline-success:focus, .btn-outline-success.focus {
			box-shadow: 0 0 0 0.2rem #2e3c82;
		}
		.btn-outline-success:not(:disabled):not(.disabled):active, .btn-outline-success:not(:disabled):not(.disabled).active,
		.show > .btn-outline-success.dropdown-toggle {
			color: #fff;
			background-color: #2e3c82;
			border-color: #2e3c82;
		}
		
		.btn-outline-success:not(:disabled):not(.disabled):active:focus, .btn-outline-success:not(:disabled):not(.disabled).active:focus,
		.show > .btn-outline-success.dropdown-toggle:focus {
			box-shadow: 0 0 0 0.2rem #2e3c82;
		}
	</style>

	<style type="text/css">
		body {
			text-align: center;
			color: #FFF;
			width: 1920px;
			height: 1080px;
		}
		header{
		margin: 0px;
		margin-bottom: 20px;
		height : 88px;
		}
		.wrapper{
			width:100%;
			text-align: left;
			height: 900px;
			margin: 0 auto;
			color: black;
		}
		section{
			border:1px solid #999;
			margin : 20px;
			padding: 20px;
			font-family: 'Noto Sans KR', sans-serif;
			font-size: 100%;
		}
		.section1, .section2, .buttonSection{
			float: left;
			height: 30%;
			margin-top: 0px;
		}
		.section1{
			margin-left: 3%;
			width: 30%;
		}
		.section2{
			width: 50%;
		}
		.buttonSection{
			border: none;
			padding: 0px;
			margin-left: 0px;
		}
		.section3{
			width: 90%;
			position: relative;
			min-height: 30%;
			clear: both;
			margin-left: 3%;
		}
	</style>

<script type="text/javascript">
	$(document).keyup(function(event){
		if(event.keyCode == 27 || event.which == 27){
			location.href="/main";
		}
	
	})
</script>
<script>
	
</script>

</head>
<body>
	<div class="wrapper">
		<header>
			<jsp:include page="header.jsp"></jsp:include>
		</header>
		<!-- 번호 입력 섹션 -->
		<hr color=lightgray width="95%" style="clear:both">
		<section class="section1">
			<br>
			<form role="form" action="/main" method="get" class="post-subtitle" style="font-family: 'ChosunSg'; word-break: keep-all; font-weight: bold;">
				<div class="form-group">
					<label for="user_id">이용자 번호</label>
					<input type="text" class="form-control" id="user_id" placeholder="이용자 번호를 입력해주세요" name="user_id">
				</div>
			</form>
			<!-- 이용자 정보가 있을 경우 -->
			<c:if test="${!empty user}">
				<form name="executeForm" role="form" action="/main/execute" method="post" class="post-subtitle" style="font-family: 'ChosunSg'; word-break: keep-all; font-weight: bold;">
					<div class="form-group">
						<label for="book_id">도서 등록 번호</label>
						<input style="display: none;" name="user_id" type="text" class="form-control" value="${user.user_id}">
						<input autofocus="autofocus" type="text" class="form-control" id="book_id" placeholder="도서 등록 번호를 입력해주세요" name="book_id" onkeyup="executeSubmit()">
					</div>
				</form>
			</c:if>
			<c:if test="${empty user}">
			<!-- 이용자 정보가 없을 경우 -->
				<form role="form" action="/main/execute" method="post" class="post-subtitle" style="font-family: 'ChosunSg'; word-break: keep-all; font-weight: bold;">
					<div class="form-group">
						<label for="book_id">도서 등록 번호</label>
						<input autofocus="autofocus" type="text" class="form-control" id="book_id" placeholder="도서 등록 번호를 입력해주세요" name="book_id">
					</div>
				</form>
			</c:if>
		</section>
		
		<!-- 이용자 정보 섹션 -->
		<section class="section2">
			 <h5 style="font-family: 'ChosunSg'; word-break: keep-all;">
				이용자 번호 &nbsp;<span class="info">${user.user_id}</span><br><br>
				이름 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="info">${user.user_name}</span><br><br>
				연락처 &nbsp; &nbsp; &nbsp; &nbsp; <span class="info">${user.user_phone}</span><br><br>
				주소 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span class="info">${user.user_address}</span><br><br>
			</h5>
		
		</section>
		<section class="buttonSection">
			<c:if test="${user ne null}">
				<button type="button" class="btn btn-outline-success btn-sm" onclick="location.href=`/main/updateUser?user_id=${user.user_id}`">이용자 정보 수정</button>
			</c:if>
			<c:if test="${user eq null}">
				<button type="button" class="btn btn-outline-success btn-sm">이용자 정보 수정</button>
			</c:if>
			<br>
			<br>
			<c:if test="${user ne null}">
				<button id="historyBtn" type="button" class="btn btn-outline-success btn-sm">이용자 대출 이력</button>
			</c:if>
			<c:if test="${user eq null}">
				<button id="historyBtn" type="button" class="btn btn-outline-success btn-sm">이용자 대출 이력</button>
			</c:if>
		</section>

		<hr color=lightgray width="95%" style="clear:both">
		
		<!-- 대출목록 세션 -->
		<section class="section3">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th></th>
							<th>등록번호</th>
							<th>도서명</th>
							<th>청구기호</th>
							<th>대출일</th>
							<th>반납예정일</th>
							<th>대출상태</th>
							<th>대출처리자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rcd" items="${recordList}" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${rcd.book_id}</td>
								<td>${rcd.book_title}</td>
								<td>${rcd.book_callnum}</td>
								<td>${rcd.record_borrowdate}</td>
								<td>${rcd.record_duedate}</td>
								<td><c:if test="${rcd.book_borrow eq 1}">
								대출중</c:if>
								<c:if test="${rcd.book_borrow eq 0}">
								비치중
								</c:if>
								</td>
								<td>${rcd.record_borrowby}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>		
			</div>
		</section>
	</div>
	
	
	<!-- modal -->
	<!-- 반납 -->
	<button id="returnBtn" class="btn" style="display: none;">반납모달</button>
	<div class="modal fade" id="returnModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="color: black;">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="returnModalLabel">처리</h5>
				</div>
				<div class="modal-body">${message}</div>
				<div class="modal-footer">
					<form action="/main/return" method="post">
						<input style="display: none;" name="user_id" value="${user.user_id}">
						<input style="display: none;" name="book_id" value="${book.book_id}">
						<button type="submit" class="btn btn-danger">반납</button>
					</form>
					<button class="btn" type="button" onclick="location.href='/../main?user_id=${user.user_id}'">아니요</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 대출 -->
	<button id="borrowBtn" class="btn" style="display: none;">대출모달</button>
	<div class="modal fade" id="borrowModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="color: black;">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="borrowModalLabel">처리</h5>
				</div>
				<div class="modal-body">${message}</div>
				<div class="modal-footer">
					<form action="/main/borrow" method="post">
						<input style="display: none;" name="user_id" value="${user.user_id}">
						<input style="display: none;" name="book_id" value="${book.book_id}">
						<button type="submit" class="btn btn-success">대출</button>
					</form>
					<button class="btn" type="button" onclick="location.href='/../main?user_id=${user.user_id}'">아니요</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 확인 -->
	<button id="alertBtn" class="btn" style="display: none;">확인모달</button>
	<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="color: black;">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="alertModalLabel">안내</h5>
				</div>
				<div class="modal-body">${message}</div>
				<div class="modal-footer">
					<form action="/main" method="get">
						<input style="display: none;" name="user_id" value="${user.user_id}">
						<button type="submit" class="btn btn-primary">확인</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 대출이력 -->
	<div class="modal fade" id="historyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="color: black;">
		<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 80%; width: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="historyModalLabel">대출이력</h5>
				</div>
				<div class="modal-body">
					<div class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th></th>
									<th>등록번호</th>
									<th>도서명</th>
									<th>청구기호</th>
									<th>대출일</th>
									<th>반납예정일</th>
									<th>반납일</th>
									<th>대출처리자</th>
									<th>반납처리자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="history" items="${historyList}" varStatus="status">
									<tr>
										<td>${status.count}</td>
										<td>${history.book_id}</td>
										<td>${history.book_title}</td>
										<td>${history.book_callnum}</td>
										<td>${history.record_borrowdate}</td>
										<td>${history.record_duedate}</td>
										<td>${history.record_returndate}</td>
										<td>${history.record_borrowby}</td>
										<td>${history.record_returnby}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>		
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
<script>
		function executeSubmit(){
			var key = event.keyCode;
			if(key==13){
				executeForm.submit();
			}
		}
	</script>	
<script>
		$(window).on("load", function(){
			var messageType = `${messageType}`;
			var msgFunction = `${msgFunction}`;
			
			if(messageType == 0){
				$('#alertBtn').trigger("click");
			}
			else if(messageType == 1){
				if(msgFunction == 0){
					$('#borrowBtn').trigger("click");
				}else if(msgFunction == 1){
					$('#returnBtn').trigger("click");
				}
			}
		});
		$('#returnBtn').click(function(e){
			e.preventDefault();
			$('#returnModal').modal("show");
		});
		$('#borrowBtn').click(function(e){
			e.preventDefault();
			$('#borrowModal').modal("show");
		});
		$('#alertBtn').click(function(e){
			e.preventDefault();
			$('#alertModal').modal("show");
		});
		$('#historyBtn').click(function(e){
			e.preventDefault();
			$('#historyModal').modal("show");
		});
</script>

</body>
</html>