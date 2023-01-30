<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
  <link rel="stylesheet" href="/css/register_form_seller.css">
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
  	// 회원 가입 모달 중복 체크 버튼 < 클릭시
		$("#btnIdCheck").click(function(e){
			e.preventDefault();
			console.log("클릭성공");
			var seller_id=$("#seller_id").val();
			if(seller_id.trim()==""){
				alert("아이디를 입력해주세요.");
				$("#seller_id").focus();
				return;
			}
			var url="/seller/seller_checkId";
			var sData={
				"seller_id":seller_id
			};
			$.post(url,sData,function(rData){
				if(rData=="true"){
					alert("사용 가능한 아이디입니다.");
					$("#btnRegister").attr("data-check","true");
					$("#btnRegister").attr("data-id", seller_id);
				}else{
					alert("사용 불가능한 아이디입니다.");
					$("#btnRegister").removeAttr("data-check");	
					$("#btnRegister").removeAttr("data-id");
				}
			});	
		});// btnIdcheck
		$("#frmRegister").submit(function(){
// 			var check1=$("#btnRegister").attr("data-check");
			var data_id=$("#btnRegister").attr("data-id");
			var seller_id=$("#seller_id").val();
			if (data_id != seller_id) {
				alert("아이디 중복 체크를 해주세요.");
				$("#seller_id").focus();
				return false;
			}
			if($("#seller_name").val().trim()==""
					||$("#seller_email").val().trim()==""
					||$("#seller_pw").val().trim()==""
					||$("#seller_email").val().trim()==""
					||$("#seller_phone").val().trim()==""
					||$("#seller_addr").val().trim()==""){
				alert("입력 항목을 확인해주세요.");
				return false;
			}
		});//frmRegister
  	});//document
  </script>
<body>
  <div class="main">
    <p class="sign" align="center">판매자 회원 가입</p>
    <form action="/seller/seller_registerMember" method="post" id="frmRegister" enctype="multipart/form-data">
      <input class="un" type="text" align="center" name="seller_id" id="seller_id" placeholder="아이디">
      <p align="center" style="margin-top:-20px"><a type="button" class="submit" align="center" id="btnIdCheck">중복 확인</a></p>
      <input class="pass" type="password" align="center" name="seller_pw" id="seller_pw" placeholder="비밀번호">
      <input class="un" type="text" align="center" name="seller_name" id="seller_name" placeholder="판매처 이름">
      <input class="un" type="text" align="center" name="seller_person" id="seller_person" placeholder="대표자 이름">
      <input class="pass" type="email" align="center" name="seller_email" id="seller_email"  placeholder="이메일">
      <input class="pass" type="text" align="center" name="seller_phone" id="seller_phone" placeholder="전화 번호">
      <input class="pass" type="text" align="center" name="seller_addr" id="seller_addr" placeholder="주소">
      <input class="pass" type="file" align="center" name="file" id="file	" value="사진">
      <p align="center"><button type="submit" class="submit" align="center" id="btnRegister">회원 가입 하기</button></p>
      
      <p align="center"><a class="submit" align="center" href="/manage/mainpage">로그인 하러 가기</a></p>
     </form>
    </div>
</body>
</html>