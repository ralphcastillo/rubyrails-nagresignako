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
  
  $("#submit-form-area").bind("submit", function() {
    $("#verification-dialog").dialog("open");
    return false;
  });
};