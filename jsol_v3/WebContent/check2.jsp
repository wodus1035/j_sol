<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.BoardDAO" %>
<%
request.setCharacterEncoding("utf-8");
 //main에서 입력한 이름과 전화번호를 getParameter로 받기
 String name = request.getParameter("name");
 String phone = request.getParameter("phone");
 int company_id = Integer.parseInt( request.getParameter("company_id"));
 String c_name = "";
 if(session.getAttribute("c_name") != null){
		c_name = (String)session.getAttribute("c_name");
	}
String purpose = "";
String createtime = "";
String birth = "";
 //if 구문 : main에서 name이나 phone의 입이 공백일 경우 다시 main으로 돌아가
 if((name.equals("")) || phone.equals("")){
	 out.println("<script>alert('조회결과가 없습니다. 다시 입력주세요');location.href='javascript:history.back()';</script>");
	 
 }
//else 구문 : main에서 입력받은 name과 phone number가 database에 저장된 phone number와 일치한지의 유무 판단. 
 else{  
	 BoardDAO dao = BoardDAO.getInstance();
	 Member m = dao.getMember_by_name(company_id, name, phone);
	 if(m.getBirth() == null){
		 out.println("<script>alert('조회결과가 없습니다. 다시 입력주세요');location.href='javascript:history.back()';</script>");
	 }else{
		 purpose = m.getPurpose();
		 createtime = m.getCreatetime();
		 birth = m.getBirth();
	 }
 }
 String qrcontent = "/!/" + company_id + "," + birth + ","  + phone + "/!@!/";
%>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
	<style>
	body{background:#f0ebf8;}
		.warp_farae{background:#fff;padding:15px;border-collapse: collapse;border-radius: 1em;overflow: hidden;page-break-inside: avoid;margin-top:20px;border: 1px solid #dadce0;text-align:center;}
		.farae{background:#fff;font-size:14px;display:inline-block;width:49%;float:left;margin-bottom:20px;border:0px solid blue;}
		.farae div.comm{padding-top:3px;font-size:11px;}
		.farae div.insf{padding-top:5px;}
		.farae div.insfh{padding-top:5px;width:50%;float:left;}
		.farae div.insfhl{padding-top:5px;width:50%;float:left;}
		.farae div input{height:30px;vertical-align:middle }
		.farae div.insf label{ }
		.btnArea{text-align:center;margin-top:10px;}
		.mvbtn{
			width:80%;
			color:#fff;
			border:none;
			position:relative;
			height:50px;
			font-size:18px;
			cursor:pointer;
			transition:800ms ease all;
			outline:none;
			border-radius: 0.5em;
		}
		.btn1{background:#7d001a;}
		.btn2{background:#00357d;}
		.btn3{background:#a5a5a5;}
		.top_titles{display:inline-block;width:100%;height:50px;border:0px solid red;}
		.top_titles div{float:left;width:50%;}
		.top_titles div:first-child{text-align:left;}
		.top_titles div:last-child{text-align:right;}
		.mid_titles div{text-align:center;}
		.left{text-align:left;}
		.fontred{color:#ff0000;}
		.font11{font-size:14px;}
	</style>
<title>등록</title>
</head>
<body>
<div class="warp_farae" style="background-image:url('img/topbg.png');background-size :100% 100%;">
	<div class="top_titles">
		<div><img src="img/logo_left.png" style="width:50%;" /></div>
		<div><img src="img/logo_right.png" style="width:50%;"  /></div>
	</div>
	<div class="mid_titles">
			</div>
</div><div class="warp_farae">
<img src="qrimage.jsp?src=<%=qrcontent%>" style="width:200px;"></img>	
<div style="margin-bottom:20px;text-align:left;width:60%;border:0px solid red;margin:10px auto;">
	<br> 기관명 : <%=c_name%>
	<p></p>
	<br>방문자(이름) : <%=name %>
	<p></p>
	<br>전화번호 : <%=phone %>
	<p></p>
	<br>방문유형 : <%=purpose %>
	<p></p>
	<br>등록일시 : <%=createtime %>
	<p></p>
					</div>
	<button class="mvbtn btn1 gotois" onclick="location.href='main.jsp?c_number=<%= company_id%>&c_type=<%=request.getParameter("c_type")%>'">돌아가기</button>
	<div style="margin:20px;">
		<a href="img/info.png" target="_blank"><img src="img/info_btt.png" style="width:100%;"/></a>
	</div>
	<div style="margin:20px;">
		<a href="http://ncov.mohw.go.kr/baroView4.do?brdId=4&brdGubun=44" target="_blank"><img src="img/co.png" style="width:100%;"/></a>
	</div>
	
	<div class="font11">위 출입 QR코드를 출입 확인 장비에 스캔하시면 출입이 가능합니다.(사전 준비)</div>
	<div class="font11 fontred">본인 QR출입증이 아닌 출입은 법적책임을 질 수 있습니다.</div>
</div>
<div class="warp_farae">
Copyright (C) J-SOLUTION
</div>
</body>
</html>