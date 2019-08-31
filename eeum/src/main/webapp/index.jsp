<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">

<head>
  <title>SB Admin 2 - Dashboard</title>
</head>
<body id="page-top">
	<jsp:include page="/WEB-INF/views/home.jsp" flush="false"></jsp:include>
	<!--로그인 상태가 아니라면 로그인 페이지로, 로그인 상태라면 홈페이지로 보내기  -->
</body>

</html>
