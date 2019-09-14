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
<link href='${contextPath}/resources/fullcalendar/timegrid/main.css' rel='stylesheet' />
<link href='${contextPath}/resources/fullcalendar/list/main.css' rel='stylesheet' />
<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/timegrid/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/list/main.js'></script>


<style type="text/css">
	#calendar{
	width:70%;
	margin-left: auto;
	margin-right: auto;
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
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">일정 관리</h6>
                </div>
                <div class="card-body">
                  <div id="calendar" class="fc fc-ltr fc-bootstrap">
					</div>
                </div>
              </div>
			
			<script>
			var date = new Date();
			var day = date.getFullYear() + "-" + ( date.getMonth() + 1 ) + "- " + date.getDate();
			  document.addEventListener('DOMContentLoaded', function() {
				    var calendarEl = document.getElementById('calendar');

				    var calendar = new FullCalendar.Calendar(calendarEl, {
				      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
				      header: {
				        left: 'prev,next today',
				        center: 'title',
				        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
				      },
				      defaultDate: date,
				      navLinks: true, // can click day/week names to navigate views
				      businessHours: true, // display business hours
				      editable: true,
				      events: [
				        {
				          title: 'Business Lunch',
				          start: '2019-08-03T13:00:00',
				          constraint: 'businessHours'
				        },
				        {
				          title: 'Meeting',
				          start: '2019-08-13T11:00:00',
				          constraint: 'availableForMeeting', // defined below
				          color: '#257e4a'
				        },
				        {
				          title: 'Conference',
				          start: '2019-08-18',
				          end: '2019-08-20'
				        },
				        {
				          title: 'Party',
				          start: '2019-08-29T20:00:00'
				        },

				        // areas where "Meeting" must be dropped
				        {
				          groupId: 'availableForMeeting',
				          start: '2019-08-11T10:00:00',
				          end: '2019-08-11T16:00:00',
				          rendering: 'background'
				        },
				        {
				          groupId: 'availableForMeeting',
				          start: '2019-08-13T10:00:00',
				          end: '2019-08-13T16:00:00',
				          rendering: 'background'
				        },

				        // red areas where no events can be dropped
				        {
				          start: '2019-08-24',
				          end: '2019-08-28',
				          overlap: false,
				          rendering: 'background',
				          color: '#ff9f89'
				        },
				        {
				          start: '2019-08-06',
				          end: '2019-08-08',
				          overlap: false,
				          rendering: 'background',
				          color: '#ff9f89'
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
