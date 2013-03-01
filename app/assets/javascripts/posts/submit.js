// posts/submit.js
NAGRESIGNAKO.posts.submit = function (){

  $("#verification-dialog").dialog({
    autoOpen: false,
    modal: true,
    title: "LAST NA 'TO! Final step before we post your story:",
    width: 760,
    open: function() {
      $("input[name='email']").focus();
    }
  });
  
  $("#new_post #submit-entry").bind("click", function() {
    $("#verification-dialog").dialog("open");
    return false;
  });
  
  $('#verification-dialog #verify-facebook .btn').bind("click", function(){
  	// window.location.href = "posts/fb_verify";
  	var email = $('#verification-dialog #verify-email input[type=text]').val();
  	$('<input>').attr({type: 'hidden', name: 'via', value: 'fb'}).appendTo("#new_post");
  	$("#new_post").submit();
  });
  
  $('#verification-dialog #verify-email .btn').bind("click", function(){
  	var email = $('#verification-dialog #verify-email input[type=text]').val();
  	
  	if(email == ""){
  		$(document).find('.input-append .error-message').remove();
  		$('<div class="error-message">E-mail must not be empty.</div>').insertBefore($(document).find('.input-append button'))
  		return false;
  	}
  	
  	$('<input>').attr({type: 'hidden', name: 'email', value: email}).appendTo("#new_post");
  	$('<input>').attr({type: 'hidden', name: 'via', value: 'email'}).appendTo("#new_post");
  	$("#new_post").submit();
  });
  
  $('#form-proper textarea').bind("input propertychange", function(){
  	var length = $('#form-proper textarea').val().length;
  	var maxlength = parseInt($('#form-proper textarea').attr("maxlength"));
  	
  	$('#submission-area #character-count-area #actual-counter').html(maxlength - length);
  });
};