<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
  <link rel="stylesheet" href="/css/register_form.css">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="/css/font-awesome.min.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <title>Sign in</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execPostCode() {
         new daum.Postcode({
             oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                console.log(data.zonecode);
                console.log(fullRoadAddr);
                
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("[name=user_addr1]").val(data.zonecode);
                $("[name=user_addr2]").val(fullRoadAddr);
//                 document.getElementById('user_addr1').value = data.zonecode; //5자리 새우편번호 사용
//                 document.getElementById('user_addr2').value = fullRoadAddr;
                
                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
            }
         }).open();
     }
</script>
<script>
  $(document).ready(function(){
  	// 회원 가입 모달 중복 체크 버튼 < 클릭시
		$("#btnIdCheck").click(function(e){
			e.preventDefault();
			console.log("클릭성공");
			var userid=$("#userid").val();
			if(userid.trim()==""){
				alert("아이디를 입력해주세요.");
				$("#userid").focus();
				return;
			}
			var url="/member/checkId";
			var sData={
				"userid":userid
			};
			$.post(url,sData,function(rData){
				if(rData=="true"){
					alert("사용 가능한 아이디입니다.");
					$("#btnRegister").attr("data-check","true");
					$("#btnRegister").attr("data-id", userid);
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
			var userid=$("#userid").val();
			if (data_id != userid) {
				alert("아이디 중복 체크를 해주세요.");
				$("#userid").focus();
				return false;
			}
			if($("#username").val().trim()==""||$("#email").val().trim()==""||$("#userpw").val().trim()==""){
				alert("입력 항목을 확인해주세요.");
				return false;
			}
		});//frmRegister
  	});//document
  </script>
<body>
  <div class="main">
    <p class="sign" align="center">회원 가입</p>
    
    <form action="/member/registerMember" method="post" id="frmRegister" enctype="multipart/form-data">
      <input class="un" type="text" align="center" name="userid" id="userid" placeholder="아이디">
      <p align="center" style="margin-top:-20px"><a type="button" class="submit" align="center" id="btnIdCheck">중복 확인</a></p>
      <input class="pass" type="password" align="center" name="userpw" id="userpw" placeholder="비밀번호">
      <input class="un" type="text" align="center" name="username" id="username" placeholder="이름">
      <input class="pass" type="email" align="center" name="email" id="email" placeholder="이메일">
      <input class="pass" style="width: 40%; display: inline;" placeholder="우편번호" name="user_addr1" id="user_addr1" type="text" readonly="readonly" >
                        <button type="button" class="submit btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>
      <input class="pass" style="top: 5px;" placeholder="도로명 주소" name="user_addr2" id="user_addr2" type="text" readonly="readonly" />
      <input class="pass" placeholder="상세주소" name="user_addr3" id="user_addr3" type="text"  />     
      <input class="pass" type="file" align="center" name="file" id="file">
      <p align="center"><button type="submit" class="submit" align="center" id="btnRegister">회원 가입 하기</button></p>
      
      <p align="center"><a class="submit" align="center" href="/member/login_form">로그인 하러 가기</a></p>
     </form>
     
    </div>
</body>
</html>