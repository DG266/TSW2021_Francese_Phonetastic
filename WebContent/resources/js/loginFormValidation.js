// FUNZIONI PER LA VALIDAZIONE

function validateEmail(inputEmail) {
	
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	
	if(inputEmail.val().match(mailformat)) {
		return true;
	}
	else {
		inputEmail.focus();
		return false;
	}
}

 

function validatePassword(password) {
	var passwordRegexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$";
	
	if(password.val().match(passwordRegexp)) {
		return true;
	}
	else {
		password.focus();
		return false;
	}
}

function allLetter(name) {
	
	var letters = /^[A-Za-z]+$/;
	
	if(name.val().match(letters)) {
		return true;
	}
	else {
		name.focus();
		return false;
	}
}

$(document).ready(function(){
	
	// VALIDAZIONE LOGIN
	$("#loginForm").submit(function(event){
		if(!validateEmail($("#loginForm input[name=email]"))) {
			$("#loginInfo").html("Inserisci una email valida.");
			return false;   // blocca il submit del form
		}
	});
	
	// VALIDAZIONE REGISTRAZIONE
	$("#registrationForm").submit(function(event){
		
		$("#registrationInfo").empty();
		
		var firstNameValid = allLetter($("#registrationForm input[name=firstName]"));
		var lastNameValid = allLetter($("#registrationForm input[name=lastName]"))
		var emailValid = validateEmail($("#registrationForm input[name=email]"));
		var passwordValid = validatePassword($("#registrationForm input[name=pwd]"));
		
		//console.log("firstNameValid = " + firstNameValid + " lastNameValid = " + lastNameValid + " emailValid = " + emailValid);
		
		if(!firstNameValid || !lastNameValid || !emailValid || !passwordValid) {
			$("#registrationInfo").html("Ricontrolla i dati inseriti.<br>");
			return false;
		}
	});	
	
	// CONTROLLO EMAIL GIÀ UTILIZZATA (PRIMA DEL SUBMIT)
	$("#registrationForm").change(function(event){
		if($("#registrationForm input[name=email]").val() != ""){
			$.get("./login?email=" + $("#registrationForm input[name=email]").val(), function(responseJson) {  
				if(responseJson.isPresent){
					$("#registrationInfo").html("L'email inserita è già presente.");
				}
			});
		}
	});
});




