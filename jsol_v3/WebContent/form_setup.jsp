<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

int c_number =  0;
if(session.getAttribute("c_number") == null){
	c_number = Integer.parseInt( request.getParameter("c_number"));
}else{
	c_number = Integer.parseInt( session.getAttribute("c_number").toString());
}
String c_type = "";
if(session.getAttribute("c_type") == null){
	c_type = request.getParameter("c_type");
}else{
	c_type = (String)session.getAttribute("c_type");
}
String[] hd;
String[][] cont;
int[] cont_c;
if("A".equals(c_type)){
	String[] hdtmp = {"고객","직원","외부업체","배송업체","기타"};
	hd =hdtmp;
	String[][] conttmp = {{"상담", "구매"},
	        {"업무","상담","문의"},
	        {"업무","기타"},
	        {"택배","퀵","기타"}
	       };
	cont = conttmp;
	int[] cont_ctmp = {2,3,2,3,0};
	cont_c = cont_ctmp;
}else if("B".equals(c_type)){
	String[] hdtmp = {"교역자","교인","새신자","기타"};
	hd =hdtmp;
	String[][] conttmp = {{"목사", "강도사", "전도사", "간사", "사모", "직원"},
	        {"성도", "집사", "명예집사", "권사", "명예권사", "은퇴권사", "장립집사", "은퇴장립집사", "장로", "은퇴장로", "청년", "학생", "유아"},
	       };
	cont = conttmp;
	int[] cont_ctmp = {5,13,0,0};
	cont_c = cont_ctmp;
}else if("C".equals(c_type)){
	String[] hdtmp = {"직원","고객","업체","기타"};
	hd =hdtmp;
	String[][] conttmp = {{"업무"},
			{"시설이용"},
			{"택배"}
	       };
	cont = conttmp;
	int[] cont_ctmp = {1,1,1,0};
	cont_c = cont_ctmp;
}else if("D".equals(c_type)){
	String[] hdtmp = {"직원","교육생","학부모","외부업체","기타"};
	hd =hdtmp;
	String[][] conttmp = {{"업무"},
			{"교육"},
			{"상담"},
			{"택배"}
	       };
	cont = conttmp;
	int[] cont_ctmp = {1,1,1,1,0};
	cont_c = cont_ctmp;
}else{
	String[] hdtmp = {"직원","교인","새신자","기타"};
	hd =hdtmp;
	String[][] conttmp = {{"목사", "강도사", "전도사", "간사", "기타직원"},
	        {"장로","안수집사","집사", "권사", "청년", "학생", "유아"},
	       };
	cont = conttmp;
	int[] cont_ctmp = {5,7,0,0};
	cont_c = cont_ctmp;
}

int birth_len = 13;
if("A".equals(c_type) == false){
	birth_len = 6;
}
%>