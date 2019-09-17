<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,500,900);
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);
figure.snip1382 {
  font-family: 'Source Sans Pro', Arial, sans-serif;
  position: relative;
  overflow: hidden;
  margin: 10px;
  /* min-width: 230px;
  max-width: 315px;
  max-height: 220px; */
  width: 100%;
  color: #ffffff;
  text-align: center;
  font-size: 16px;
}
figure.snip1382 * {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
}
figure.snip1382 img {
  max-width: 100%;
}
figure.snip1382:after,
figure.snip1382:before,
figure.snip1382 figcaption:after,
figure.snip1382 figcaption:before {
  background: #0a0a0a;
  height: 25%;
  position: absolute;
  content: '';
  opacity: 0;
  -webkit-transition: all 0.35s steps(4);
  transition: all 0.35s steps(4);
  z-index: 1;
  left: 50%;
  right: 50%;
}
figure.snip1382:before {
  top: 0;
  -webkit-transition-delay: 0;
  transition-delay: 0;
}
figure.snip1382:after {
  top: 25%;
  -webkit-transition-delay: 0.1s;
  transition-delay: 0.1s;
}
figure.snip1382 figcaption:before {
  top: 50%;
  -webkit-transition-delay: 0.2s;
  transition-delay: 0.2s;
  z-index: -1;
}
figure.snip1382 figcaption:after {
  top: 75%;
  -webkit-transition-delay: 0.3s;
  transition-delay: 0.3s;
  z-index: -1;
}
figure.snip1382 figcaption {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 2;
  padding: 30px;
}
figure.snip1382 h2,
figure.snip1382 p,
figure.snip1382 .icons {
  margin: 0;
  width: 100%;
  opacity: 0;
}
figure.snip1382 h2 {
  font-weight: 900;
  text-transform: uppercase;
}
figure.snip1382 p {
  font-weight: 300;
}
figure.snip1382 .icons {
  position: absolute;
  bottom: 30px;
  left: 0;
  width: 100%;
}
figure.snip1382 i {
  padding: 0px 10px;
  display: inline-block;
  font-size: 24px;
  color: #ffffff;
  text-align: center;
  opacity: 0.8;
  text-decoration: none;
}
figure.snip1382 i:hover {
  opacity: 1;
}
figure.snip1382:hover:after,
figure.snip1382.hover:after,
figure.snip1382:hover:before,
figure.snip1382.hover:before,
figure.snip1382:hover figcaption:after,
figure.snip1382.hover figcaption:after,
figure.snip1382:hover figcaption:before,
figure.snip1382.hover figcaption:before {
  left: 0;
  right: 0;
  opacity: 0.8;
}
figure.snip1382:hover figcaption h2,
figure.snip1382.hover figcaption h2,
figure.snip1382:hover figcaption p,
figure.snip1382.hover figcaption p,
figure.snip1382:hover figcaption .icons,
figure.snip1382.hover figcaption .icons {
  -webkit-transition-delay: 0.25s;
  transition-delay: 0.25s;
}
figure.snip1382:hover figcaption h2,
figure.snip1382.hover figcaption h2,
figure.snip1382:hover figcaption .icons,
figure.snip1382.hover figcaption .icons {
  opacity: 1;
}
figure.snip1382:hover figcaption p,
figure.snip1382.hover figcaption p {
  opacity: 0.7;
}

#file { display:none; }
</style>
</head>

<body id="page-top">

	<!-- 메인레버 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" flush="false"></jsp:include>
		<!-- 상단바 -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" flush="false"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <!-- <div class="col-lg-5 d-none d-lg-block" style="background:url('https://images.unsplash.com/photo-1552329818-8f4f36c525d1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');cursor: pointer;vertical-align: middle; text-align: center;">
          	<span style="margin-top: 10em;">프로필 사진 등록하기</span>
          </div> -->
		<input type="file" id="file" name="file"/>
          <div class="col-lg-5 d-none d-lg-block">
          	<figure id="uploadProfile" class="snip1382" >
				  <img id="userprofile" src="https://images.unsplash.com/photo-1521898284481-a5ec348cb555?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"/>
				  <figcaption>
				    <h2>profile Edit</h2>
				  </figcaption>
				</figure>
          </div>
          <script type="text/javascript">
	          $(".hover").mouseleave(
	        		  function () {
	        		    $(this).removeClass("hover");
	        		  }
	        		  );

          </script>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">프로필 관리</h1>
              </div>
	              <table class="table table-bordered">
	              <colgroup>
	              	<col width="30%">
	              	<col>
	              </colgroup>
	              	<tr>
		              	<td>사번</td>
		              	<td>${loginEmp.empNo}</td>
		              </tr>
		              <tr>
		              	<td>이름</td>
		              	<td>${loginEmp.empName}</td>
		              </tr>
		              <tr>
		              	<td>소속 부서</td>
		              	<td>${loginEmp.deptName}</td>
		              </tr>
		              <tr>
		              	<td>직급</td>
		              	<td>lv. ${loginEmp.empPosition}</td>
		              </tr>
		              <tr>
		              	<td>입사일</td>
		              	<td>${loginEmp.joinDate}</td>
		              </tr>
	              </table>
              <hr>
              	<div class="text-center">
              	  <h1 class="h4 text-gray-900 mb-4" >비밀번호 변경</h1>
            	 </div>
            	 <form class="user">
					<div class="form-group">
	                  <input type="password" id="pwd" class="form-control form-control-user" placeholder="기존 비밀번호">
	                </div>
	                <div class="form-group">
	                  <input type="password" id="new_pwd1" class="form-control form-control-user" placeholder="새로운 비밀번호">
	                </div>
	                <div class="form-group">
	                  <input type="password" id="new_pwd2" class="form-control form-control-user" placeholder="비밀번호 확인">
	                </div>
	                <a onclick="changePwdFunc();" class="btn btn-primary btn-user btn-block">
	                 	비밀번호 변경하기
	                </a>
                </form>
                <script type="text/javascript">
                	function changePwdFunc(){
                		var new_pwd1 = $("#new_pwd1").val();
                		var new_pwd2 = $("#new_pwd2").val();
                		var pwd= $("#pwd").val();
                		
                		if(new_pwd1=="" ||new_pwd2==""|| pwd=="" ){
                			alert("기존 비밀번호와 비밀번호 확인은 공백일 수 없습니다.");
                			return;
                		}
                		
                		if(new_pwd1 != new_pwd2){
                			alert("비밀번호 확인이 일치하지 않습니다.");
                			return;
                		}
                		
                		$.ajax({
                			url:"changePwd.do",
                			data:{pwd:pwd,new_pwd1:new_pwd1},
                			type:"post",
                			success:function(data){
                				var result = data;
                				alert(result);
                				$("#new_pwd1").val('');
                				$("#new_pwd2").val('');
                				$("#pwd").val('');
                			}
                		});
                		
                	}
                </script>
              
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>



		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
