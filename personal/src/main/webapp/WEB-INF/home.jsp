<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Home</title>
    <!-- Font Awesome -->
	<link
	  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	  rel="stylesheet"
	/>
	<!-- Google Fonts -->
	<link
	  href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
	  rel="stylesheet"
	/>
	<!-- MDB -->
	<link
	  href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css"
	  rel="stylesheet"
	/>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/main.css">
</head>
<body class="vh-100" onload="load()">
	<div class="body h-100">
		<div class="container h-100 text-white">
			<div class="row d-flex align-items-center h-100">
				<div class="col-md-6">
					<h1 class="mb4 opacity-90">Amazing Offer</h1>
					<h5 class="mb4 opacity-80">Lorem ipsum dolor sit amers</h5>
					<p class="mb4 opacity-70">You can't miss this offer, it is one in a lifetime!!! Hurry it will expire soon. Now you get unlimited money for life and you dont have to pay a single penny.</p>
					<a id="light" class="btn btn-light btn-lg" data-ripple-color="#4d7f57" href="#register" role="button">Register</a>
					<a id="dark" class="btn btn-outline-light btn-lg" href="#learn" role="button">Learn more</a>
				</div>
				<div class="col-md-5 offset-md-1 position-relative">
				
					<div id="shape-1" class="position-absolute rounded-circle strong-5-strong"></div>
					
					<div id="shape-2" class="position-absolute strong-5-strong"></div>
				
					<div id="card-custom" class="card shadow-6 rounded-6">
						<div class="card-body p-5"> 
							<h2 class="card-title ls-widest">
								<strong>Premium</strong>
								<span class="fw-light">card</span>
							</h2>
							<div id="footer" class="fw-light ls-widest">
								<img alt="" src="https://ascensus-youtube-projects.mdbgo.io/img/chip.png" class="mb-5" style="width: 50px">
								<h5 class="mb-5">1234 5678 9012 3456</h5>
								<p class="mb-2">John Doe</p>
								<p class="mb-5">12/25</p>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="learn" class="container-1 h-100">
		
	</div>
	
	<div id="register" class="container-2 h-100">
		<div id="shape-3" class="rounded-circle strong-5-strong"></div>
		<div id="shape-4" class="strong-5-strong"></div>
		<div id="register-form" class="form-content text-white shadow-6 rounded-6">
			<form:form id="form-register-content" action="/register" method="post" modelAttribute="newUser">
				
				<input type="hidden" name="_method" value="put"/>
				
				<form:errors path="*" class="error"/>
				
				<div class="form-group row">
				    <form:label path="firstName" class="col-sm-4 col-form-label label mb4 opacity-70">First Name:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="firstName" type="text" class="form-control inputFirstName" placeholder="First Name"/>
				    </div>
				</div>
				
				<div class="form-group row">
				    <form:label path="lastName" class="col-sm-4 col-form-label label mb4 opacity-70">Last Name:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="lastName" type="text" class="form-control inputLastName" placeholder="Last Name"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="email" class="col-sm-4 col-form-label label mb4 opacity-70">Email:</form:label>
				    <div class="col-sm-8">
				      	<form:input id="" type="email" class="form-control inputEmail" placeholder="email" path="email"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="Password" class="col-sm-4 col-form-label label mb4 opacity-70">Password</form:label>
				    <div class="col-sm-8">
				      	<form:input id="" type="password" class="form-control inputPassword" placeholder="Password" path="password"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="confirmPass" class="col-sm-4 col-form-label label mb4 opacity-70">Confirm Password:</form:label>
				    <div class="col-sm-8">
				      	<form:input type="password" class="form-control inputConfirmPassword" placeholder="Confirm Password" path="confirmPass"/>
				    </div>
				</div>
					<a onclick="loginClick()" id="loginLink" class="btn">Already a user?</a>
					<form:button onclick="remember(this)" id="registerButton" type="submit" class="btn btn-outline-light btn-lg">Register</form:button>
			</form:form>
		</div>
		<div id="login-form" class="form-content text-white shadow-6 rounded-6">
			<form:form id="form-login-content" action="/login" method= "post" modelAttribute="loginUser">
				<input type="hidden" name="_method" value="put"/>
				<form:errors path="*" class="error"/>
				<div class="form-group row">
				    <form:label path="email" class="col-sm-4 col-form-label label mb4 opacity-70">Email:</form:label>
				    <div class="col-sm-8">
				      	<form:input type="email" class="form-control inputEmail" path="email" placeholder="Email"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="password" class="col-sm-4 col-form-label label mb4 opacity-70">Password</form:label>
				    <div class="col-sm-8">
				      	<form:input path="password" type="password" class="form-control inputPassword" placeholder="Password"/>
				    </div>
				</div>
					<a onclick="regClick()" id="register-link" class="btn">Not a user?</a>
					<form:button onclick="remember(this)" id="loginButton" type="submit" class="btn btn-outline-light btn-lg">Login</form:button>
			</form:form>
		</div>
	</div>
	
	



	<!-- MDB -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
	<script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/vanilla-tilt.js"></script>
    
    <script type="text/javascript">
    
    	function load() {
    		$("#login-form").hide();
    		$("#form-login-content").hide();
    	}
			
    	
    	VanillaTilt.init(document.querySelector("#card-custom"), {
    		startX: 45,
    		startY: 45,
    		reset: true,
    	});
    	
    	
    	
    	function loginClick(){
            $("#form-register-content").hide('slow');
            setTimeout(showLogin, 1000);
    	}
     	
    	
    	function showLogin() {
    		$("#register-form").hide();
    		$("#form-login-content").slideToggle();
    		showLoginContent();
    	}
    	
		function showLoginContent() {
			$("#login-form").slideToggle();
    	}
		
		function regClick(){
            $("#form-login-content").hide('slow');
            setTimeout(showRegister, 1000);
    	}
     	
    	
    	function showRegister() {
    		$("#login-form").hide();
    		$("#form-register-content").slideToggle();
    		showRegisterContent();
    	}
    	
		function showRegisterContent() {
			$("#register-form").slideToggle();
    	}
		
		
		
    
    </script>
</body>
</html>