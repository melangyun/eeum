<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title></title>
</head>
<body>
   <!-- 사이드바 -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fa fa-paper-plane-o"></i>
        </div>
        <div class="sidebar-brand-text mx-3">E-Eum<sup>sys</sup></div>
      </a>
	
		
      <!-- Divider -->
      <hr class="sidebar-divider my-0">
	
      <!-- 홈 -->
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">
          <i class="fas fa-fw fa-home"></i>
          <span>Home</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        Common
      </div>

      <!-- 조직도 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="organization.do" >
          <i class="fas fa-fw fa fa-sitemap"></i>
          <span>조직도</span>
        </a>
      </li>

      <!-- 공지사항 -->
     <li class="nav-item">
        <a class="nav-link collapsed" href="notice.do" >
          <i class="as fa-fw fa fa-bullhorn"></i>
          <span>공지사항</span>
        </a>
      </li>
      
      <!-- 교육  -->
<!--       <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEdu" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa fa-laptop"></i>
          <span>교육</span>
        </a>
        <div id="collapseEdu" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Custom Notice:</h6>
            <a class="collapse-item" href="utilities-color.html">Colors</a>
            <a class="collapse-item" href="utilities-border.html">Borders</a>
            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a>
          </div>
        </div>
      </li>
       -->
       <!-- 회의실  -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#Room" aria-expanded="true" aria-controls="collapseUtilities" id="recoM">
          <i class="fas fa-fw fa fa-coffee"></i>
          <span>회의실</span>
        </a>
        <div id="Room" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <a class="collapse-item" href="rInsertView.do">회의실 예약</a>
            <a class="collapse-item" href="rListView.do">예약 내역</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">
	
	
	<!-- 개인메뉴  -->
      <!-- Heading -->
      <div class="sidebar-heading">
        Personal
      </div>
	
	<!--전자 결재 fa-file-text-o  -->
      <li class="nav-item">
        <a class="nav-link" href="approvalView.do">
          <i class="fas fa-fw fa fa-file-text-o "></i>
          <span>전자결재</span></a>
      </li>
	
      <!-- 이메일 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages" id="email">
          <i class="fas fa-fw fa fa-envelope-o"></i>
          <span>이메일</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">메일 작성</h6>
            <a class="collapse-item" href="mailinsertView.do">메일 보내기</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">메일함</h6>
            <a class="collapse-item" href="mailReceive.do?eStatus=N">받은 메일함</a>
            <a class="collapse-item" href="mailSendView.do?eStatus=N">보낸 메일함</a>
            <a class="collapse-item" href="mailReceive.do?eStatus=B">보관함</a>
            <a class="collapse-item" href="mailReceive.do?eStatus=M">내게 쓴 메일함</a>
        	</div>
        </div>
      </li>


      <!-- 일정 -->
      <li class="nav-item">
        <a class="nav-link" href="calPage.do">
          <i class="fas fa-fw fa fa-calendar"></i>
          <span>일정</span></a>
      </li>
		
	     <!-- to-do -->
      <li class="nav-item">
        <a class="nav-link" href="todoView.do">
          <i class="fas fa-fw fa fa-list-alt"></i>
          <span>to-do</span></a>
      </li>
	
	<c:if test="${loginEmp.empStatus eq 'A' }">
   	<!-- 관리자 영역 -->
      <hr class="sidebar-divider d-none d-md-block">
      
     <!-- Heading -->
      <div class="sidebar-heading">
        Management
      </div>
      
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#humanR" aria-expanded="true" aria-controls="collapsePages" id="human">
          <i class="fas fa-fw fa fa-users"></i>
          <span>인사관리</span>
        </a>
        <div id="humanR" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Personnel management</h6>
            <a class="collapse-item" href="newEmp.do">신규 등록</a>
            <a class="collapse-item" href="manageEmp.do">사원 관리</a>
        </div>
      </li>
      </c:if>
		
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">


    </ul>
    <!-- End of Sidebar -->

</body>
</html>