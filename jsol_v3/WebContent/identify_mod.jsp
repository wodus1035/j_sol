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

Member bd = dao.getMember(phone,c_type);

if(bd.getName() == null){
	out.println("<script> alert('등록되지 않은 방문자입니다.'); window.close();</script>");
}


String name = bd.getName();
String purpose = null;

if(c_type.equals("A")){
	purpose = bd.getPurposeA();
}else if(c_type.equals("B")){
	purpose = bd.getPurposeB();
}else if(c_type.equals("C")){
	purpose = bd.getPurposeC();
}else if(c_type.equals("D")){
	purpose = bd.getPurposeD();
}else{
	purpose = bd.getPurpose();	
}

String createtime = bd.getCreatetime();
String cometime = dao.getDate()+" " +dao.gettime();
String is_sign = bd.getIs_sign();
birth = bd.getBirth();
if(session.getAttribute("c_number") != null)
	company_id = Integer.parseInt(session.getAttribute("c_number").toString());

if(dao.dupcheck(phone, cometime)){
	dao.insertVisitor_info(createtime, name, birth, phone, purpose, is_sign, company_id,cometime);
	out.println("<script>opener.location.reload(); window.close();</script>");
}else{
	out.println("<script>alert('5초 내에 중복입력되었습니다.'); window.close();</script>");
}
%>