<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='/css/myPage_cardInfo.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
	th,td{
		height:50px
	}
</style>
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
		$("#customFile").change(function(e){
			var file=this.files[0];
			console.log(file);
			var reader=new FileReader();
			reader.onload=function(e){
			console.log("파일 읽음");
			
			var val=$("#customFile").val();
			console.log(val);
			var arrVal=val.split("\\");
			var fileName=arrVal.pop();
			$("#customFile").text(fileName);
			console.log(fileName);
			$("#changeUserpic").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);	
		});// customFile
		
		
	});
</script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>

<div class="container-fluid" style="margin-top:50px">
	<div class="row">
		<div class="col-md-6" style="margin-bottom:50px">
		
		<!-- 프로필 카드 -->
		<div class="main-content">
    <div class="container mt-7">
      <!-- Table -->
      <div class="row">
        <div class="col-xl-8 m-auto order-xl-2 mb-5 mb-xl-0">
          <div class="card card-profile shadow">
            <div class="row justify-content-center">
              <div class="col-lg-3 order-lg-2">
                <div class="card-profile-image">
                  <a href="#">
                    <img src="/member/displayImage?userpic=${loginInfo.userpic}" class="rounded-circle">
                  </a>
                </div>
              </div>
            </div>
            <div class="card-body pt-0 pt-md-4">
              <div class="row">
                <div class="col">
                  <div class="card-profile-stats d-flex justify-content-center mt-md-5">
                    
                  </div>
                </div>
              </div>
              <div class="text-center">
               
                <div class="h5 font-weight-300">
                  <i class="ni location_pin mr-2"></i>${loginInfo.username}님<br>보유 포인트:${loginInfo.point}p
                </div>
                <div class="h5 mt-4">
                  <i class="ni business_briefcase-24 mr-2"></i>이메일:${loginInfo.email}
                </div>
                <div>
                  <i class="ni education_hat mr-2"></i>주소:${loginInfo.user_addr1}-${loginInfo.user_addr2}-${loginInfo.user_addr3}
                </div>
                <hr class="my-4">
                <i class="ni education_hat mr-2"></i>가입일:${loginInfo.regdate}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- // 프로필 카드 -->

		</div>
		<!-- 정보 수정 테이블 -->
		<div class="col-md-4">
		<h1>나의 정보</h1>
				<form action="/page/modifyMember" method="post" enctype="multipart/form-data">
					<table class="table">
						<thead>
							<tr>
								<th>정보 수정</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>아이디</th>
								<th><input type="text" class="form-control" name="userid" value="${loginInfo.userid}" readonly/></th>
							</tr>
							<tr>
								<th>이름</th>
								<th><input type="text" class="form-control" name="username" value="${loginInfo.username}"/></th>
							</tr>
							<tr>
								<th>비밀 번호</th>
								<th><input type="password" class="form-control" name="userpw" value="${loginInfo.userpw}"/></th>
							</tr>
							<tr>
								<th>이메일</th>
								<th><input type="email" class="form-control" name="email" value="${loginInfo.email}"/></th>
							</tr>
							<tr>
								<th>주소</th>
								<th><input type="text" class="form-control" name="user_addr1" id="user_addr1" value="${loginInfo.user_addr1}" readonly/></th>
								<th><input type="text" class="form-control" name="user_addr2" id="user_addr2" value="${loginInfo.user_addr2}" readonly/></th>
								<th><input type="text" class="form-control" name="user_addr3" id="user_addr3" value="${loginInfo.user_addr3}"/></th>
								<th><button type="button" class="submit btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button></th>
							</tr>
							<tr>
								
								<th>프로필 사진</th>
								<th>
									<label for="fileInfo">기존 사진</label><br>
									<input type="hidden" name="preUserpic" value="${loginInfo.userpic}">
									<img src="/member/displayImage?userpic=${loginInfo.userpic}" style="height:100px"/>
									<input type="file" class="form-control-file" id="customFile" name="file"/>
								</th>
							</tr>
							<tr>
								<th>프로필 사진 미리보기</th>
								<th><img src="" style="height:100px" id="changeUserpic"/></th>
							</tr>
							<tr>
								<th>가입일</th>
								<th>
									<input type="hidden" name="point" value="${loginInfo.point}">
									<input type="text" class="form-control" name="regdate" value="${loginInfo.regdate}" readonly/>
								</th>
							</tr>
						</tbody>
					</table>
					<button type="submit" style="margin-bottom:40px">수정 하기</button>
				</form>
				
		</div>
		<!-- // 정보 수정 테이블 -->
		<div class="col-md-2">
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>
<!-- #page -->
<script src='/js/jquery.js'></script>
<script src='/js/plugins.js'></script>
<script src='/js/scripts.js'></script>
<script src='/js/masonry.pkgd.min.js'></script>


</body>

</html>

