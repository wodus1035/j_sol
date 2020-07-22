<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.MemberDAO"%>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="DB_Util.Member" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="DB_Util.company" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<% request.setCharacterEncoding("UTF-8"); %>

<title>제이솔루션-JPIA 관리자</title>
</head>
<body>
	<%
		//관리자의 로그인 확인 부
		String id = request.getParameter("username");
		String pw = request.getParameter("password");
		
		MemberDAO dao = MemberDAO.getInstance();
		BoardDAO b_dao = BoardDAO.getInstance();
		int check = dao.loginCheck(id, pw);
		int c_number = 0;
		String company_name = null;
		String company_type = null;
		
		
		if(check==1){
			ArrayList<company> c_list = b_dao.get_company_info(id, pw);
			if(c_list.size() > 0){
				c_number = c_list.get(0).getCompany_number();
				company_name = c_list.get(0).getCompany_name();
				company_type = c_list.get(0).getCompany_type();
				
			}
			session.setAttribute("c_name",company_name);
			session.setAttribute("c_type",company_type);
			session.setAttribute("c_number",c_number);
			
			out.println("<script>alert('로그인하셨습니다!');location.href='Visitor_check.jsp'</script>");
		}
		else if(check==0)
		{
			out.println("<script>alert('비밀번호가 틀렸습니다!');location.href='login.jsp';</script>");
		}
		else
		{
			out.println("<script>alert('아이디가 틀렸습니다!');location.href='login.jsp';</script>");
		}	
	%>

</body>
</html>