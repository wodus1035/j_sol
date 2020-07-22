<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.Member" %>
<%@ include file="form_setup.jsp" %>
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
if(session.getAttribute("c_type") == null || session.getAttribute("c_name") == null){
	out.println("<script>alert('로그인이 필요합니다!');location.href='login.jsp';</script>");
}
request.setCharacterEncoding("UTF-8"); 

int number = Integer.parseInt(request.getParameter("number"));

BoardDAO dao = BoardDAO.getInstance();
ArrayList<Board> now_list = dao.getNow_Visitors(number);
String name = now_list.get(0).getName();
String phone = now_list.get(0).getPhone();
Float temperature = now_list.get(0).getTemperature();
String purpose = now_list.get(0).getCategory();
String purpose1 = "";
String purpose2 = "";
if(purpose.contains("(")){
	purpose1 = purpose.substring(0, purpose.indexOf("("));
	purpose2 = purpose.substring(purpose.indexOf("(") + 1, purpose.indexOf(")"));
}else{
	purpose1 = purpose;
}
	


%>

<meta charset="UTF-8">
<title>제이솔루션-JPIA 관리자</title>

<script type="text/javascript">
	function checkValue()
	{
		if($('input[name="name"]').val()==''){
			alert('이름을 입력하세요.');
			$('input[name="name"]').focus();
			return false;
		}
		if($('input[name="phone"]').val()==''){
			alert('전화번호를 입력하세요.');
			$('input[name="phone"]').focus();
			return false;
		}
		if($('input[name="birth"]').val()==''){
			alert('생년월일을 입력하세요.');
			$('input[name="birth"]').focus();
			return false;
		}
		if($('input[name="purpose1"]').val()==''){
			alert('방문유형을 선택하세요.');
			$('input[name="purpose1"]').focus();
			return false;
		}
		if($('input[name="purpose2"]').val()==''){
			alert('방문목적 선택하세요.');
			$('input[name="purpose2"]').focus();
			return false;
		}
		if($('input[name="accept"]').val()==''){
			alert('개인정부동의 여부를 선택하세요.');
			$('input[name="accept"]').focus();
			return false;
		}
		if($('input[name="temperature"]').val()==''){
			alert('개인정부동의 여부를 선택하세요.');
			$('input[name="accept"]').focus();
			return false;
		}
	}
	
	function numberMaxLength(e){
	    if(e.value.length > e.maxLength){
	        e.value = e.value.slice(0, e.maxLength);
	    }
	}

	var autoHypenPhone = function(str){
	    str = str.replace(/[^0-9]/g, '');
	    var tmp = '';
	    if( str.length < 4){
	        return str;
	    }else if(str.length < 7){
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3);
	        return tmp;
	    }else if(str.length < 11){
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3, 3);
	        tmp += '-';
	        tmp += str.substr(6);
	        return tmp;
	    }else{              
	        tmp += str.substr(0, 3);
	        tmp += '-';
	        tmp += str.substr(3, 4);
	        tmp += '-';
	        tmp += str.substr(7);
	        return tmp;
	    }
	    return str;
	}

	var phoneNum = document.getElementById('phone');

	phoneNum.onkeyup = function(){
	console.log(this.value);
	this.value = autoHypenPhone( this.value ) ;  
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
		$(function(){
			$('body').on('click','input[name="purpose1"]',function(){
				$val=$(this).val();
				$html='';
				<%for(int i = 0; i < hd.length; i++){ %>
					if($val=="<%=hd[i] %>"){
						<%if(cont_c[i] == 0){ %>
							$html=$html+'<input type="text" name="purpose2" placeholder="수기입력(기타)" />';
						<%}else{%>
						$html='<select name="purpose2">';
							<%for(int j = 0; j < cont_c[i]; j ++){ %>
							$html=$html+ '<option value="<%= cont[i][j]%>"> <%=cont[i][j]%> </option>';
							<%}%>
						$html=$html + '</select>';
						<%}%>
					}
				<%} %>
				$('.selects').html($html);
			});
		});
		$(document).ready(function() {
			$html='';
			$val=$("input[name=purpose1]:checked").val();
			<%for(int i = 0; i < hd.length; i++){ %>
					if($val=="<%=hd[i] %>"){
						<%if(cont_c[i] == 0){ %>
							$html=$html+'<input type="text" name="purpose2" placeholder="수기입력(기타)" />';
						<%}else{%>
						$html='<select name="purpose2">';
							<%for(int j = 0; j < cont_c[i]; j ++){ %>
							$html=$html+ '<option value="<%= cont[i][j]%>" <%if(purpose2.equals(cont[i][j])){%>selected<%}%>> <%=cont[i][j]%> </option>';
							<%}%>
						$html=$html + '</select>';
						<%}%>
					}
				<%} %>
			$('.selects').html($html);
			
		});
		
</script>

<body>
<body class="bg-primary login-body">
<div class="card shadow-lg border-0 rounded-lg">
								<div class="card-header"><h3 class="text-center font-weight-light my-4">회원정보수정</h3></div>
								<div class="card-body">
									<form id="now_modify" name="now_modify" method="post" action="now_modify_pro.jsp" onsubmit="return checkValue()">
									<input type="hidden" id="number" name="number" value="<%=number%>">
										<input type="hidden" id="procMode" name="procMode" value=""/>
										<div class="form-group"><label class="small mb-1" for="c_id">이름</label>
											<input class="form-control py-4" id="name" name="name" type="text" value="<%=name%>"/>
										</div>
										<div class="form-group"><label class="small mb-1" for="c_pw">전화번호</label>
											<input class="form-control py-4" id="phone" name="phone" type="text" placeholder="ex)010-0000-0000" 
											maxlength="13" oninput=" numberMaxLength(this);" numberOnly value="<%=phone%>"/>
										</div>
										<div class="form-group"><label class="small mb-1" for="c_name">온도</label>
											<input class="form-control py-4" id="temperature" name="temperature" type="text" value="<%=temperature%>"/>
										</div>
										<div class="insf" style="text-align:left;">
										<%for(int i = 0; i < hd.length; i ++){ %>
											<label class="box-radio-input"><input type="radio"  name="purpose1" value="<%=hd[i] %>" <%if(purpose1.equals(hd[i])){ %>checked<%} %>/> <span><%=hd[i] %></span></label>
										<%} %>
										</div>
										<div class="farae" style="text-align:left;">
											<div class="insf">방문목적</div>
											<div class="selects">
									
											</div>
										</div>
										<div>
										<div class="form-group"><label class="small mb-1" for="c_type">해외여행여부</label>
											<select name="ips_check_flag" id="ips_check_flag" class="g2-form-control col-sm-2 fs12">
												<option value="" <%if("null".equals(now_list.get(0).getTravel())){ %>selected<%} %>></option>
												<option value="Y" <%if("Y".equals(now_list.get(0).getTravel())){ %>selected<%} %>>있음</option>
												<option value="N" <%if("N".equals(now_list.get(0).getTravel())){%>selected<%} %>>없음</option>
											</select>
										</div>
										<div class="form-group"><label class="small mb-1" for="c_type">발열기침증상</label>
											<select name="fever_check_flag" id="fever_check_flag" class="g2-form-control col-sm-2 fs12">
												<option value="" <%if("null".equals(now_list.get(0).getFever_check_flag())){ %>selected<%} %>></option>
												<option value="Y" <%if("Y".equals(now_list.get(0).getFever_check_flag())){ %>selected<%} %>>있음</option>
												<option value="N" <%if("N".equals(now_list.get(0).getFever_check_flag())){%>selected<%} %>>없음</option>
											</select>
										</div>
										<%if("M".equals(session.getAttribute("c_type")) || "A".equals(session.getAttribute("c_type"))){ %>
										<div class="form-group"><label class="small mb-1" for="c_type">타병원입원여부</label>
											<select name="admission_check_flag" id="admission_check_flag" class="g2-form-control col-sm-2 fs12">
												<option value="" <%if("null".equals(now_list.get(0).getOther_hospital())){ %>selected<%} %>></option>
												<option value="Y" <%if("Y".equals(now_list.get(0).getOther_hospital())){ %>selected<%} %>>있음</option>
												<option value="N" <%if("N".equals(now_list.get(0).getOther_hospital())){%>selected<%} %>>없음</option>
											</select>
										</div>
										<%} %>
										</div>
										<div class="row">
										<div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0 text-align-center">
											<button class="btn btn-primary click-login">수정</button>
										</div>
										<div class = "col"></div>
										<div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0 text-align-center">
											<button class="btn btn-primary click-login" onclick="script:window.close(); return false;">취소</button>
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