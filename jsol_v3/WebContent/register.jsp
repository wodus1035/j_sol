<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="form_setup.jsp" %>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<script type="text/javascript" src=https://code.jquery.com/jquery-3.5.1.min.js></script>
	<style>
	body{background:#f0ebf8;}
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
<div class="warp_farae" style="background-image:url('http://14.45.108.71/img/topbg.png');background-size :100% 100%;">
	<div class="top_titles">
		<div><img src="http://14.45.108.71/img/logo_left.png" style="width:50%;" /></div>
		<div><img src="http://14.45.108.71/img/logo_right.png" style="width:50%;"  /></div>
	</div>
	<div class="mid_titles">
			</div>
</div>

<form name="fwrite" id="fwrite" action="register_pro.jsp" onsubmit="return check(this);" method="post" autocomplete="off">
<input type="hidden" name="c_number" value="<%=c_number %>"/>
<input type="hidden" name="c_type" value="<%=c_type %>"/>
<div class="warp_farae">
	<div class="ins_title">방문자 정보(Visit Information)</div>
	<div class="insf" style="text-align:left;">
	<%for(int i = 0; i < hd.length; i ++){ %>
		<label class="box-radio-input"><input type="radio"  name="purpose1" value="<%=hd[i] %>" <%if(i == 0){ %>checked<%} %>/> <span><%=hd[i] %></span></label>
	<%} %>
	</div>
	<div class="farae" style="text-align:left;">
		<div class="insf">방문목적</div>
		<div class="selects">

		</div>
	</div>
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
			<%if(cont_c[0] == 0){ %>
				$html=$html+'<input type="text" name="purpose2" placeholder="수기입력(기타)" />';
			<%}else{%>
			$html='<select name="purpose2">';
				<%for(int j = 0; j < cont_c[0]; j ++){ %>
				$html=$html+ '<option value="<%= cont[0][j]%>"> <%=cont[0][j]%> </option>';
				<%}%>
			$html=$html + '</select>';
			<%}%>
			$('.selects').html($html);
			
		});
		
</script>
</div>


<div class="warp_farae">
	<div class="ins_title">인적사항(Human Information)</div>
	<div class="farae">
		<div>이름</div>
		<div class="insf"><input type="text" name="name" placeholder="ex)홍길동" value="" /></div>
	</div>
	<div class="farae">
		<div>전화번호</div>
		<div class="insf"><input type="text" name="phone" id='phone' placeholder="ex)010-0000-0000" value=""maxlength="13" oninput=" numberMaxLength(this);" numberOnly /></div>
	</div>
	<div class="farae">
	<% if("A".equals(c_type)){ %>
		<div>주민번호(13자리)</div>
		<div class="insf"><input type="text" name="birth" placeholder="ex)000000-0000000" value="" maxlength="13" oninput=" numberMaxLength(this);" numberOnly/></div>
	<%}else{ %>
		<div>생년월일(6자리)</div>
		<div class="insf"><input type="text" name="birth" placeholder="ex)000000" value="" maxlength="6" oninput=" numberMaxLength(this);" numberOnly/></div>
	<%} %>
	</div>
	<div class="farae">
		<div>방문을 위한 개인 정보 제공에 동의합니다.</div>
		<div class="insf">
			<label class="box-radio-input"><input type="radio" name="is_sign" value="Y" checked /> <span>동의</span></label>
			<label class="box-radio-input"><input type="radio" name="is_sign" value="N" /> <span>동의안함</span></label>
		</div>
	</div>

</div>
<div class="warp_farae2">
	<input type="submit" value="발급(Issue)" class="mvbtn btn2 fsub">
</div>
</form>
<script type="text/javascript">

$("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}


function check() {
	if($('select[name="purpose2"]').val()==''){
		alert('방문목적을 선택하세요.');
		$('select[name="purpose2"]').focus();
		return false;
	}
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
	if($('input[name="birth"]').val().length != <%=birth_len%>){
		<%if(birth_len == 6){%>
		alert('생년월일은 6자리여야 합니다.');
		<%}else{%>
		alert('주민등록번호는 13자리여야 합니다.');
		<%}%>
		$('input[name="phone"]').focus();
		return false;
	}
	if($('input[name="birth"]').val()==''){
		alert('주민번호를 입력하세요.');
		$('input[name="birth"]').focus();
		return false;
	}
	if($('input[name="is_sign"]:checked').val()=='no'){
		alert('개인정보 제공에 동의하여 주세요.');
		return false;
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
<div class="warp_farae left">
개인정보보호법 제58조 제1항 제3호에 따라 방문객의 이름, 전화번호, 주민등록번호 등은 동법 적용을 받지 아니하고 일시적으로 수집하며, 수집된 개인정보는 처리 목적 달성 시 즉시 파기합니다.<br /><br />

* 개인정보보호법 제58조(적용의 일부 제외)<br />
① 다음 각 호의 어느 하나에 해당하는 개인정보에 관하여는 제3장부터 제7장까지를 적용하지 아니한다.<br />
3. 공중위생 등 공공의 안전과 안녕을 위하여 긴급히 필요한 경우로서 일시적으로 처리되는 개인정보<br />
</div>
<div class="warp_farae">
Copyright (C) J-SOLUTION
</div>
</body>
</html>