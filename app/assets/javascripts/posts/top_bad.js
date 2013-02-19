// posts/new.js

NAGRESIGNAKO.posts.top_bad = function (){
  // Your js code for the cars controller here
  var loading = false;
  var page = 0;
  
  $(window).scroll(function () { 
    if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10)
        && !loading) {
      loading = true;
      $(document).trigger("posts.new.load-items");
    }
  });
  
  $(document).bind("posts.new.load-items", function () {
    $.ajax({
      url : "/topbad",
      data : { page: ++page },
      dataType : "html", 
      complete : function() {},
      success : function(data) {
        $("#new-entries-container").append(data);
        loading = false;
        
        var new_div = $("<div/>").attr("id", "new-information").append(data);
        $("body").append(new_div);
        
        try{ FB.XFBML.parse(document.getElementById("new-information"),
        function() { }); }catch(ex){}
        
        $("#hot-entries-container").append($("#new-information").html())
          new_div.remove();
          
      }
    });
  })
}