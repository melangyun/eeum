<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">

<head>
<title>GroupWare</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
<style type="text/css">
*{
  margin: 0;
  padding: 0;
  text-decoration: none;
  font-family: montserrat;
  box-sizing: border-box;
}

body{
  min-height: 100vh;
  background-image: linear-gradient(120deg, #71698B,rgb(20,20,50));
}

.login-form{
  width: 360px;
  background: #f1f1f1;
  height: 580px;
  padding: 80px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  transition: .5s;
}

.login-form h1{
  text-align: center;
  margin-bottom: 60px;
}

.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 30px 0;
}

.txtb input{
  font-size: 15px;
  color: #333;
  border: none;
  width: 100%;
  outline: none;
  background: none;
  padding: 0 5px;
  height: 40px;
}

.txtb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
}

.focus + span::before{
  top: -5px;
}
.focus + span::after{
  width: 100%;
}

.logbtn{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background: linear-gradient(120deg, #71698B,rgb(20,20,50), #71698B);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
}

.logbtn:hover{
  background-position: right;
}

.bottom-text{
  margin-top: 60px;
  text-align: center;
  font-size: 13px;
}

#findpwd{
  display:none;
  width: 360px;
  background: #f1f1f1;
  height: 580px;
  padding: 80px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
}
#findpwd h1{
  text-align: center;
  margin-bottom: 60px;
}
.btn{
  display: inline-block;
  width: 48%;
  height: 50px;
  border: none;
  background: linear-gradient(80deg, #71698B,rgb(20,20,50), #71698B);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
}

#hidearea{
	display: none;
}

