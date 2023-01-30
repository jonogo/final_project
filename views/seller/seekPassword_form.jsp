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
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <title>Sign in</title>

</head>
<script>
	$(document).ready(function(){
		var message="${message}";
		console.log("message:",message);
		if(message=="notfound"){
			alert("아이디와 이메일이 존재하지 않습니다.");
		}
		if(message=="notvalid"){
			alert("이메일이 일치하지 않습니다.");
		}
		$("#seekPassword").submit(function(){
			var seller_id=$("#seller_id").val();
			var email=$("#email").val();
			
			
			if(seller_id.trim()==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(email.trim()==""){
				alert("이메일을 입력하세요.");
				return false;
			}
			
		});// frmLogin
	});// document
</script>
<body>
  <div class="main">
    <p class="sign" align="center">비밀번호 찾기</p>
    <form action="/seller/seekPassword_seller" method="get" id="seekPassword">
      <input class="un" type="text" align="center" placeholder="아이디" name="seller_id" id="seller_id">
      <input class="pass" type="email" align="center" placeholder="이메일" name="to" id="email">
      <p align="center"><button class="submit" align="center">비밀번호 찾기</button><a class="submit" align="center" href="/seller/register_form">회원 가입</a></p>  
      <p class="forgot" align="center"><a href="/seller/login_form">판매자 로그인</a></p>         
      </form>
    </div>
</body>
</html>
