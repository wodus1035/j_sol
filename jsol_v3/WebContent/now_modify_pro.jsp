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
String name = request.getParameter("name_hidden");
String phone = request.getParameter("phone_hidden");
Float temperature = Float.parseFloat(request.getParameter("temperature"));
String purpose1 = request.getParameter("purpose1");
String purpose2 = request.getParameter("purpose2");



String purpose = purpose1 + "(" + purpose2 + ")";
String ips_check_flag = request.getParameter("ips_check_flag");
String fever_check_flag = request.getParameter("fever_check_flag");
String admission_check_flag = request.getParameter("admission_check_flag");
int check = dao.now_modify(number, purpose, temperature, ips_check_flag, admission_check_flag, fever_check_flag,name, phone);

if(check>=1){
	application.log("방문자 정보 수정(방문자식별자 : " + number + ") -- 수정전 정보\n" + "이름 : " + name + "\n전화번호 : " + phone +"\n체온 : " + temperature  + "\n방문유형 : " + purpose + "\n해외여행여부 : " + ips_check_flag + "\n증상여부 : " +fever_check_flag + "\n타병원 입원 여부 : " + admission_check_flag);
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