.btn2{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background-color : rgb(200,200,200);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
}
.btn:hover{
  background-position: right;
}
</style>
</head>
<body>
	<script type="text/javascript">
		var key="";
		var emp="";
	</script>
	<form action="login.do" class="login-form" method="post" autocomplete="off">
		<h1>로그인</h1>

		<div class="txtb">
			<input type="text" id="login_empNo"><span data-placeholder="사번"></span>
		</div>

		<div class="txtb">
			<input type="password" id="login_password"> <span data-placeholder="비밀번호"></span>
		</div>

		<input type="button" id="loginbtn" class="logbtn" value="Login" style="font-weight: bold;">

		<div class="bottom-text">
			초기비밀번호는 사번입니다.<br><br>
			<span style="color:gray">
				비밀번호를 잊으셨나요?<br>
				<a id="findFun" style="cursor: pointer; color: black;"><b>여기</b></a>를 클릭해주세요
			</span>
		</div>

	</form>
	
	<div id="findpwd">
		<h1>비밀번호 초기화</h1>
		<div class="txtb">
			<input type="text" id="empNo" autocomplete="off"><span data-placeholder="사번"></span>
		</div>
		<div class="txtb">
			<input type="email" id="email" autocomplete="off"><span data-placeholder="이메일"></span><br>
		</div>
		<input type="button" id="sendMail" class="logbtn" value="메일발송!" style="font-weight: bold;">
		<div id="area1" style="margin-top:1rem;">
			<input type="submit" class="btn2" id="close" value="닫기" style="font-weight: bold;">
		</div>		
		<div id="hidearea" style="text-align: center;">
			<div class="txtb">
				<input type="text" id="idno" name="idno" autocomplete="off"><span data-placeholder="인증번호"></span>
			</div>
			<input type="button" id="okaybtn" class="btn" value="확인" style="font-weight: bold;">
			<input type="button" class="btn" id="close" value="닫기" style="font-weight: bold;">
			<span id="result" style="color:red;font-size: .8rem; transition: .5s;"></span>
		</div>
	</div>

	<script type="text/javascript">
		$(document).on('click','#loginbtn',function(){
			loginFun();
		})
		function loginFun(){
			var empNo = $("#login_empNo").val();
			var password = $("#login_password").val();
			if(empNo==""){
				alert("아이디가 입력되지 않았습니다!");
				$("#login_empNo").focus();
				return;
			}
			if(password==""){
				alert("비밀번호가 입력되지 않았습니다!");
				$("#login_password").focus();
				return;
			}
			$.ajax({
				url:"login.do",
				data:{empNo:empNo,password:password},
				type: "POST",
				success:function(data){
					if(data=="fail"){
						alert("로그인에 실패하였습니다.\n아이디 비밀번호를 확인해주세요!");
					}else if(data=="changePwd"){
						alert("비밀번호 변경 대상입니다.\n비밀번호를 변경해주세요!");
						location.href='profile.do';
					}else{
						console.log(data);
						alert(data+"님, 안녕하세요!");
						location.href='home.do';
					}
				}
			});
		}
	
		$("#login_empNo").keydown(function(key) {
	           if (key.keyCode == 13) {
	        	   $("#login_password").focus();
	           }
          });
		$("#empNo").keydown(function(key) {
           if (key.keyCode == 13) {
        	   $("#email").focus();
           }
       });
       $("#login_password").keydown(function(key) {
           if (key.keyCode == 13) {
        	   loginFun();
           }
      });
		
		$(".txtb input").on("focus", function() {
			$(this).addClass("focus");
		});

		$(".txtb input").on("blur", function() {
			if ($(this).val() == "")
				$(this).removeClass("focus");
		});
		$(document).on('click','#findFun',function(){
			$("#findpwd").fadeIn(600);
		});
		$(document).on('click','#close',function(){
			$("#findpwd").fadeOut(600);
		});
		//메일 발송 버튼 눌렀을 때
		$(document).on('click','#sendMail',function(){
			findPwdFun();
		});
		$("#email").keydown(function(key) {
	           if (key.keyCode == 13) {
	        	   findPwdFun();
	           }
	      });
		
		function findPwdFun(){
			var empNo = $("#empNo").val().trim();
			var email = $("#email").val().trim();
			
			if(empNo==""){
				alert("사번이 입력되지 않았습니다!\n사번을 입력해주세요!");
				$("#empNo").val("");
				$("#empNo").focus();
				return;
			}
			if(email==""){
				alert("이메일이 입력되지 않았습니다!\n이메일을 입력해주세요!");
				$("#email").val("");
				$("#email").focus();
				return;	
			}
			$.ajax({
				url:"email.do",
				data:{empNo:empNo,email:email},
				type: "POST",
				success:function(data){
					if(data=="empNo"){
						alert("사번이 존재하지 않습니다.\n 사번을 확인해주세요!");
					}else if(data=="email"){
						alert("등록된 이메일과 일치하지 않습니다!\n관리자에게 문의해주세요!");						
					}else {
						alert("메일이 발송되었습니다.\n메일함을 확인해주세요");
						$("#area1").hide();
						$("#hidearea").fadeIn(500);
						
						sendEmail(empNo,data,email);
					}
				}
			});
		}
		
		function sendEmail(empNo,empName,email){
			$.ajax({
				url:"sendrealEmail.do",
				data:{empNo:empNo,empName:empName,email:email},
				type: "POST",
				success:function(data){
					key = data;
					emp = empNo;
				}
			});
		}
		
		$(document).on('click','#okaybtn',function(){
			var idno = $("#idno").val();
			if(key==idno){
				$.ajax({
					url:"pwdReset.do",
					data:{emp:emp},
					type: "POST",
					success:function(data){
						if(data=="success"){
						$("#result").text('');
						alert("비밀번호가 초기화 되었습니다!\n로그인 후 비밀번호를 변경해주세요!");
						$("#findpwd").fadeOut(600);
						}else{
							alert("비밀번호 초기화에 실패하였습니다.");
						}
					}
				});
			}else{
				$("#result").text("인증번호를 확인해주세요");
			}
		})
		
	</script>
</body>

</html>
