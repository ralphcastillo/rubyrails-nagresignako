// posts/submit.js
NAGRESIGNAKO.posts.submit = function (){

  $("#verification-dialog").dialog({
    autoOpen: false,
    modal: true,
    title: "Verification Dialog",
    width: 660,
    open: function() {
      $("input[name='email']").focus();
    }
  });
  
  $("#new_post #submit-entry").bind("click", function() {
    $("#verification-dialog").dialog("open");
    return false;
  });
  
  $('#verification-dialog #verify-facebook .btn').bind("click", function(){
  	window.location.href = "posts/fb_verify";
  });
  
  $('#verification-dialog #verify-email .btn').bind("click", function(){
  	var email = $('#verification-dialog #verify-email input[type=text]').val();
  	$('<input>').attr({type: 'hidden', name: 'email', value: email}).appendTo("#new_post");
  	$("#new_post").submit();
  });
};