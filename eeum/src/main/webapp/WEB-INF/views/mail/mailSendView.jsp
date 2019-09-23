<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>GroupWare</title>
  <!-- Custom fonts for this template-->
  <link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Bootstrap core JavaScript-->
  <script src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
  <script src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>

  <!-- Custom styles for this template-->
  <link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/fbd170e696.js"></script>
  <style>
    .pagination {
      display: inline-block;
      margin-left: auto;
      margin-right: auto;
    }

    .pagination a {
      color: black;
      float: left;
      padding: 8px 16px;
      text-decoration: none;
      transition: background-color .3s;
      border: 1px solid #ddd;
    }

    .pagination a.active {
      background-color: rgb(2, 1, 13);
      color: white;
      border: 1px solid rgb(2, 1, 13);
    }

    .pagination a:hover:not(.active) {
      background-color: #DCDCDC;
    }


    a:link {
      color: gray;
      text-decoration: none;
    }

    a:visited {
      color: gray;
      text-decoration: none;
    }

    a:hover {
      color: gray;
      text-decoration: none;
    }

    #buttons button {
      margin: 2em;
      display: inline-block;
      margin-left: auto;
      margin-right: auto;
    }

    #buttons {
      display: inline-block;
      margin-left: auto;
      margin-right: auto;
      text-align: center;
    }
    
    .bgClass{
	background: rgb(245,245,245);
    }
    
    tbody tr:hover{
    background:rgba(150,210,255,0.1);
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
        <h1 class="h3 mb-0 text-gray-800">메일함</h1>
      </div>
      <!--본문  -->
      <div class="row">
        <div class="col-lg-5 ">
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">
              	보낸 메일함
              </h6>
            </div>
            <div class="card-body">
              <div style="margin-bottom: 1em;">
                <form action="mailSendView.do" autocomplete="off" style="display: inline-block; width:50%;">
                  <input type="search" name="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable" style="display: inline-block; width: 50%">
                  <input type="submit" class="btn" value="검색" style="border: 1px solid lightgray">
                  <input type="hidden" name="cate" value="${cate}">
                  <input type="hidden" name="eStatus" value="${eStatus}">
                  <c:set var="search" value="${search}" />
                  <c:if test="${!empty search}">
                    <p>"${search}"에 대한 검색결과 입니다.</p>
                  </c:if>
                </form>
                <div style="display: inline-block; width:40%; float: right;">
                  <select id="selectbox" name="dataTable_length" name="cate" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm" style="width:40%; float: right;">
                    <option value="Desc">옛날 순</option>
                    <option value="ASC">최신 순</option>
                    <option value="unRead">안읽은 메일만 보기</option>
                  </select>
                  <script type="text/javascript">
                    $(document).ready(function() {
                      var cate = "${cate}";
                      $("#selectbox").val(cate).prop("selected", true);
                    });

                    $("#selectbox").change(function() {
                      var cate = $("#selectbox option:selected").val();
                      var search = "${search}";
                      var page = "${page}";
                      var eStatus = "${eStatus}";

                      window.location.href = "mailReceive.do?search=" + search + "&page=" + page + "&cate=" + cate + "&eStatus=" + eStatus;
                    });
                  </script>
                </div>
              </div>
              <div class="table-responsive" style="clear: both;">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align: center;">
                  <thead>
                    <tr>
                      <th>수신인</th>
                      <th>제목</th>
                      <th>발신일</th>
                      <th>수신확인</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>수신인</th>
                      <th>제목</th>
                      <th>발신일</th>
                      <th>수신확인</th>
                    </tr>
                  </tfoot>
                  <tbody>
                    <c:forEach var="m" items="${mail}">
                      <c:url var="mail" value="mailinsertView.do">
                        <c:param name="empNo" value="${m.recieveEmp}"/>
                      </c:url>
                      <tr>
                        <td><a href="${mail}">${m.recieveEmpName}</a></td>
                        <td>
                          <input type="hidden" class="mailNo" value="${m.mailNo}">
                          <input type="hidden" class="empName" value="${m.empName}"><!--보낸사람  -->
                          <input type="hidden" class="empNo" value="${m.empNo}">
                          <input type="hidden" class="eTitle" value="${m.eTitle}">
                          <input type="hidden" class="eContent" value='"${m.eContent}"'>
                          <input type="hidden" id="eRTime" class="eRTime" value="${m.eRTime}">
                          <input type="hidden" class="sendTime" value="${m.sendTime}">
                          <a class="mailDeatil" style="cursor: pointer;">${m.eTitle}</a>
                        </td>
                        <td>${m.sendTime}</td>
                        <td>
							<c:if test="${empty m.eRTime}">
								읽지않음
							</c:if>
							<c:if test="${!empty m.eRTime}">
								읽음
							</c:if>
						</td>
                      </tr>
                    </c:forEach>
                    	<c:if test="${empty mail}">
                    	<tr>
                    		<td colspan="4">아직 메일이 없네요!</td>
                    	</tr>
                    	</c:if>
                  </tbody>
                </table>
                <!--메일쓰기 버튼  -->
                <a href="mailinsertView.do" class="btn btn-primary btn-icon-split">
                  <span class="icon text-white-50">
                    <i class="fas fa-check"></i>
                  </span>
                  <span class="text" style="color: white">메일 작성</span>
                </a>
                <!-- 페이지 영역  -->
                <div class="row" style="width: 90%; margin-left: 5%;">
                  <div class="pagination">
                    <!--이전  -->
                    <c:if test="${pi.currentPage <= 1}">
                      <a style="color: lightgray;">&laquo;</a>
                    </c:if>
                    <c:if test="${pi.currentPage > 1}">
                      <c:url var="before" value="mailReceive.do">
                        <c:param name="page" value="${ pi.currentPage - 1 }" />
                        <c:param name="eStatus" value="${eStatus}" />
                        <c:param name="search" value="${search}" />
                        <c:param name="cate" value="${cate}" />
                      </c:url>
                      <a href="${ before }">&laquo;</a>
                    </c:if>

                    <!--페이징  -->
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                      <c:if test="${ p eq pi.currentPage }">
                        <a class="active">${ p }</a>
                      </c:if>

                      <c:if test="${ p ne pi.currentPage }">
                        <c:url var="pagination" value="mailReceive.do">
                          <c:param name="page" value="${ p }" />
                          <c:param name="eStatus" value="${eStatus}" />
                          <c:param name="search" value="${search}" />
                          <c:param name="cate" value="${cate}" />
                        </c:url>
                        <a href="${ pagination }">${ p }</a> &nbsp;
                      </c:if>
                    </c:forEach>

                    <!-- 다음 -->
                    <c:if test="${ pi.currentPage >= pi.maxPage }">
                      <a style="color: lightgray;">&raquo;</a>
                    </c:if>
                    <c:if test="${ pi.currentPage < pi.maxPage }">
                      <c:url var="after" value="mailReceive.do">
                        <c:param name="page" value="${ pi.currentPage + 1 }" />
                        <c:param name="eStatus" value="${eStatus}" />
                        <c:param name="search" value="${search}" />
                        <c:param name="cate" value="${cate }" />
                      </c:url>
                      <a href="${ after }">&raquo;</a>
                    </c:if>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>
        <!-- 받은 메일함 끝  -->
        <script type="text/javascript">
			$(".mailDeatil").click(function(){
				$("tr").removeClass("bgClass");
				$(this).closest("tr").addClass("bgClass");
				
				var mailNo = $(this).siblings(".mailNo").val();
				var empName = $(this).siblings(".empName").val();
				var eTitle = $(this).siblings(".eTitle").val();
				var eContent = $(this).siblings(".eContent").val();
				var sendTime = $(this).siblings(".sendTime").val();
				var eRTime = $(this).siblings(".eRTime").val();
				var empNo = $(this).siblings(".empNo").val();
				eContent = eContent.substring(1,eContent.length-1);
				 $("#replybtn").show();
  				 $("#empNo").val(empNo);
				 $("#eTitle").text(eTitle);
				 $("#empName").text(empName);
				 $("#sendTime").text(sendTime);
				 $("#eContent").html(eContent);
				 
			});
        </script>
        <!-- 메일 영역 -->
        <div class="col-lg-7 card shadow mb-4 col-md-8 card-body">
          <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary"><span id="eTitle"></span></h6>

            <!--수정  -->
            <div class="dropdown no-arrow">
              <span id="empName"></span>
              <span id="sendTime"></span>
            </div>


          </div>
          <!-- 메일 본문 -->
          <div class="card-body" id="eContent" style="padding : 5rem;">
          </div>
          <div id="buttons">
			 <input type="hidden" id="empNo">
			 <script type="text/javascript">
			 
			 	function replyFun(){
			 		var empNo = $("#empNo").val();
			 		window.location.href="mailinsertView.do?empNo="+empNo;
			 	}
			 </script>
		  </div>
        </div>

      </div>
    </div>


  </div>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
	<script type="text/javascript">
		$('#email').trigger('click');
	</script>
</body>

</html>