<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.company" %>
<!DOCTYPE html>
<html>
<head>
	<link type="text/css" href="resources/framework/sbAdmin/dist/css/styles.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/jQuery/ui-bootstrap/css/custom-theme/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
        <link type="text/css" href="resources/framework/jQuery/ui-bootstrap/assets/css/docs.css" rel="stylesheet"/>
        <link type="text/css" href="resources/framework/jQuery/ui-bootstrap/assets/js/google-code-prettify/prettify.css" rel="stylesheet"/>
		<link type="text/css" href="resources/css/manager_custom_css.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/g2minTemplate/css/site-function.css" rel="stylesheet" />
<% 

request.setCharacterEncoding("UTF-8");
int c_number=0;

if(session.getAttribute("c_type") == null || session.getAttribute("c_name") == null){
	out.println("<script>alert('로그인이 필요합니다!');location.href='login.jsp';</script>");
}else{
	c_number = (int)session.getAttribute("c_number");

}


String c_id = request.getParameter("c_id");

BoardDAO dao = BoardDAO.getInstance();
company comp = dao.get_company_info(c_id);
String c_name = comp.getCompany_name();
String c_type = comp.getCompany_type();
String c_pw = comp.getCompany_pw();

%>

<meta charset="UTF-8">
<title>제이솔루션-JPIA 관리자</title>

<script type="text/javascript">

	function checkValue()
	{
		inputForm = eval("document.regForm")
		if(!inputForm.c_name.value)
			{
				alert("기관명 확인하세요");
				inputForm.name.focus();
				return false;
			}
		if(!inputForm.c_pw.value)
			{
				alert("비밀번호 확인하세요");
				inputForm.phone.focus();
				return false;
			}
	}
</script>

</head>
<style>
.card-header {
  background-color: #6EB5BE;
}
.card-header > h3 {
	color:#FFFFFF;
}
</style>


<body>
<body class="bg-primary login-body">
<div class="card shadow-lg border-0 rounded-lg">
								<div class="card-header"><h3 class="text-center font-weight-light my-4">관리자정보수정</h3></div>
								<div class="card-body">
									<form id="regForm" name="regForm" method="post" action="Company_modify_pro.jsp" onsubmit="return checkValue()">
										<input type="hidden" id="procMode" name="procMode" value=""/>
										<div class="form-group"><label class="small mb-1" for="c_type">업체유형</label>
											<select name="c_type" id="c_type">
												<option value="A" <%if("A".equals(c_type)){ %>selected <%} %>>병원</option>
												<option value="B" <%if("B".equals(c_type)){ %>selected <%} %>>교회</option>
												<option value="C" <%if("C".equals(c_type)){ %>selected <%} %>>오락시설</option>
												<option value="D" <%if("D".equals(c_type)){ %>selected <%} %>>학원</option>
											</select>
										</div>
										
										<div class="form-group"><label class="small mb-1" for="c_id">아이디</label>
											<input type="hidden" name="c_id" value="<%=c_id %>"/>
											<input class="form-control py-4" id="c_id" name="c_id" type="text" value="<%=c_id %>" placeholder="아이디를 입력해 주십시요." disabled/>
										</div>
										<div class="form-group"><label class="small mb-1" for="c_pw">비밀번호</label>
											<input class="form-control py-4" id="c_pw" name="c_pw" type="text" value="<%=c_pw %>" placeholder="비밀번호를 입력해 주십시요."/>
										</div>
										<div class="form-group"><label class="small mb-1" for="c_name">기관명</label>
											<input class="form-control py-4" id="c_name" name="c_name" type="text" value="<%=c_name %>" placeholder="기관명 입력해주세요."/>
										</div>
										<div class="row">
											<div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0 text-align-center">
												<button class="btn btn-primary click-login">수정</button>
											</div>
											<div class = "col"></div>
											<div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0 text-align-center">
												<button class="btn btn-primary click-login" onclick="script:window.close();">취소</button>
											</div>
										</div>
									</form>
								</div>
								<div class="card-footer text-center">
									<div class="small">Copyright @ j-sol</div>
								</div>
							</div>

</body>
</html>