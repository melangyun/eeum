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
	#calendar{
	width:70%;
	margin-left: auto;
	margin-right: auto;
	}
	.fc-title{
	color: white;
	}
	.fc-event, .fc-event-dot {
    background-color: rgb(20,20,50);
	}
	.fc-event{
	border: rgb(20,20,50);
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
                  <div id="calendar" class="fc fc-ltr fc-bootstrap">
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
				        editable: true,
				        eventLimit: true, // allow "more" link when too many events
				        events: [
				          {
				            title: 'All Day Event',
				            start: '2019-08-01'
				          },
				          {
				            title: 'Long Event',
				            start: '2019-08-07',
				            end: '2019-08-10'
				          },
				          {
				            groupId: 999,
				            title: 'Repeating Event',
				            start: '2019-08-09T16:00:00'
				          },
				          {
				            groupId: 999,
				            title: 'Repeating Event',
				            start: '2019-08-16T16:00:00'
				          },
				          {
				            title: 'Conference',
				            start: '2019-08-11',
				            end: '2019-08-13'
				          },
				          {
				            title: 'Meeting',
				            start: '2019-08-12T10:30:00',
				            end: '2019-08-12T12:30:00'
				          },
				          {
				            title: 'Lunch',
				            start: '2019-08-12T12:00:00'
				          },
				          {
				            title: 'Meeting',
				            start: '2019-08-12T14:30:00'
				          },
				          {
				            title: 'Happy Hour',
				            start: '2019-08-12T17:30:00'
				          },
				          {
				            title: 'Dinner',
				            start: '2019-08-12T20:00:00'
				          },
				          {
				            title: 'Birthday Party',
				            start: '2019-08-13T07:00:00'
				          },
				          {
				            title: 'Click for Google',
				            url: 'http://google.com/',
				            start: '2019-08-28'
				          }
				        ]
				      });

				      calendar.render();
				    });


			</script>


		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
