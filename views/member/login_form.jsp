<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
  <link rel="stylesheet" href="/css/login_form.css">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <title>Sign in</title>

</head>
<script>
	$(document).ready(function(){
		$("#frmLogin").submit(function(){
			var userid=$("#userid").val();
			var userpw=$("#userpw").val();
			
			console.log(userid);
			console.log(userpw);
			if(userid.trim()==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(userpw.trim()==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
		});// frmLogin
		var login_result="${login_result}";
		console.log(login_result);
		if(login_result=="fail"){
			alert("로그인 실패");
		}
	});// document
</script>
<body>
  <div class="main">
    <p class="sign" align="center">로그인</p>
    <form action="/member/login" method="post" id="frmLogin">
      <input class="un" type="text" align="center" placeholder="아이디" name="userid" id="userid">
      <input class="pass" type="password" align="center" placeholder="비밀번호" name="userpw" id="userpw">
      <p align="center"><button class="submit" align="center" href="/board/main">로그인</button><a class="submit" align="center" href="/member/register_form">회원 가입</a></p>
      <p class="forgot" align="center"><a href="/member/seekPassword_form">비밀 번호 찾기</a></p>
      <p class="forgot" align="center"><a href="/seller/login_form">판매자 로그인</a></p>
      </form>
    </div>
</body>
</html>
