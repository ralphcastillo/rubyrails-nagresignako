// contact_form/new.js

NAGRESIGNAKO.contact_form.new = function (){
	
	$('#new_contact_form #contact-form-container #submit-feedback').bind("click", function(){
		console.log('form submitted');
	  	$("#new_contact_form").submit();
	  });
	
}