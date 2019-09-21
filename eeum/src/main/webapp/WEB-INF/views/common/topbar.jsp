<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="${contextPath}/resources/flipClock/flipclock.css"rel="stylesheet" type="text/css">
<script	src="${contextPath}/resources/flipClock/flipclock.js"></script>
<style type="text/css">
	
	.timer {
	    zoom: 0.4;
	    -moz-transform: scale(0.4);
	}
	.flip-clock-dot{
		background-color: rgba(255,255,255,0.8);
	}
	.timer a{
		color: rgba(255,255,255,0.8);
	}
	
	.deleteOneA{
		/* display:none */;
		position: absolute;
		right: 10px;
		font-size:1rem;
		cursor:pointer;
		color:rgb(150,150,150);
		vertical-align: middle;
		z-index: 999;
	}
	.goDetail{
		cursor: pointer;
	}
</style>

</head>
<body>
	    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-primary topbar mb-4 static-top shadow">
		

          <!-- 알람 아이콘들 -->
          <ul class="navbar-nav mr-auto">
          
            <!-- 알람! -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter" id="aCount"></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-left shadow animated--fade-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  	새로운 알람
                  	 <span id="NotmailAllDelete" style="float: right; cursor: pointer;">전체알람삭제</span>
                </h6>
                <div class="A_area">
                
                </div>
              
              </div>
            </li>
            
            <!-- 메일 아이콘  -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter" id="mCount"></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-left shadow animated--fade-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  	새로운 메일
 	               <span id="mailAllDelete" style="float: right; cursor: pointer;">전체알람삭제</span>
                </h6>
                <div class="mailA_area">
                
                </div>
              </div>
            </li>
          </ul>
		<!--알람 아이콘 끝!-->
		
		<div class="timer">
          <div class="clock" style="display: inline-block; margin-left: auto;margin-right: auto;"></div>
		</div>
		<!--나누는바  -->
		 <div class="topbar-divider d-none d-sm-block"></div>
				<div class="profile_Area" style="display:inline-block;">
					<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-300 small" style="font-size: 1.3rem;">${loginEmp.empName}</span>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="profile.do">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>프로필
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃
                </a>
              </div>
				</div>
			</nav>
        <!-- 상단바 영역 끝! -->
