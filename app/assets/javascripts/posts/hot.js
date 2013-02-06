// posts/hot.js

NAGRESIGNAKO.posts.hot = function (){
  // Your js code for the cars controller here
  var loading = false;
  
  $(window).scroll(function () { 
    if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10)
        && !loading) {
      loading = true;
      $(document).trigger("posts.hot.load-items");
    }
  });
  
  $(document).bind("posts.hot.load-items", function () {
    $.ajax({
      url : "/new",
      data : {},
      dataType : "html", 
      complete : function() {},
      success : function(data) {
        $("#hot-entries-container").append(data);
        loading = false;
      }
    });
  })
}