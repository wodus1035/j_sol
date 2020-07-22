<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.BoardDAO" %>
<script src="http://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<%
request.setCharacterEncoding("utf-8");
 //main에서 입력한 이름과 전화번호를 getParameter로 받기
 String name = request.getParameter("name");
 String phone = request.getParameter("phone");
 String c_name;
 long m_number;
 int company_id = Integer.parseInt( request.getParameter("company_id"));
	String purpose = "";
	String createtime = "";
 //if 구문 : main에서 name이나 phone의 입이 공백일 경우 다시 main으로 돌아가
 if((name.equals("")) || phone.equals("")){
	 out.println("<script>alert('조회결과가 없습니다1. 다시 입력주세요');location.href='javascript:history.back()';</script>");
	 
 }
//else 구문 : main에서 입력받은 name과 phone number가 database에 저장된 phone number와 일치한지의 유무 판단. 
 else{  
	 BoardDAO dao = BoardDAO.getInstance();
	 Member m = dao.getMember_by_name(company_id, name, phone);
	 c_name = dao.getCompany_name(company_id);
	 if(m.getBirth() == null){
		 out.println("<script>alert('조회결과가 없습니다. 다시 입력주세요');location.href='javascript:history.back()';</script>");
	 }else{
		 purpose = m.getPurpose();
		 createtime = m.getCreatetime();
		 m_number = m.getM_number();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
/*  html2canvas 라이브러리를 사용해서 출입증을 이미지 파일로 저장  */
function printqr(){
	<%-- url = "Member_print_all.jsp?selected="+"<%=company_id + "," +m.getBirth()+","+m.getPhone() + "#"%>";
	window.open(url, "", "width=1000, height=700, left=500, top=50"); --%>
	//window.print();
	$("#btts").toggle();
	html2canvas(document.querySelector("#capture")).then(canvas => {
	    //document.body.appendChild(canvas);
	    var myImage = canvas.toDataURL();
	    var link = document.createElement("a");
	    link.download = "<%=c_name%> 출입증 - <%=name%>";
	    link.href = myImage;
	    document.body.appendChild(link);
	    link.click();
	    window.close();
	});
	
	//$("#btts").toggle();
}
</script>
<style>
body{background:white;}
		.warp_farae{background:#fff;padding:10px;border-collapse: collapse;border-radius: 1em;overflow: hidden;page-break-inside: avoid;margin-top:20px;border: 1px solid #dadce0;text-align:center;max-width:1200px;
		margin:20px auto 0 auto;
		}
		.warp_farae2{margin-top:20px;margin:20px auto 0 auto;text-align:center;}
		.farae{background:#fff;font-size:14px;display:inline-block;margin-bottom:20px;border:0px solid blue;width:100%;text-align:left;}
		.farae div.comm{padding-top:3px;font-size:11px;}
		.farae div.insf{padding:15px 0;}
		.farae div.insfh{padding-top:5px;width:50%;float:left;}
		.farae div.insfhl{padding-top:5px;width:50%;float:left;}
		.farae div input{height:40px;vertical-align:middle;padding:0 0 0 5px;font-size:17px;font-weight:600; }
		.farae div select{height:30px;vertical-align:middle }
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
		.ins_title{background:#2E9AFE;color:#fff;border-radius: 10px;padding:10px;margin-bottom:20px;}
		.box-radio-input input[type="radio"]{
			display:none;
		}

		.box-radio-input input[type="radio"] + span{
			display:inline-block;
			background:none;
			border:1px solid #dfdfdf;
			padding:0px 10px;
			text-align:center;
			height:35px;
			line-height:33px;
			font-weight:500;
			cursor:pointer;
		}

		.box-radio-input input[type="radio"]:checked + span{
			border:1px solid #23a3a7;
			background:#23a3a7;
			color:#fff;
		}
</style>
<title>:::비접촉 출입관리 솔루션:::</title>
</head>
<body>
<div style="text-align:center;" id="capture">
<h4><%=c_name %> 출입증</h4>
<img src="qrimage.jsp?src=<%= "/!/" + company_id + "," +m.getBirth()+","+m.getPhone()+"/!@!/"%>" style="width:150px;"></img>
		<div style="text-align:left; font-size:small;">
		<p>방문자(이름) : <%=name %></p>
	    <p>전화번호 : <%=phone %></p>
	    <p>방문유형 : <%=purpose %></p>
	    <p>등록번호 : <%=m_number %></p>
	    <div id="btts">
	    <button id="printbtt" onclick="printqr()">인쇄하기</button>
	    <button id="printbtt" onclick="script:window.close();">닫기</button>
	    </div>
	    </div>
<%
	 }
 	
 }
%>

</body>
</html>