<script type="text/javascript">
	var clock;
	var watSub;

	var setDate = new Date();
	/* var clock; */
	
	clock = new FlipClock($('.clock'), {
		clockFace: 'HourlyCounter',
		autoStart: false,
		countdown: false,
		callbacks: {}
		});
		clock.setTime(0);
	
		$.ajax({
			url:"getMychulgun.do",
			dataType:"json",
			success:function(data){
				// https://github.com/objectivehtml/FlipClock/issues/258
				// FlipClock counts down too fast - 참조
				// 너무 빨리 카운팅 되는 문제가 있었음
				// Count up 코드 참조
				// https://stackoverflow.com/questions/26599615/flipclock-count-up-from-a-particular-date
				
				if(data!=null){
					setDate = data.ATTEND;
					setDate = new Date(Date.parse(setDate));
					if(data.GOHOME ==null){
						var currentDate = new Date();
					}else{
						var currentDate = data.GOHOME;
						currentDate = new Date(Date.parse(currentDate));
					}					
						var diff = (currentDate.getTime()/1000) - (setDate.getTime()/1000) ;
						if(diff<0){
							diff = 0;
						}
						watSub = diff;
						clock.setTime(diff);
						
					if(data.GOHOME ==null){
						clock.start();
					}
				}
			}
		});
		/*ajax끝!  */
		
		
		//클릭시 전체 알림 삭제!(메일 외)
		$(document).on('click','#NotmailAllDelete',function(){
			var empNo = "${loginEmp.empNo}";
			var check = "notMail";
			console.log("들어오니?");
			nAllDelete(empNo,check);
		});
		//클릭시 전체 알림 삭제!(메일만)
		$(document).on('click','#mailAllDelete',function(){
			var empNo = "${loginEmp.empNo}";
			var check = "mail";
			nAllDelete(empNo,check);
		});
		
		function nAllDelete(empNo,check){
			$.ajax({
				url:"nAllDelete.do",
				type:"post",
				data:{empNo:empNo,check:check},
				success:function(data){
					if(data=="success"){
						alertList();
					}else{
						alert("알람 업데이트에 실패하였습니다.\n잠시후에 다시 시도해주세요!");
					}
				}
			});
		}
		
		/********************알람 불러오는 영역!*******************/
		$(function() {
			alertList();

			setInterval(function() {
				alertList();
			}, 10000);
		});
		
		function alertList() {
			var empNo = "${loginEmp.empNo}";
			$.ajax({
				url : "selectAlert.do",
				dataType:"json",
				data: {empNo:empNo},
				success : function(data) {
					
					$(".mailA_area").html("");
					$(".mailA_area").css('padding','0');
					$(".A_area").html("");
					$(".A_area").css('padding','0');
					var mCount = 0;
					var aCount = 0;
					
					
					for(var i in data){
					var $area;
					var $a = $('<a class="dropdown-item d-flex align-items-center oneAlert" style="clear: both;">');
					var $input = $('<input type="hidden" class="link">');
					var $input1 = $('<input type="hidden" class="alertNo">');
					var $deleteSpan = $('<span class="deleteOneA">').text("x");
					var $div1 = $('<div class="mr-3">');
					var $div1_1;
					var $i;
					var $div2 = $("<div>");
					var $div2_1 = $('<div class="small text-gray-500">');
					var $span = $('<span class="font-weight-bold goDetail">');
						$input1.val(data[i].ALERTNO);
						if(data[i].ACATE=="mail"){
							$input.val("mailReceive.do?eStatus=N");
							$area = $(".mailA_area");
							$div1_1 = $('<div class="icon-circle bg-primary">');
							$i = $('<i class="fa fa-envelope-o text-white">');
							mCount++;
						}else if(data[i].ACATE!= "mail"){
							$area = $(".A_area");
							
							if(data[i].ACATE == 'ap'){
								$input.val("approvalView.do");
								$div1_1 = $('<div class="icon-circle bg-secondary">');
								$i = $('<i class="fa fa-file-o text-white">');
							}else if(data[i].ACATE == 'cal'){
								$input.val("calPage.do");
								$div1_1 = $('<div class="icon-circle bg-success">');
								$i = $('<i class="fa fa-calendar-o" text-white">');
							}else if(data[i].ACATE == 'room'){
								$input.val("rListView.do");
								$div1_1 = $('<div class="icon-circle bg-info">');
								$i = $('<i class="fa fa-commenting-o" text-white">');
							}
							aCount++;
						}
						
						$div1_1.append($i);
						$div1.append($div1_1);
						$div2_1.text(data[i].CREATEDATE);
						$div2.append($div2_1);
						$span.text(decodeURIComponent(data[i].ACONTENTS.replace(/\+/g, " ")));
						$div2.append($span);
						
						$a.append($input1);
						$a.append($input);
						$a.append($div1);
						$a.append($div2);	
						$a.append($deleteSpan);
						$area.append($a);
					}
					$("#aCount").text(aCount);
					$("#mCount").text(mCount);
					
					if(mCount==0){
						$("#mCount").hide();
						$(".mailA_area").text("확인된 알람이 없습니다.").css('text-align','center').css('padding','1rem');
						$("#mailAllDelete").hide();
					}else{
						$("#mCount").show();
						$("#mailAllDelete").show();
						$(".mailA_area").css('text-align','left').css('padding','0');
					}
					if(aCount==0){
						$("#aCount").hide();
						$(".A_area").text("확인된 알람이 없습니다.").css('text-align','center').css('padding','1rem');
						$("#NotmailAllDelete").hide();
					}else{
						$("#aCount").show();
						$("#NotmailAllDelete").show();
						$(".A_area").css('text-align','left').css('padding','0');
					}
				},
				error : function(){
					console.log("error");
					}

			});
		}
		$(document).on('click','.deleteOneA',function(){
			var alertNo = $(this).closest('a').find('.alertNo').val();
			var aStatus = 'D';
			updateAlert(aStatus,alertNo);
			/* $(this).hide(); */
		});
		
		$(document).on('click','.goDetail',function(){
			var link = $(this).closest('a').find('.link').val();
			var alertNo = $(this).closest('a').find('.alertNo').val();
			var aStatus = 'Y';
			
			updateAlert(aStatus,alertNo);
			location.href=link;
		});
		
		function updateAlert(aStatus,alertNo){
			$.ajax({
				url:"aOneUpdate.do",
				type:"post",
				data:{alertNo:alertNo,aStatus:aStatus},
				success:function(data){
					if(data=="success"){
						alertList();
					}else{
						alert("상태 업데이트에 실패하였습니다.\n잠시 후 다시 시도해 주세요!");
					}
				}
			});
		}
</script>
</body>
</html>