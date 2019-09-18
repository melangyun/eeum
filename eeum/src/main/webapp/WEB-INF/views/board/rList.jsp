<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<style type="text/css">
.fc-scroller {
   overflow-y: hidden !important;
}
.hidearea{
display: none;
}
.buttonArea{
	text-align: center;
	margin-top: 2rem;
	margin-bottom: 2rem;
}
.fc-title{
	cursor: pointer;
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
				<h1 class="h3 mb-0 text-gray-800">예약 현황</h1>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="card shadow mb-4">
						<div class="card-header">
			             	<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">날짜 선택</h6>
			           	</div>
			           	<div class="card-body" >
			           		<div>
			           			<div id="calendar" class="fc fc-ltr fc-bootstrap"></div>
			           		<script type="text/javascript">
					           	 document.addEventListener('DOMContentLoaded', function() {
					           		var today = new Date();
					           	  var calendarEl = document.getElementById('calendar');
						           	var calendar = new FullCalendar.Calendar(calendarEl, {
								        plugins: [ 'interaction', 'dayGrid' ],
								        defaultDate: today,
								        editable: false,
								        views: {
								            dayGrid: {
								               eventLimit: 2
								            }
								         },
								        eventLimit: true,// allow "more" link when too many events
								        dateClick: function(info) {
								            /* alert('Clicked on: ' + info.dateStr); */
								          },
							          eventClick: function(info) {
							        	 	 $(".hidearea").hide();
							        	  	$(".hidearea").fadeIn(1000);
											var id = info.event.id;
											var temp = id.split(";");
											var rDate = temp[0];
											var rTime = temp[1];
											var mNo = temp[2];
											
											var input_mTitle = "";
											var input_rDate ="일시 : "+rDate+"일 "+rTime+"시(1시간 단위)";
											var input_mName ="";
											var input_empNo="";
											var input_mContnet="";
											var input_joinEmp="";
											
											<c:forEach var="i" items="${mine}">
												var temp = "${i.rDate}";
												if(rDate==temp){
													temp="${i.rTime}"
													if(temp==rTime){
														temp="${i.mNo}"
														if(mNo==temp){
															input_mTitle = "${i.mTitle}";
									        	    		input_mName = "${i.mName}";
									        	    		input_mContnet = "${i.mContnet}";
									        	    		input_joinEmp = "${i.joinEmp}";
									        	    		input_empNo="${i.empNo}";
														}
													}
												}
												
											</c:forEach>
											<c:forEach var="i" items="${join}">
						        	    	console.log("${i.rDate}");
											var temp = "${i.rDate}";
											if(rDate==temp){
												temp="${i.rTime}"
												if(temp==rTime){
													temp="${i.mNo}"
													if(mNo==temp){
														input_mTitle = "${i.mTitle}";
								        	    		input_mName = "${i.mName}";
								        	    		input_mContnet = "${i.mContnet}";
								        	    		input_joinEmp = "${i.joinEmp}";
								        	    		input_empNo="${i.empNo}";
													}
												}
											}
											
										</c:forEach>
											$("#joinEmp_hidden").val(input_joinEmp);
											input_joinEmp = input_joinEmp.replace(/;/gi,"\n")
											$("#mTitle").val("제목 : "+input_mTitle);
											$("#rDate").val(input_rDate);
											$("#mName").val("회의장 : "+input_mName);
											$("#mContnet").val("설명 : \n" + input_mContnet);
											$("#joinEmp").val("참여자\n"+input_joinEmp);
											$("#empNo").val("신청자 : "+input_empNo);
											$("#id").val(id);
							        	    /* 	alert('Event: ' + info.event.title);
							        	    alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
							        	    alert('View: ' + info.view.type); */
							        	    // change the border color just for fun
							        	    //info.el.style.borderColor = 'gary';
							        	    
							        	    var $button = $("<button class='btn btn-secondary updateBtn'>");
							        	    if(input_empNo.includes("${loginEmp.empNo}")){
							        	    	$button.text("예약 취소");
							        	    }else{
							        	    	$button.text("불참 신청");
							        	    }
							        	    $(".buttonArea").html("");
							        	    $(".buttonArea").append($button);
							        	  }
								      });
						            <c:forEach var ='i' items='${mine}'>
						           		calendar.addEvent({'id':'${i.rDate};${i.rTime};${i.mNo}',
						           							'title': '${i.mTitle}',
						           							'start':'${i.rDate}',
						           							'color':'rgb(20,20,50)',
						           							'textColor':'white'
						           							});
					           		</c:forEach>
					           		<c:forEach var ='i' items='${join}'>
					           		calendar.addEvent({'id':'${i.rDate};${i.rTime};${i.mNo}',
					           							'title': '${i.mTitle}',
					           							'start':'${i.rDate}',
					           							'color':'#FF5E00',
					           							'textColor':'white'
					           							});
				           			</c:forEach>
						           	calendar.render();
						           	
					           	 });
					           	 
					           	 
			           		</script>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-8 hidearea">
			    	<div class="card shadow mb-4">
			    		<div class="card-header">
			    			<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">예약 내용</h6>
			    		</div>
			                <div class="card-body" id="body">
			                	<input type="hidden" id="id">
			                	<input type="hidden" id="joinEmp_hidden">
			                	<div class="form-group">
							    	<input type="text" id="mTitle" class="form-control" readonly><!-- 미팅명 -->
							  	</div>
							  	<div class="form-group">
							    	<input type="text" id="rDate" class="form-control" readonly><!-- 시간 -->
							  	</div>
							  	<div class="form-group">
							    	<input type="text" id="mName" class="form-control" readonly><!-- 장소 -->
							  	</div>
							  	<div class="form-group">
							    	<input type="text" id="empNo" class="form-control" readonly><!-- 신청인 -->
							  	</div>
							  	<div class="form-group">
							    	<textarea id="mContnet" class="form-control" rows="5" style="resize: none; overflow: auto;" readonly></textarea><!-- 설명 -->
							  	</div>
							  	<div class="form-group">
							    	<textarea id="joinEmp" class="form-control" rows="5" style="resize: none; overflow: auto;" readonly></textarea><!-- 참가인 -->
							  	</div>
							  	<!-- <div class="form-group">
							  		<textarea class="form-control" rows="5" style="resize: none; overflow: auto;" readonly></textarea>
							  	</div> -->
							  	<div class="buttonArea">
						  		</div>
			                </div>
			                <script type="text/javascript">
			                	$(document).on('click','.updateBtn',function(){
			                		var text = $(this).text();
			                		var id = $("#id").val();
			                		var rStatus = "Y";
			                		var joinEmp = $("#joinEmp_hidden").val();
			                		console.log(joinEmp);
			                		
			                		if(text=="예약 취소"){
			                			if(confirm("'"+$("#mTitle").val()+"'를 정말로 취소하시겠습니까?")){
			                				rStatus="N";
			                				
			                				updateRes(id,rStatus,joinEmp);
			                			}
			                		}else if(text=="불참 신청"){
										if(confirm("'"+$("#mTitle").val()+"'에 정말로 불참하시겠습니까?")){
											joinEmp = joinEmp.substring(0,joinEmp.length-1);
			                				var myEmpno = "${loginEmp.empNo}";
			                				var temp = joinEmp.split(";");
			                				joinEmp="";
			                				for( var i in temp ){
			                					if(!temp[i].includes(myEmpno)){
			                						joinEmp+=temp[i]+";";
			                					}
			                				}
											updateRes(id,rStatus,joinEmp);
			                			}
			                		}
			                	});
			                	
			                	function updateRes(id,rStatus,joinEmp){
			                		$.ajax({
			                			url:"rUpdate.do",
			                			data:{id:id,rStatus:rStatus,joinEmp:joinEmp},
			                			type: "post",
			                			success:function(data){
			                				alert("성공적으로 취소되었습니다.");
			                				location.href="rListView.do";
			                			}
			                		});
			                	}
			                </script>
		            </div>
		       </div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
