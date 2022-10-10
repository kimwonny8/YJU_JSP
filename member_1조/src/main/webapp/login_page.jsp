<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
	if (session.isNew()) {
		session.setAttribute("loginState", "logout");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
	}
	%>
	<div class="container">
		<h2>로그인</h2>
		<hr>


		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card text-center card  bg-default mb-3">
					<div class="card-header">로그인</div>
					<form name="login" method="post"
						action="/member_1조/mem_models/member_dao.jsp">
						<div class="card-body">
							<input type="text" name="userid"
								class="form-control input-sm chat-input" placeholder="Username" />
							<br> <input type="password" name="passwd"
								class="form-control input-sm chat-input" placeholder="Password" />
						</div>
						<div class="card-footer text-muted">
							<input type="hidden" name="actionType" class="btn btn-secondary"
								value="LOGIN"> <input type="submit" value="로그인">
							<a href="./signup_page.jsp" class="btn btn-secondary">회원가입</a>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

</body>
</html>