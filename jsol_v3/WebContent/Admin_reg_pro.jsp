<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "DB_Util.Board"%>
<%@ page import = "DB_Util.BoardDAO"%>
<%@ page import = "DB_Util.DB_connection" %>
<html>
<head>
<title>등록</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	//enroll.html에서 입력받은 데이터들을 getparameter로 받음
	String c_name = request.getParameter("c_name");
 	String c_pw = request.getParameter("c_pw");
	String c_type = request.getParameter("c_type"); 
	String c_id = request.getParameter("c_id");
	BoardDAO dao = BoardDAO.getInstance();
	String date = dao.getDate();
	String time = dao.gettime();
	String createtime = date+" "+time;
	
	int check = dao.insertAdmin(c_name, c_id, c_pw, c_type, createtime);
	if(check >= 1){
		out.println("<script>alert('등록하셨습니다!'); location.href='Visitor_admin.jsp';</script>");
	}
	else{
		out.println("<script>alert('등록에 실패하셨습니다.'); location.href='Admin_reg.jsp'; </script>");
		
	}
%>
</body>
</html>