<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제이솔루션-JPIA 관리자</title>
</head>
<body>

<% 
	//방문자 관리 부분
	
	//visitor_admin.jsp에서 입력한 정보들을 받음.
	request.setCharacterEncoding("utf-8"); 

	String name = request.getParameter("name");	
	String t_birth = request.getParameter("birth");
	//int birth = Integer.parseInt(t_birth);
	
	String t_phone = request.getParameter("phone");
	int phone = Integer.parseInt(t_phone);
	
	String purpose = request.getParameter("purpose1");
	 
	BoardDAO dao = BoardDAO.getInstance();
	String date = dao.getDate();
	String entrance_time = dao.gettime();
	String createtime = date+" "+entrance_time;
	
	int check = dao.insertVisitor(createtime, name, t_birth, phone, purpose, "Y");
	//받은 정보 이용해 방문자 등록.
	if(check>=1){
		out.println("<script>alert('등록하셨습니다!');location.href='Visitor_admin.jsp';</script>");
	}else{
		out.println("<script>alert('등록에 실파하셨습니다.!');location.href='Visitor_admin.jsp';</script>");
	}

%>

</body>
</html>