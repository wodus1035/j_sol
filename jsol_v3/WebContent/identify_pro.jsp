<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<!DOCTYPE html>

<html>
<head>
<% request.setCharacterEncoding("UTF-8"); %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//방문자 체크 부분에서 등록을 눌렀을 때 실행됨.
	
	//방문자 체크에서 작성한 정보들 받아옴.
	String temperature_t = request.getParameter("temperature1") +"."+request.getParameter("temperature2");
	float temperature = Float.parseFloat(temperature_t);
	String travel = request.getParameter("ips_check_flag");
	String other_hospital = request.getParameter("admission_check_flag");
	String fever_check_flag = request.getParameter("fever_check_flag");
	String name = request.getParameter("name");
	String createtime = request.getParameter("createtime");
	
	BoardDAO dao = BoardDAO.getInstance();
	
	int check = dao.comeVisitor(name, createtime, temperature, travel, other_hospital, fever_check_flag);
	//방문제 체크에서 작성한 정보들을 업데이트 시켜준다.
	if(check>=1){
		out.println("<script>alert('DB 업데이트!');location.href='home.html'</script>");
	}else{
		out.println("<script>alert('DB 업데이트 실패.!');location.href='home.html'</script>");
	}
	
%>

</body>
</html>