<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용자 검색[${sessionScope.admin.admin_name}]</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
  body {
			text-align: center;
			color: #FFF;
			width: 1920px;
			height: 1080px;
		}
		#hPage{
		margin: 0px;
		height : 88px;
		clear: both;
		}
		header{
		height: 20%;
		}
		
		section{
			border:1px solid #999;
			margin : auto;
			padding: 20px;
			font-family: 'Noto Sans KR', sans-serif;
			font-size: 100%;
		}
		.section3{
			width: 90%;
			position: relative;
			clear: both;
		}
		.rstTr:hover {
			color: navy;
		}
  </style>
</head>
<body>
		
<!-- Page Header -->
<div id="hPage">
<jsp:include page="header.jsp"></jsp:include>
</div>
<header class="masthead" style="background-image : url('/headimg.jpg')">
  <div class="container" style="padding-top: 20px ;">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
        <div class="page-heading" style="padding: 20px;">
          <span class="subheading" style="font-family: 'BBTreeGL'; font-size: 50px; font-weight: bold;">이용자 검색</span>
        </div>
      </div>
    </div>
  </div>
</header>


  <div class="container" style="color: black; text-align: left;">
    <div class="row" style="text-align: left;">
      <div class="col-lg-8 col-md-10 mx-auto" style="text-align: left;">
        <div class="post-preview" style="width: 100%; ">
            <br><hr>
            <form role="form" name="searchForm" action="/main/searchUser" method="get" class="form-inline" style="font-family: 'Noto Sans KR', sans-serif; font-size: 85%; font-weight: bold; width: 100%;">
                     <div class="form-group" style="width: 100%;">
                        <label for="field"></label>
                        <select class="form-control" id="field" name="field" required="required" style="width:auto;">
                        	<option value="이름">이름</option>
                        	<option value="연락처">연락처</option>
                        	<option value="주소">주소</option>
                        </select>
                        <label for="keyword"></label>
                        <input type="text" class="form-control" id="keyword" placeholder="검색어를 입력해주세요" value="${keyword}" name="keyword" style="width:70%;" required="required" onkeyup="searchSubmit()">
                    </div>
                    <br><br>
                </form>
        </div>
        <br><br><br>
        
      </div>
    </div>
  </div>
  <hr color=lightgray width="95%" style="clear:both">
		
		<!-- 대출목록 세션 -->
		<section class="section3">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>이용자 번호</th>
							<th>이름</th>
							<th>연락처</th>
							<th>주소</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rst" items="${rstList}">
							<tr class="rstTr" onclick="location.href='/main?user_id=${rst.user_id}'" style="cursor:pointer;">
									<td>${rst.user_id}</td>
									<td>${rst.user_name}</td>
									<td>${rst.user_phone}</td>
									<td>${rst.user_address}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>		
			</div>
		</section>
		<br><br><br>
		
	<script type="text/javascript">
		function searchSubmit(){
			var key = event.keyCode;
			if(key==13){
				searchForm.submit();
			}
		}
	</script>
</body>
</html>