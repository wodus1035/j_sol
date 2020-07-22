<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<% request.setCharacterEncoding("UTF-8"); %>

<meta charset="UTF-8">
<title>제이솔루션-JPIA 관리자</title>

<script type="text/javascript">

	function checkValue()
	{
		inputForm = eval("document.loginform")
		if(!inputForm.username.value)
			{
				alert("아이디를 입력하세요");
				inputForm.username.focus();
				return false;
			}
		if(!inputForm.password.value)
			{
				alert("비밀번호를 입력하세요");
				inputForm.paswword.focus();
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
<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5">

							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
								<div class="card-body">
									<form id="loginForm" name="loginForm" method="post" action="LoginPro.jsp" onsubmit="return checkValue()">
										<input type="hidden" id="procMode" name="procMode" value=""/>
										<div class="form-group"><label class="small mb-1" for="username">아이디</label><input class="form-control py-4" id="username" name="username" type="text" placeholder="아이디를 입력해 주십시요." /></div>
										<div class="form-group"><label class="small mb-1" for="password">비밀번호</label><input class="form-control py-4" id="password" name="password" type="password" placeholder="비밀번호를 입력해 주십시요."/></div>
										<div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0 text-align-center">
											<button class="btn btn-primary click-login">Login</button>
										</div>
									</form>
								</div>
								<div class="card-footer text-center">
									<div class="small">Copyright @ j-sol</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; J-SOLUTION</div>
						<div>
							<a href="#">Privacy Policy</a>
							&middot;
							<a href="#">Terms &amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>


</body>
</html>