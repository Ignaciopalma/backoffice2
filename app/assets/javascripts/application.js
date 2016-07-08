// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


/* ***************** ***************** ***************** */
/* MOSTRAR HINTS EN FORMULARIO */
/* ***************** ***************** ***************** */
$(function() {

	// variables
	$password = $("#password");
	$confirmPassword = $("#confirm-password");

	function isPasswordValid() {
		return $password.val().length > 8;
	}

	function arePasswordsMatching() {
		return $password.val() === $confirmPassword.val();
	}

	function canSubmit() {
		return isPasswordValid() && arePasswordsMatching();
	}


    // Hide Hints
    $(".row-content span").hide();

    function passwordEvent() {
  		// Find out if field input is valid
    	if(isPasswordValid()) {
    		// Hide if valid
    		$password.next().hide();

    	} else {
    		// Else show hint
    		$password.next().show();
    	}
    }


    function confirmPasswordEvent() {
    	$(".row-content span.match-pass").hide();
  		// Find out if password and confirmation are the same
		if(arePasswordsMatching()) {
		// Hide hint if match
			$confirmPassword.next().hide();
		} else {
			$confirmPassword.next().show();
		}
	}  

	function enableSubmitEvent() {
		$("#submit").prop("disabled", !canSubmit())
	}


    $password.focus(passwordEvent).keyup(passwordEvent).keyup(confirmPasswordEvent).keyup(enableSubmitEvent);
    $(".row-contetn span.match-pass").hide();
    $confirmPassword.focus(confirmPasswordEvent).keyup(confirmPasswordEvent).keyup(enableSubmitEvent);

    enableSubmitEvent();
});
