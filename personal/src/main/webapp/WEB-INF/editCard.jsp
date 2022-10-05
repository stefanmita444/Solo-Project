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
    <title>Welcome</title>
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
<body class="vh-100" onload="start()">
	
	<div id="learn" class="container-1 h-100">
		<div id="card-form" class="form-content text-white shadow-6 rounded-6">
			<form:form action="/cards/${card.id}/update" method= "post" modelAttribute="newCard">
				<input type="hidden" name="_method" value="put"/>
				<form:errors path="*" class="error"/>
				<div class="form-group row">
				    <form:label path="red" class="col-sm-4 col-form-label label mb4 opacity-70">Red:</form:label>
				    <div class="col-sm-8">
				    	<p><span class="rangeValue"></span></p>
				      	<form:input path="red" type="range" min="0" max="255" value="${card.red}" class="form-range inputRed" oninput="change()"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="green" class="col-sm-4 col-form-label label mb4 opacity-70">Green:</form:label>
				    <div class="col-sm-8">
				    	<p><span class="rangeValue"></span></p>
				      	<form:input path="green" type="range" min="0" max="255" value="${card.green}" class="form-range inputGreen" oninput="change()"/>
				    </div>
				</div>
				
				<div class="form-group row">
				    <form:label path="blue" class="col-sm-4 col-form-label label mb4 opacity-70">Blue:</form:label>
				    <div class="col-sm-8">
				    	<p><span class="rangeValue"></span></p>
				      	<form:input path="blue" type="range" min="0" max="255" value="${card.blue}" class="form-range inputBlue" oninput="change()"/>
				    </div>
				</div>
				
				<div class="form-group row">
				    <form:label path="alpha" class="col-sm-4 col-form-label label mb4 opacity-70">Transparency:</form:label>
				    <div class="col-sm-8">
				    	<p><span class="rangeValue"></span></p>
				      	<form:input id="range" path="alpha" type="range" min="0" max="100" value="${card.alpha * 100}" class="form-range inputTransparency" oninput="change()"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="textColor" class="col-sm-4 col-form-label label mb4 opacity-70">Text Color:</form:label>
				    <div class="col-sm-8">
				    	<p><span class="colorInput"></span></p>
				      	<form:input path="textColor" type="color" class="color inputColor" id="color" value="${card.textColor}" oninput="change()"/>
				    </div>
				</div>
					<form:button id="createCardButton" type="submit" class="btn btn-outline-light btn-lg">Edit</form:button>
			</form:form>
		</div>
		<div id="cardExample" class="card shadow-6 rounded-6 card-copy" >
			<div class="card-body p-5"> 
				<h2 class="card-title ls-widest">
					<strong>Premium</strong>
					<span class="fw-light">card</span>
				</h2>
				<div id="footer" class="fw-light ls-widest">
					<img alt="" src="https://ascensus-youtube-projects.mdbgo.io/img/chip.png" class="mb-5" style="width: 50px">
					<h5 class="mb-5"><c:out value="${card.number}"/></h5>
					<p class="mb-2"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></p>
					<p class="mb-5"><c:out value="${card.expDate}"/></p>
				</div>
			</div>
		</div>
	</div>
	
	<div class=""></div>


	<!-- MDB -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
	<script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/vanilla-tilt.js"></script>
    
    <script type="text/javascript">
    	
    	function start() {
    		change();
        	
    	}
    	
    	
    	
    	
    	
    	function change() {
    		let newString = new String();
    		newString = 'rgba(' + document.querySelector(".inputRed").value.toString()
    		newString = newString.concat(', ', document.querySelector(".inputGreen").value.toString())
    		newString = newString.concat(', ', document.querySelector(".inputBlue").value.toString())
    		newString = newString.concat(', ', (document.querySelector(".inputTransparency").value / 100).toString())
    		newString = newString.concat(')');
    		document.getElementById("cardExample").style.background = newString;
    	
    		document.getElementById("cardExample").style.color = document.getElementById("color").value;
    	}
  
    
    </script>
    
</body>
</html>