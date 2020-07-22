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
<%@ include file="manage_header.jsp" %>
<%

request.setCharacterEncoding("UTF-8"); 
BoardDAO dao = BoardDAO.getInstance();

String name = request.getParameter("name");
String phone =request.getParameter("phone");
String purpose1 = request.getParameter("purpose1");
String purpose2 = request.getParameter("purpose2");
String purpose = purpose1 + "(" + purpose2 + ")";
String is_sign = request.getParameter("is_sign");
String birth = request.getParameter("birth");
long m_number = Long.parseLong(request.getParameter("m_number"));

int check = dao.admin_modify(phone, birth, purpose, is_sign, c_number, m_number, name);
if(check>=1){
	application.log("회원정보 수정(회원식별자 : " + m_number + ") — 수정전 정보\n" + "이름 : " + name + "\n전화번호 : " + phone + "\n방문유형 : " + purpose + "\n개인정보동의 : " + is_sign + "\n생년월일 : " + birth);
	out.println("<script>alert('수정 하셨습니다.!');opener.location.reload();window.close();</script>");	
}
else
{
	out.println("<script>alert('수정에 실패하셧습니다!');window.close();</script>");
}
%>

</body>
</html>