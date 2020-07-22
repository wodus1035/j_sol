<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

	String temperature_t = request.getParameter("temperature1") + "."+ request.getParameter("temperature2");
	Float temperature = Float.parseFloat(temperature_t);
	
	
	System.out.println(temperature);
	String ips_check_flag = request.getParameter("ips_check_flag");
	String other_hospital = request.getParameter("admission_check_flag");
	String fever_check_flag = request.getParameter("fever_check_flag");
	String accept = request.getParameter("is_sign");
	String etc = request.getParameter("etc");
	
	String number_t = request.getParameter("list_id");
	int number = Integer.parseInt(number_t);
	System.out.println(number);
	BoardDAO dao = BoardDAO.getInstance();
	
	int check = dao.updateVisitor(number, temperature, ips_check_flag, other_hospital, fever_check_flag, accept, etc);
	//방문제 체크에서 작성한 정보들을 업데이트 시켜준다.
	if(check>=1){
		out.println("<script>alert('등록하셨습니다!');location.href='Visitor_check.jsp'</script>");
	}else{
		out.println("<script>alert('등록에 실패하셨습니다.!');location.href='Visitor_check.jsp'</script>");
	}
	
%>

</body>
</html>