<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.company" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보삭제</title>
</head>
<body>
<%
int number = Integer.parseInt(request.getParameter("number"));
BoardDAO dao = BoardDAO.getInstance();
int check = dao.now_del(number);

if(check>=1){
	out.println("<script>alert('삭제하셨습니다.!');location.href='Visitor_now.jsp';</script>");	
}
else
{
	out.println("<script>alert('삭제에 실패하셧습니다!');location.href='Visitor_now.jsp';</script>");
}



%>

</body>
</html>