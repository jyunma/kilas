<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${message}[${sessionScope.admin.admin_name}]</title>
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
  </style>
</head>
<body>
		
<!-- Page Header -->
<div id="hPage">
<jsp:include page="header.jsp"></jsp:include>
</div>
<header class="masthead" style="background-color: white;)">
  <div class="container" style="padding-top: 20px ;">
    <div class="row">
      <div class="col-lg-8 col-md-10 mx-auto">
        <div class="page-heading" style="padding: 50px;">
          <span class="subheading" style="font-family: 'BBTreeGL'; font-size: 40px; font-weight: bold; color: black;">${message}</span>
        </div>
      </div>
    </div>
  </div>
</header>
	<br><hr><br>
		<!-- 메인페이지로 이동 -->
		<!-- 도서 상세 페이지로 이동 -->
		<!-- 이용자 메인 페이지로 이동 -->
	<c:choose>
		<c:when test="${where eq 0}">
            <form role="form" action="/main" method="post" class="post-subtitle" style="font-family: 'Noto Sans KR', sans-serif; font-size: 85%; font-weight: bold;">
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary btn-lg">확인</button>
                    </div>
            </form>
		</c:when>
		
		<c:when test="${where eq 1}">
            <form role="form" action="/main" method="get" class="post-subtitle" style="font-family: 'Noto Sans KR', sans-serif; font-size: 85%; font-weight: bold;">
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary btn-lg">확인</button>
                    </div>
            </form>
		</c:when>
		
		<c:when test="${where eq 2}">
            <form role="form" action="/main?user_id=${user_id}" method="post" class="post-subtitle" style="font-family: 'Noto Sans KR', sans-serif; font-size: 85%; font-weight: bold;">
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary btn-lg">확인</button>
                    </div>
            </form>
		</c:when>
	</c:choose>
</body>
</html>