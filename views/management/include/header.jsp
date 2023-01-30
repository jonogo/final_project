<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>
     신발팜 판매자 페이지
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="/manager/assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="/manager/assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="/manager/assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet" />
  <!-- JQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!-- BootStrap -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
  <!-- 내 css 파일 -->
  <link href="/manager/assets/css/my-css.css" rel="stylesheet">
</head>
<style>
/* 나눔스퀘어 */
@font-face {
  font-family: "NanumSquareLight";
  src: url(/font/NanumSquareL.eot);
  src: url(/font/NanumSquareL.eot?#iefix) format('embedded-opentype'),
   	   url(/font/NanumSquareL.woff) format('woff'),
  	   url(/font/NanumSquareL.ttf) format('truetype');
}
@font-face {
  font-family: "NanumSquare";
  src: url(/font/NanumSquareR.eot);
  src: url(/font/NanumSquareR.eot?#iefix) format('embedded-opentype'),
	   url(/font/NanumSquareR.woff2) format('woff2'),
  	   url(/font/NanumSquareR.woff) format('woff'),
  	   url(/font/NanumSquareR.ttf) format('truetype');
}
@font-face {
  font-family: "NanumSquareBold";
  src: url(/font/NanumSquareB.eot);
  src: url(/font/NanumSquareB.eot?#iefix) format('embedded-opentype'),
  	   url(/font/NanumSquareB.woff2) format('woff2'),
  	   url(/font//NanumSquareB.woff) format('woff'),
  	   url(/font/NanumSquareB.ttf) format('truetype');
}
/* 나눔스퀘어 */
@font-face {
    font-family: 'SaenggeoJincheon';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/SaenggeoJincheon.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
label {
  color: black;
}
* {
  font-family: "NanumSquare" !important;
}
input[type=password]{
  font-family: "NanumGothic" !important;
}
::placeholder {
  font-size: 13px;
}
</style>
<body class="g-sidenav-show  bg-gray-200">
<!-- 사이드바 -->
  <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark" id="sidenav-main">
    <div class="sidenav-header">
      <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0" href="/manage/mainpage">
        <span class="ms-1 text-white">
          <span style="font-family: SaenggeoJincheon !important; font-size: 23px;">신발팜</span>
          <span style="font-weight: bold; font-size: 15px;">판매자 페이지</span>
        </span>
      </a>
    </div>
    <hr class="horizontal light mt-0 mb-2">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link text-white
            <c:if test="${sessionScope.pageInfo eq 'mainpage'}">
	            bg-gradient-primary
	            <c:set var="pagename" value="메인 페이지"/>
            </c:if>
            "href="/manage/mainpage">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-house fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">메인 화면</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white
          <c:if test="${sessionScope.pageInfo eq 'order_list'}">
	            bg-gradient-primary
	            <c:set var="pagename" value="주문 정보"/>
          </c:if> 
          " href="/manage/listsellorder">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-terminal fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">주문 목록</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white
          <c:if test="${sessionScope.pageInfo eq 'product_insert'}">
	            bg-gradient-primary
	            <c:set var="pagename" value="상품 등록"/>
          </c:if>
          " href="/manage/registproduct">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-cart-plus fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">상품 등록</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white 
          <c:if test="${sessionScope.pageInfo eq 'product_list'}">
	            bg-gradient-primary
	            <c:set var="pagename" value="상품 정보"/>
          </c:if>
          " href="/manage/listproduct">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-clipboard2 fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">상품 목록</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white 
          <c:if test="${sessionScope.pageInfo eq 'quest_list'}">
	            bg-gradient-primary
	            <c:set var="pagename" value="상품 문의"/>
          </c:if>
          " href="/manage/listquestion">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-envelope fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">상품문의</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white 
            <c:if test="${sessionScope.pageInfo eq 'comment_list'}">
	          bg-gradient-primary
	          <c:set var="pagename" value="상품평"/>
            </c:if>
            " href="/manage/listcomment">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-chat-left-dots fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">상품평</span>
          </a>
        </li>
        <li class="nav-item mt-3">
          <h6 class="ps-4 ms-2 text-uppercase text-xs text-white font-weight-bolder opacity-8">
          	계정 관리</h6>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white
            <c:if test="${sessionScope.pageInfo eq 'seller_info'}">
	          bg-gradient-primary
	          <c:set var="pagename" value="나의 정보"/>
            </c:if>
          " href="/manage/sellerpage">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-person fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">나의 정보</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white " href="/manage/logout">
            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
              <i class="bi bi-person-slash fs-4"></i>
            </div>
            <span class="nav-link-text ms-1">로그아웃</span>
          </a>
        </li>
      </ul>
    </div>
  </aside>
<!--// 사이드바 -->
    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
    <!-- 위쪽 내비바 -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
      <div class="container-fluid py-1 px-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm opacity-5">현재 페이지</li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">
              ${pagename}
			</li>
          </ol>
        </nav>
        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
          <div class="ms-md-auto pe-md-3 d-flex align-items-center">
          </div>
          <ul class="navbar-nav  justify-content-end">
            <li class="nav-item d-flex align-items-center">
                <c:choose>
                  <c:when test="${empty sessionScope.sellerInfo.seller_pic}">
                	<c:set var="seller_pic_head" value="/manager/assets/img/user.png"/>
                  </c:when>
                  <c:otherwise>
                	<c:set var="seller_pic_head" value="/manage/displayImg?attach_file=${sellerInfo.seller_pic}"/>
                  </c:otherwise>
                </c:choose>
                <div class="img-wrapper"
                  style="width: 40px; height:40px; border-radius: 7px;">
				<img src="${seller_pic_head}" id="imgHeader">
                </div>
              <label class="nav-link text-body font-weight-bold px-0 pb-0 mb-0 mr-3">
                ${sessionScope.sellerInfo.seller_name} 님 환영합니다!
              </label>
            </li>
            <li class="nav-item d-flex align-items-center">
              <a href="/manage/logout" class="nav-link text-body font-weight-bold px-0">
                <i class="bi bi-person-slash fs-4"></i>
                <span class="d-sm-inline d-none mb-3">로그아웃</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!--// 위쪽 내비바 -->
</body>
</html>
