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
	
	<canvas class="background"></canvas>
	<div class="body h-100">
		
		<a id="logout" class="btn btn-outline-secondary" href="/logout">Logout</a>
		<c:if test="${user.cards.size() > 0}"> 
			<div class="title">
			<h1>Here are your cards! You can edit them, delete them or create more</h1>
		</div>
			<div class="cards">
				<c:forEach var="card" items="${user.cards}">
					<div class="card shadow-6 rounded-6 card-copy" style="color:<c:out value="${card.textColor}"/>; background: rgba(<c:out value="${card.red}"/>, <c:out value="${card.green}"/>, <c:out value="${card.blue}"/>, <c:out value="${card.alpha}"/>)">
						<div class="card-body p-5"> 
							<div id="edit<c:out value="${card.id}"/>" class="edit" onMouseOver="appear(this)">
								<a id="editLink" style="visibility: hidden" class="editLink" onMouseOver="disapearButton()" onMouseOut="disapear()" href="/cards/<c:out value="${card.id}"/>/edit"><img src="/img/edit.png"/></a>
								<form:form action="/cards/${card.id}/delete" class="deleteLink" method="post">
									<input type="hidden" name="_method" value="delete"/>
									<button id="deleteButton" style="visibility: hidden" onMouseOver="disapearLink()" onMouseOut="disapear()" class="editLink" type="submit"><img src="/img/remove.png" class="deleteImg"></button>
								</form:form>
							</div>
							<h2 class="card-title">
								<strong>Premium</strong>
								<span class="fw-light">card</span>
							</h2>
							<div id="footer" class="fw-light ls-widest">
								<img alt="" src="https://ascensus-youtube-projects.mdbgo.io/img/chip.png" class="mb-5" style="width: 50px">
								<h5 class="mb-5"><c:out value="${card.number}"/></h5>
								<p class="mb-2"><c:out value="${card.user.firstName}"/> <c:out value="${card.user.lastName}"/></p>
								<p class="mb-5"><c:out value="${card.expDate}"/></p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${user.cards.size() < 4}">
				<a class="btn btn-outline-success btn-lg createButton" href="#card-form">Create more</a>
			</c:if>
			<c:if test="${user.cards.size() > 3}">
				<a class="btn btn-outline-secondary btn-lg createButton">You have reached the limit, Delete one in order to create!</a>
			</c:if>
		</c:if>
		
		<c:if test="${user.cards.size() < 1}"> 
			<div class="title-1">
				<h1>No Cards Here! Click the button below to create one!</h1>
			</div>
			<a class="btn btn-light btn-lg createButton" href="#card-form">Create</a>
		</c:if>
	</div>
	
	<c:if test="${user.cards.size() < 4}">
	
	<div id="learn" class="container-1 h-100">
		<div id="card-form" class="form-content text-white shadow-6 rounded-6">
			<form:form action="/cards/create" method= "post" modelAttribute="newCard">
				<input type="hidden" name="_method" value="put"/>
				<form:errors path="*" class="error"/>
				<div class="form-group row">
				    <form:label path="red" class="col-sm-4 col-form-label label mb4 opacity-70">Red:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="red" type="range" min="0" max="255" value="100" class="form-range inputRed" oninput="change()"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="green" class="col-sm-4 col-form-label label mb4 opacity-70">Green:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="green" type="range" min="0" max="255" value="100" class="form-range inputGreen" oninput="change()"/>
				    </div>
				</div>
				
				<div class="form-group row">
				    <form:label path="blue" class="col-sm-4 col-form-label label mb4 opacity-70">Blue:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="blue" type="range" min="0" max="255" value="100" class="form-range inputBlue" oninput="change()"/>
				    </div>
				</div>
				
				<div class="form-group row">
				    <form:label path="alpha" class="col-sm-4 col-form-label label mb4 opacity-70">Transparency:</form:label>
				    <div class="col-sm-8">
				      	<form:input id="range" path="alpha" type="range" min="0" max="100" value="15" class="form-range inputTransparency" oninput="change()"/>
				    </div>
				</div>
				<div class="form-group row">
				    <form:label path="textColor" class="col-sm-4 col-form-label label mb4 opacity-70">Text Color:</form:label>
				    <div class="col-sm-8">
				      	<form:input path="textColor" type="color" class="color inputColor" id="color" value="#ffffff" oninput="change()"/>
				    </div>
				</div>
					<form:button id="createCardButton" type="submit" class="btn btn-outline-light btn-lg">Create</form:button>
			</form:form>
		</div>
		<div class="cardSample">
			<div class="cardTitle">
				Sample Card
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
	</div>
	</c:if>

	<!-- MDB -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
	<script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/vanilla-tilt.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/particlesjs/2.2.2/particles.min.js"></script>
    
    <script type="text/javascript">
    
	    window.onload = function() { 
	    	Particles.init({ 
	    		selector: '.background',
	    		connectParticles: 'true'
			});
	    };
    	
    	function start() {
    		let editLink;
    		let deleteButton;
    		let newString = new String();
	    	change();
    	}    	
    	
    	function change() {
    		newString = 'rgba(' + document.querySelector(".inputRed").value.toString()
    		newString = newString.concat(', ', document.querySelector(".inputGreen").value.toString())
    		newString = newString.concat(', ', document.querySelector(".inputBlue").value.toString())
    		newString = newString.concat(', ', (document.querySelector(".inputTransparency").value / 100).toString())
    		newString = newString.concat(')');
    		document.getElementById("cardExample").style.background = newString;
    	
    		document.getElementById("cardExample").style.color = document.getElementById("color").value;
    	}
    	
    	function appear(element) {
    		editLink = element.querySelector("a");
    		deleteButton = element.querySelector("button");
    		editLink.style.visibility = "visible";
    		deleteButton.style.visibility = "visible";
    	}
    	
    	function disapearButton() {
    		editLink.style.opacity = "1";
    		deleteButton.style.opacity = "0";
    	}
    	
    	function disapearLink() {
    		deleteButton.style.opacity = "1";
    		editLink.style.opacity = "0";

    	}
    	
    	function disapear() {
    		editLink.style.visibility = "hidden";
    		deleteButton.style.visibility = "hidden";
    	}
  
    </script>
    
</body>
</html>