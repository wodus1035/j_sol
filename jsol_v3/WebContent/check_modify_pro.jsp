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


int number = Integer.parseInt(request.getParameter("number"));
String name = request.getParameter("name");
String phone = request.getParameter("phone_hidden");
String purpose1 = request.getParameter("purpose1");
String purpose2 = request.getParameter("purpose2");
String purpose = purpose1 + "(" + purpose2 + ")";
String c_type = (String)session.getAttribute("c_type");

int check = dao.check_modify(number, purpose);
System.out.println("check: " + check);
int m_check = dao.check_member_modify(number, purpose,c_type,phone);
System.out.println("m_check: " + m_check);
if(check>=1 && m_check>=1){
	application.log("방문자 정보 수정(방문자식별자 : " + number + ") -- 수정전 정보\n" + "이름 : " + name + "\n전화번호 : " + phone + "\n방문유형 : " + purpose);
	out.println("<script>alert('수정 하셨습니다.!');opener.location.reload();window.close();</script>");	
}
else
{
	out.println("<script>alert('수정에 실패하셧습니다!');window.close();</script>");
}

//System.out.println("deubg:  " +name+" "+phone+" "+" " + temperature+" "+ purpose+" "+ips_check_flag+"  "+number);


%>

</body>
</html>