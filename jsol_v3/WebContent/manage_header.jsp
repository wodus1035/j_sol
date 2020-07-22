<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

int c_number = 0;
String c_name = null;
String c_type = null;

if(session.getAttribute("c_type") == null || session.getAttribute("c_name") == null){
	out.println("<script>alert('로그인이 필요합니다!');location.href='login.jsp';</script>");
}else{
	c_number = (int)session.getAttribute("c_number");
	c_name = (String)session.getAttribute("c_name");
	c_type = (String)session.getAttribute("c_type");

}

%>


<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>제이솔루션-JPIA 관리자</title>
		<link type="text/css" href="resources/framework/sbAdmin/dist/css/styles.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/jQuery/ui-bootstrap/css/custom-theme/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
        <link type="text/css" href="resources/framework/jQuery/ui-bootstrap/assets/css/docs.css" rel="stylesheet"/>
        <link type="text/css" href="resources/framework/jQuery/ui-bootstrap/assets/js/google-code-prettify/prettify.css" rel="stylesheet"/>
		<link type="text/css" href="resources/css/manager_custom_css.css" rel="stylesheet" />
		<link type="text/css" href="resources/framework/g2minTemplate/css/site-function.css" rel="stylesheet" />
        <script src="resources/framework/fontAwesome/js/all.min.js"></script>
		<script src="resources/framework/jQuery/jquery-3.3.1.min.js"></script>
    </head>
	<body><body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="Visitor_check.jsp">비접촉 출입관리</a><button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button
           
            ><!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group font-text-white">
                    <%=c_name %>관리자님 로그인중
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
					<form id="logoutForm" name="logoutForm" method="post">
						<input type="hidden" id="procMode" name="procMode" value=""/>
					</form>
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item click-logout" href="#">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
														<div class="sb-sidenav-menu-heading">비접촉 출입관리 시스템</div>
							<a class="nav-link" href="Visitor_check.jsp">
								<div class="sb-nav-link-icon">
									<i class="fas fa-tachometer-alt"></i>
								</div>
								방문자 체크
							</a>
							<a class="nav-link" href="Visitor_now.jsp">
								<div class="sb-nav-link-icon">
									<i class="fas fa-tachometer-alt"></i>
								</div>
								방문자 현황
							</a>
							<a class="nav-link" href="Visitor_admin.jsp">
								<div class="sb-nav-link-icon">
									<i class="fas fa-tachometer-alt"></i>
								</div>
								방문자 관리
							</a>
							<%if("M".equals(c_type)){ %>
							<div class="sb-sidenav-menu-heading">업체관리</div>
							<a class="nav-link" href="Admin_manage.jsp">
								<div class="sb-nav-link-icon">
									<i class="fas fa-tachometer-alt"></i>
								</div>
								업체현황
							</a>
							<a class="nav-link" href="Admin_reg.jsp">
								<div class="sb-nav-link-icon">
									<i class="fas fa-tachometer-alt"></i>
								</div>
								업체등록
							</a>
							                        <%} %>
							                        </div>
							                        
                    </div>
                    <div style="text-align:center;">
						<div id="qrbtt" onclick="window.open('main.jsp?c_number=<%=c_number%>&c_type=<%=c_type%>','_blank');">
						<img src="qrimage.jsp?src=http://14.45.108.71:8088/jsol/main.jsp?c_number=<%=c_number%>&c_type=<%=c_type%>" width="100px"></img>
						</div>
						<div>
							방문자 등록 페이지
						</div>
					</div>
                    <%@ include file="qrread.jsp" %>
                    <div class="sb-sidenav-footer">
                        <div class="small">j-solution</div>
                    </div>
                </nav>
            </div>
 <style>
 .copy{
 	color : blue;
 	cursor : pointer;
 }
 </style>
 <script type="text/javascript">
$(document)
.on('click', 'a.click-logout', function() {
	var tform = $("#logoutForm");
	if(confirm("로그아웃을 진행하시겠습니까?")) {
		tform.find("input[name=procMode]").val("");
		tform.find("input[name=procMode]").val("proc_logout");
		tform.attr("action", "logout.jsp");
        tform.submit();
	} 
})
</script>