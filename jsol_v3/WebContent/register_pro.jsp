<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import = "DB_Util.Board"%>
<%@ page import = "DB_Util.BoardDAO"%>
<%@ page import = "DB_Util.DB_connection" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.DateFormat" %>

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
<%
	request.setCharacterEncoding("utf-8");


	//enroll.html에서 입력받은 데이터들을 getparameter로 받음
	String name = request.getParameter("name");
 	String birth = request.getParameter("birth");
	String phone = request.getParameter("phone"); 
	String purpose = request.getParameter("purpose1") + "(" + request.getParameter("purpose2") + ")";  
	String is_sign = request.getParameter("is_sign");
	String c_number = request.getParameter("c_number");
	String c_type = request.getParameter("c_type");
	int company_id = Integer.parseInt(c_number);
	
	String purposeA = null;
	String purposeB = null;
	String purposeC = null;
	String purposeD = null;
	
	
	
	BoardDAO dao = BoardDAO.getInstance();
	String date = dao.getDate();
	String time = dao.gettime();
	String createtime = date+" "+time;
	String c_name = dao.getCompany_name(company_id);
	
	
	//////////////////////////////////////
	date = date.replaceAll("-", "");
	date = date + "0001";
	long max_number = dao.getM_number();
	long m_number = Long.parseLong(date);
	//System.out.println("max_number:  " + max_number + "m_number:  "+ m_number);
	if(m_number <= max_number){
		m_number = max_number+1;
	}
	
	//System.out.println("m_number:  " + m_number);
	
	
	///////////////////////////////////////
	String qrcontent = "/!/" + company_id + "," + birth + ","  + phone + "/!@!/";
	
	
	
	int check = dao.signup(createtime, name, birth, phone, purpose, is_sign,company_id,m_number,c_type);
	
	if(check >= 1){
		out.println("<script>alert('등록하셨습니다!'); </script>");
	}
	else{
		out.println("<script>alert('등록에 실패하셨습니다.'); history.back(); </script>");
		
	}
%>
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
	<button class="mvbtn btn1 gotois" onclick="location.href='main.jsp?c_number=<%= request.getParameter("c_number")%>&c_type=<%=request.getParameter("c_type")%>'">돌아가기</button>
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