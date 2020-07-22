<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

request.setCharacterEncoding("UTF-8"); 
BoardDAO dao = BoardDAO.getInstance();

String c_id = request.getParameter("c_id");
String c_pw =request.getParameter("c_pw");
String c_name = request.getParameter("c_name");
String c_type = request.getParameter("c_type");

int check = dao.company_modify(c_id , c_pw, c_name, c_type);
if(check>=1){
	application.log("관리자 정보 수정(관리자ID : " + c_id + ") -- 수정전 정보\n" + "비밀번호 : " + c_pw + "\n업체명 : " + c_name +"\n타입 : " + c_type);
	out.println("<script>alert('수정 하셨습니다.!');opener.location.reload();window.close();</script>");	
}
else
{
	out.println("<script>alert('수정에 실패하셧습니다!');window.close();</script>");
}
%>

</body>
</html>