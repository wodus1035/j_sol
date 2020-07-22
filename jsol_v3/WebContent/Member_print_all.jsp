<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="DB_Util.company" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
body {
margin: 0;
padding: 0;
}
* {
box-sizing: border-box;
-moz-box-sizing: border-box;
}
.page {
width: 21cm;
min-height: 29.7cm;
padding: 2cm;
margin: 0 auto;
background:#eee;
}
.subpage {
border: 2px red solid;
background:#fff;   
height: 257mm;
}

@page {
size: A4;
margin: 0;
}
@media print {
html, body {
width: 210mm;
height: 297mm;
}
.page {
margin: 0;
border: initial;
width: initial;
min-height: initial;
box-shadow: initial;
background: initial;
page-break-after: always;

}

@page {
    size: A4;
    margin: 40px;
}


    @media print {
    html,
    body {
        width: 210mm;
        height: 297mm;
    }
    @-moz-document url-prefix() {}
    .col-sm-1,
    .col-sm-2,
    .col-sm-3,
    .col-sm-4,
    .col-sm-5,
    .col-sm-6,
    .col-sm-7,
    .col-sm-8,
    .col-sm-9,
    .col-sm-10,
    .col-sm-11,
    .col-sm-12,
    .col-md-1,
    .col-md-2,
    .col-md-3,
    .col-md-4,
    .col-md-5,
    .col-md-6,
    .col-md-7,
    .col-md-8,
    .col-md-9,
    .col-md-10,
    .col-md-11,
    .col-smdm-12 {
        float: left;
    }
    .col-sm-12,
    .col-md-12 {
        width: 100%;
    }
    .col-sm-11,
    .col-md-11 {
        width: 91.66666667%;
    }
    .col-sm-10,
    .col-md-10 {
        width: 83.33333333%;
    }
    .col-sm-9,
    .col-md-9 {
        width: 75%;
    }
    .col-sm-8,
    .col-md-8 {
        width: 66.66666667%;
    }
    .col-sm-7,
    .col-md-7 {
        width: 58.33333333%;
    }
    .col-sm-6,
    .col-md-6 {
        width: 50%;
    }
    .col-sm-5,
    .col-md-5 {
        width: 41.66666667%;
    }
    .col-sm-4,
    .col-md-4 {
        width: 33.33333333%;
    }
    .col-sm-3,
    .col-md-3 {
        width: 25%;
    }
    .col-sm-2,
    .col-md-2 {
        width: 16.66666667%;
    }
    .col-sm-1,
    .col-md-1 {
        width: 8.33333333%;
    }
    .col-sm-pull-12 {
        right: 100%;
    }
    .col-sm-pull-11 {
        right: 91.66666667%;
    }
    .col-sm-pull-10 {
        right: 83.33333333%;
    }
    .col-sm-pull-9 {
        right: 75%;
    }
    .col-sm-pull-8 {
        right: 66.66666667%;
    }
    .col-sm-pull-7 {
        right: 58.33333333%;
    }
    .col-sm-pull-6 {
        right: 50%;
    }
    .col-sm-pull-5 {
        right: 41.66666667%;
    }
    .col-sm-pull-4 {
        right: 33.33333333%;
    }
    .col-sm-pull-3 {
        right: 25%;
    }
    .col-sm-pull-2 {
        right: 16.66666667%;
    }
    .col-sm-pull-1 {
        right: 8.33333333%;
    }
    .col-sm-pull-0 {
        right: auto;
    }
    .col-sm-Push-12 {
        left: 100%;
    }
    .col-sm-Push-11 {
        left: 91.66666667%;
    }
    .col-sm-Push-10 {
        left: 83.33333333%;
    }
    .col-sm-Push-9 {
        left: 75%;
    }
    .col-sm-Push-8 {
        left: 66.66666667%;
    }
    .col-sm-Push-7 {
        left: 58.33333333%;
    }
    .col-sm-Push-6 {
        left: 50%;
    }
    .col-sm-Push-5 {
        left: 41.66666667%;
    }
    .col-sm-Push-4 {
        left: 33.33333333%;
    }
    .col-sm-Push-3 {
        left: 25%;
    }
    .col-sm-Push-2 {
        left: 16.66666667%;
    }
    .col-sm-Push-1 {
        left: 8.33333333%;
    }
    .col-sm-Push-0 {
        left: auto;
    }
    .col-sm-offset-12 {
        margin-left: 100%;
    }
    .col-sm-offset-11 {
        margin-left: 91.66666667%;
    }
    .col-sm-offset-10 {
        margin-left: 83.33333333%;
    }
    .col-sm-offset-9 {
        margin-left: 75%;
    }
    .col-sm-offset-8 {
        margin-left: 66.66666667%;
    }
    .col-sm-offset-7 {
        margin-left: 58.33333333%;
    }
    .col-sm-offset-6 {
        margin-left: 50%;
    }
    .col-sm-offset-5 {
        margin-left: 41.66666667%;
    }
    .col-sm-offset-4 {
        margin-left: 33.33333333%;
    }
    .col-sm-offset-3 {
        margin-left: 25%;
    }
    .col-sm-offset-2 {
        margin-left: 16.66666667%;
    }
    .col-sm-offset-1 {
        margin-left: 8.33333333%;
    }
    .col-sm-offset-0 {
        margin-left: 0%;
    }
    .visible-xs {
        display: none !important;
    }
    .hidden-xs {
        display: block !important;
    }
    table.hidden-xs {
        display: table;
    }
    tr.hidden-xs {
        display: table-row !important;
    }
    th.hidden-xs,
    td.hidden-xs {
        display: table-cell !important;
    }
    .hidden-xs.hidden-print {
        display: none !important;
    }
    .hidden-sm {
        display: none !important;
    }
    .visible-sm {
        display: block !important;
    }
    table.visible-sm {
        display: table;
    }
    tr.visible-sm {
        display: table-row !important;
    }
    th.visible-sm,
    td.visible-sm {
        display: table-cell !important;
    }
}
}
</style>
<title>:::비접촉 출입관리 솔루션:::</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String[] selectedcell = request.getParameterValues("selected");
int company_id;
String birth;
String phone;
String purpose;
String createtime;
String name;
String c_name;
long m_number;
BoardDAO dao = BoardDAO.getInstance();
ArrayList<company> companys = null;
companys = dao.getCompanys();
for(int i = 0; i < selectedcell.length; i ++){
	if(i%9 == 0)
		out.println("<div class='page'><div class='subpage'>");
	if(i%3 == 0){
		out.println("<div class='row'>");
	}
	
	
 //main에서 입력한 이름과 전화번호를 getParameter로 받기
 	String[] tt = request.getParameterValues("selected")[i].split(",");
 	company_id = Integer.parseInt( tt[0]);
	birth = tt[1];
	phone = tt[2];
	
	String c_type = (String)session.getAttribute("c_type");
	Member m = dao.getMember(company_id, birth, phone,c_type);
	c_name = dao.getCompany_name(company_id);
	 if(m.getBirth() == null){
		 out.println("<script>alert('조회결과가 없습니다. 다시 입력주세요');location.href='main.html';</script>");
	 }else{
		 purpose = m.getPurpose();
		 createtime = m.getCreatetime();
		 name = m.getName();
		 m_number = m.getM_number();
%>

<div class="col-md-4">
<div style="text-align:center; border-style: solid;">
<h4><%=c_name %> 출입증</h4>
<img src="qrimage.jsp?src=<%= "/!/" + company_id + "," +m.getBirth()+","+m.getPhone()+"/!@!/"%>" style="width:150px;"></img>
		<div style="text-align:left; font-size:small;">
		<p>방문자(이름) : <%=name %></p>
	    <p>전화번호 : <%=phone %></p>
	    <p>방문유형 : <%=purpose %></p>
	    <p>등록번호 : <%=m_number %></p>
	    </div>
	    </div>
	    </div>
<%
	 }
	 if(i%3 == 2){
			out.println("</div><br>");
		}
	 if(i%9 == 8)
		 out.println("</div></div>");
}
%>
</div>

</div>



</body>
</html>
<script>
window.print();
window.onfocus=function(){ window.close();}
</script>