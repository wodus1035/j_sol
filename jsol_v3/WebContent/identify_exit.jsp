<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.BoardDAO"%>
<%@ page import="java.io.*" %>
<%@page import="DB_Util.Member"%>
<%

//Decoder d = new Decoder();
//File file = new File(request.getParameter("qrimage"));
//FileInputStream fis = new FileInputStream(file);
//DecoderResult dr = d.decode(fis.);
//out.print(dr.getText());

BoardDAO dao = BoardDAO.getInstance();
String tt = request.getParameter("qrimage");
String params[] = tt.split(",");
if(params.length != 3){
	out.println("<script>opener.location.reload(); window.close();</script>");
	return;
}
int company_id = Integer.parseInt( params[0]);
String birth = params[1];
String phone = params[2];
String c_type = (String)session.getAttribute("c_type");
Member bd = dao.getMember(company_id, birth, phone,c_type);

String name = bd.getName();
String purpose = bd.getPurpose();
String createtime = bd.getCreatetime();
String cometime = dao.getDate()+" " +dao.gettime();
String is_sign = bd.getIs_sign();



int check = dao.exitVisitor_info(name, phone, cometime);
System.out.println(check);
out.println("<script>opener.location.reload(); window.close();</script>");
%>