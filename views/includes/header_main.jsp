<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>main.jsp 메인화면</title>
<!-- show.html script -->
<link rel='stylesheet' href='/css/woocommerce-layout.css'
	type='text/css' media='all' />
<link rel='stylesheet' href='/css/woocommerce-smallscreen.css'
	type='text/css' media='only screen and (max-width: 768px)' />
<link rel='stylesheet' href='/css/woocommerce.css' type='text/css'
	media='all' />
<link rel='stylesheet' href='/css/font-awesome.min.css' type='text/css'
	media='all' />
<link rel='stylesheet' href='/style.css' type='text/css' media='all' />
<link rel='stylesheet'
	href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700'
	type='text/css' media='all' />
<link rel='stylesheet' href='/css/easy-responsive-shortcodes.css'
	type='text/css' media='all' />

<!-- //show.html script -->

<!-- header.jsp script -->
<link href="/assets/css/bootstrap.css" rel="stylesheet" />
<link href="/assets/css/login-register.css" rel="stylesheet" />
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

<script src="/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="/assets/js/bootstrap.js" type="text/javascript"></script>
<script src="/assets/js/login-register.js" type="text/javascript"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Custom fonts for this template-->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<!-- //header.jsp script -->

<!-- #page -->
<script src='/js/jquery.js'></script>
<script src='/js/plugins.js'></script>
<script src='/js/scripts.js'></script>
<script src='/js/masonry.pkgd.min.js'></script>
<!-- //#page -->

</head>
<style>
@font-face {
    font-family: 'SaenggeoJincheon';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/SaenggeoJincheon.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
body, h1,p,div,i,a,h2 {
	font-family: 'SaenggeoJincheon' !important;
}
</style>
<body
	class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">
	<div id="page">
		<header id="masthead" class="site-header">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-11"></div>
					<div class="col-md-1">
						<c:choose>
							<c:when test="${empty loginInfo}">
								<a href="/member/login_form" id="login"
									style="margin-right: 10px">Login</a>
								<a href="/member/register_form" id="register">Register</a>
							</c:when>
							<c:otherwise>
								<dl class="nav-item dropdown no-arrow">
									<dt id="dt_dropDown" class="">
										<a class="nav-link dropdown-toggle" href="#" id="userDropdown"
											role="button" data-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false"> <span
											class="mr-2 d-none d-lg-inline text-gray-600 small">${loginInfo.username}님</span>
											<img class="img-profile rounded-circle"
											src="/member/displayImage?userpic=${loginInfo.userpic}"
											style="height: 30px">
										</a>
										<!-- Dropdown - Information -->
										<div
											class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
											aria-labelledby="userDropdown">
											<a class="dropdown-item" href="/page/myPage"> <i
												class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
												마이페이지
											</a>
											<div class="dropdown-divider"></div>
											<a class="dropdown-item" href="/member/logout"> <i
												class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
												로그아웃
											</a>
										</div>
									</dt>
								</dl>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="site-branding">
				<h1 class="site-title">
					<a href="main" rel="home">신발팜</a>
				</h1>
				<h2 class="site-description">신발팜</h2>
			</div>

			<!-- 상단 메뉴바 -->
			<nav id="site-navigation" class="main-navigation">
				<button class="menu-toggle">Menu</button>
				<a class="skip-link screen-reader-text" href="#content">Skip to
					content</a>
				<div class="menu-menu-1-container">
					<ul id="menu-menu-1" class="menu">
						<li><a href="/board/main">메인</a></li>
						<!-- 카테고리 -->
						<li><a href="#">카테고리별</a>
							<ul class="sub-menu">
								<li><a href="#" class="status" data-stat="M">남성</a></li>
								<li><a href="#" class="status" data-stat="F">여성</a></li>
								<li><a href="#" class="status" data-stat="K">아동</a></li>
							</ul></li>
						<!-- // 카테고리 -->
						<li><a href="/page/myPage">내 정보</a></li>
						<li><a href="/page/myPage_delivery?userid=${loginInfo.userid}">배송조회</a></li>
					</ul>
				</div>
			</nav>
			<!-- // 상단 메뉴바 -->
		</header>
		<%@ include file="../includes/pageParam.jsp"%>