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
<!-- Full Calendar  -->
<link href='${contextPath}/resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${contextPath}/resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>

<!--자동완성  -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<style type="text/css">
	.fc-title{
	color: white;
	}
	.fc-event, .fc-event-dot {
    background-color: rgb(20,20,50);
	}
	.fc-event{
	border: rgb(20,20,50);
	}
	
	.first-area{
		margin-bottom: 5rem;
		margin-left: auto;
		margin-right: auto;
		transition: .8s;
		margin-top: 5rem;
	}
	
	#calendarWrapper{
	display: none;
	}
	
	.secondArea, .ThirdArea{
		display: none;
	}
	.selection{
		text-align: center;
		
	}
	.cards{
		display:inline-block;
	 	margin:.8rem;
	 	transition: .8s;
	}
	.cards:hover{
		background: lightblue;
		/* margin:.9rem; */
	}
	.cardsSelect{
		background: lightgray;
	}
	.fc-day:hover{
		background: lightblue;
	}
	#joinEmp{
		display:inline-block;
		border: none;
		margin: 5px;
		padding: 5px;
		clear: both;
		width: 40%;		
	}
	#joinEmp:focus{
	outline: none;
	}
	
	.calssArea{
	float:left;
	border: 1px solid lightgray; 
	background: rgba(212,244,250,0.8); 
	color:rgb(20,20,20);
	border-radius: 1rem;
	padding: 8px;
	margin: 5px;
	}
</style>
</head>

<body id="page-top">
	<script type="text/javascript">
		var 
	</script>
	<!-- 메인레버 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" flush="false"></jsp:include>
		<!-- 상단바 -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" flush="false"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">회의실 예약</h1>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="card shadow mb-4">
						<div class="card-header">
			             	<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">회의실 목록</h6>
			           	</div>
			           	<div class="card-body" >
			           		<div class="row first-area">
				           		<div class="col-lg-3">
				           			<h5 style="margin-top: 3px">회의실 선택</h5>
				           		</div>
				           		<div class="col-lg-7">
					           		<select name="dataTable_length" id="selectBox" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
					           			<c:forEach var="r" items="${roomList}">
					           				<option value="${r.MNO}">${r.MNAME}</option>
					           			</c:forEach>
					           		</select>
				           		</div>
			           		</div>
			           		<script type="text/javascript">
			           			$(document).ready(function(){
					           		$("#selectBox").val("");
			           			});
	
			           			$("#selectBox").change(function() {
			           				   $(".first-area").css('margin-top','0').css('margin-bottom','2rem');
							           $("#calendarWrapper").fadeIn(1000);
							           $(".fc-today-button").trigger('click');
									});
			           		</script>
			           			<div id="calendarWrapper">
			           			 	<div id="calendar" class="fc fc-ltr fc-bootstrap">
			           			 </div>
			           		 </div>
           		 			<script>
		           		 		var date = new Date();
		           		 		var firstDayOfMonth = new Date( date.getFullYear(), date.getMonth() , 1 );
		           		 		var lastMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
								  document.addEventListener('DOMContentLoaded', function() {
									    var calendarEl = document.getElementById('calendar');
					
									    var calendar = new FullCalendar.Calendar(calendarEl, {
									        plugins: [ 'interaction', 'dayGrid' ],
									        defaultDate: lastMonth,
									        editable: true,
									        eventLimit: true, // allow "more" link when too many events
									        dateClick: function(info) {
									            /* alert('Clicked on: ' + info.dateStr); */
									            //날짜 받아옴!
									            $(".secondArea").fadeIn(1000);
									            $(".fc-day").css('background','none');
									            info.dayEl.style.backgroundColor = 'lightgray';
									            
									          }
									      });

									      calendar.render();
									    });

					
								</script>
			           	</div>
			       </div>
			    </div>
			    <div class="col-lg-8">
			    	<div class="card shadow mb-4 secondArea">
			    		<div class="card-header">
			    			<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">예약 가능시간</h6>
			    		</div>
		                <div class="card-body">
		                	<div class="row" style="margin: auto; min-height: 9rem;">
		                		<%for(int i = 9 ; i < 18 ; i++){ %>
			                		<div class="card shadow h-100 py-2 cards">
						                <div class="card-body">
						                  <div class="row no-gutters align-items-center">
						                    <div class="col mr-2">
						                      <div class="h5 mb-0 font-weight-bold text-gray-800 selection"><span class="time"><%=i%></span>시</div>
						                    </div>
						                  </div>
						                </div>
						              </div>
						          <%} %>
						          <script type="text/javascript">
						          $(document).on('click',".cards",function(){
						        	  var time =$(this).find(".time").text();
						        	  console.log(time);
						        	  $(this).addClass("cardsSelect");
						        	  $(".ThirdArea").show(1000);
						          });
						          $(document).on('click',".cardsSelect",function(){
						        	  var time =$(this).removeClass("cardsSelect");
						          });
						          </script>
		                	</div>
		                </div>
			    	</div>
			    	<div class="card shadow mb-4 ThirdArea">
			    		<div class="card-header">
			    			<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">상세입력</h6>
			    		</div>
			    		<div class="card-body">
			    			<div class="form-group">
						    	<input type="text" class="form-control" name="mTitle" placeholder="미팅명">
						  	</div>
						  	<div class="form-group">
						  		<textarea class="form-control" rows="5" placeholder="설명" style="resize: none; overflow: auto;"></textarea>
						  	</div>
						  	<div class="form-group">
						  		<div class="">
							  		<div class="extraArea">
							  			
							  		</div>
					  				<input type="text" id="joinEmp" placeholder="참가인 추가">
					  				<script type="text/javascript">
						  				$(document).on('keyup','#joinEmp',function(){
						  					var search = $(this).val();
						  					$.ajax({
												url:"searchEmpList.do",
												data:{search:search},
												dataType:"json",
												success : function(data){
													var list = [];
													if(data.length > 0){
														for(var i in data){
															list.push(decodeURIComponent(data[i].replace(/\+/g," ")));
														}
														$("#joinEmp").autocomplete({
															source:list,
															select: function(event, ui) {
																//console.log(ui.item);
																/* $(this).attr('readonly',true); */
																addFun(ui.item.value);
																return false;
													        },
													        focus: function(event, ui) {
													            return false;
													        }
														});
													}
												}
											});
									});
						  				function addFun(value){
						  					var $div = $(".extraArea");
											var $span = $("<span class='calssArea'>").text(value);
											console.log(value);
											$div.append($span);
											$("#joinEmp").val("");
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
