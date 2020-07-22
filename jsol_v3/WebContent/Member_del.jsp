<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.company" %>
<meta charset="UTF-8">
<%
String[] selectedcell = request.getParameterValues("selected");
if(request.getParameter("selected") != null){

	BoardDAO dao = BoardDAO.getInstance();
	int check = dao.Member_del(selectedcell);
	
	if(check>=1){
		for(int i = 0; i < request.getParameterValues("selected").length; i ++){
			application.log("회원 삭제 : " + selectedcell[i]);
		}
		out.println("<script>alert('삭제하셨습니다.!');opener.location.reload(); window.close();</script>");	
	}
	else
	{
		out.println("<script>alert('삭제에 실패하셧습니다!');opener.location.reload(); window.close();</script>");
	}
}else{
	out.println("<script>alert('삭제에 실패하셧습니다!');opener.location.reload(); window.close();</script>");
}


%>
