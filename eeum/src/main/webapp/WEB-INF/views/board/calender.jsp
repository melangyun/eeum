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

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>

<!-- Full Calendar  -->
<link href='${contextPath}/resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${contextPath}/resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>


<style type="text/css">
	/* #calendar{
	width:80%;
	margin-left: 10%;
	transition: .8s;
	} */
	.fc-title{
	color: white;
	}
	.fc-event, .fc-event-dot {
    background-color: rgb(20,20,50);
	}
	.fc-event{
	border: rgb(20,20,50);
	}
	.plusDetail{
	margin-top: 2rem;
	}
	.btnArea{
		margin-left: auto;
		margin-right: auto;
		display: inline-block;
	}
	#insertBtn{
		background-color: rgba(44,62,80,0.5);
		color:white;
	}
	.calendarArea{
	margin-left: 20%;
	transition: 1.3s;
	}
	.hideArea{
	display: none;
	position: absolute;
	background: white;
	/* transition-delay:0.5s;
	 -webkit-transition-delay:0.5s; */
	}
	#shareBtn{
		background-color: rgba(20,20,50,0.8);
		color:white;
	}
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
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">일정 관리</h1>
			</div>
			<div class="card shadow mb-4">
                <div class="card-body" style="padding:5rem;">
                	<a id="plusBtn" class="btn btn-primary btn-icon-split" style="display: inline-block; maring:0; text-align:right">
						<span class="icon" style="color: white;">
							<i class="fa fa-plus"></i>신규일정
						</span>
					</a>
					<div class="row">
					  <div class="col-lg-3 hideArea">
					  	<div class="card card-body plusDetail">
					  		<div class="form-group">
						    	일정 제목 <input type="text" class="form-control" id="cTitle">
						  	</div>
						  	<div class="form-group">
						    	시작일<input type="date" class="form-control" id="cDate" max="9999-12-31">
						  	</div>
						  	<div class="form-group">
						    	종료일<input type="date" class="form-control" id="cFDate" max="9999-12-31">
						    	<c:if test="${loginEmp.empStatus eq 'A' }">
						    		<label style="margin-top: 1rem;"><input type="checkbox">전체 일정으로 공지</label>
						  		</c:if>
						  	</div>
						  	<div class="btnArea">
						  		<button type="button" class="btn" id="insertBtn">추가</button>
						  		<button type="button" class="btn" id="shareBtn">공유</button>
						  	</div>
						  </div>
					  </div>
					  <div class="col-lg-7 calendarArea">
	                  	<div id="calendar" class="fc fc-ltr fc-bootstrap"></div>
	                  	</div>
					</div>
                </div>
              </div>
			
			<script>
			var date = new Date();
			  document.addEventListener('DOMContentLoaded', function() {
				  var calendarEl = document.getElementById('calendar');
					
				    var calendar = new FullCalendar.Calendar(calendarEl, {
				        plugins: [ 'interaction', 'dayGrid' ],
				        defaultDate: date,
				        editable: false,
				        eventLimit: true,
				        dateClick: function(info) {
				            /* alert('Clicked on: ' + info.dateStr); */
				            /* var selectDay = info.dateStr;
				            var plusEvent = prompt(selectDay +"일 일정 추가");
				           	console.log(plusEvent); */
				          },
				        views: {
				            dayGrid: {
				               eventLimit: 2
				            }
				        }
				      });
				  		  //참여 회의
					    <c:forEach var ='i' items='${rlist}'>
			           		calendar.addEvent({'title': '${i.title}',
			           							'start':'${i.start}',
			           							'url':'rListView.do',
			           							'color':'rgb(20,20,50)',
			           							'textColor':'white'
			           							});
	           			</c:forEach>
	           			
	           			//입사기념일
	           			<c:forEach var ='i' items='${elist}'>
			           		calendar.addEvent({'title': '${i.title}님 입사기념일',
			           							'start':'${i.start}',
			           							'color':'#FFBB00',
			           							'textColor':'white'
			           							});
	           			</c:forEach>
	           			//휴가
	           			<c:forEach var ='i' items='${vlist}'>
		           		calendar.addEvent({'title': '${i.title}님 휴가',
		           							'start':'${i.start}',
		           							'end':'${i.finish}',
		           							'color':'#5F00FF',
		           							'textColor':'white'
		           							});
           				</c:forEach>
				      calendar.render();
				    });

			</script>
			<script type="text/javascript">
				$(document).on('click', '#plusBtn', function(){
					$(".calendarArea").css('margin-left','35%');
					$(".hideArea").fadeIn(1500);
				});
				
				$(document).on('click','#insertBtn',function(){
					$(".calendarArea").css('margin-left','20%');
					$(".hideArea").fadeOut(500);
				});
			</script>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
