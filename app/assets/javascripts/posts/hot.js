// posts/hot.js

NAGRESIGNAKO.posts.hot = function (){
  // Your js code for the cars controller here
  var loading = false;
  var page = 0;
  
  $(window).scroll(function () { 
    if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10)
        && !loading) {
      loading = true;
      $(document).trigger("posts.hot.load-items");
    }
  });
  
  $(document).bind("posts.hot.load-items", function () {
    $.ajax({
      url : "/hot",
      data : { page: ++page },
      dataType : "html", 
      complete : function() {},
      success : function(data) {
        // var new_div = $("<div/>").attr("id", "new-information").append(data);
        // $("body").append(new_div);
//         
        // try{ FB.XFBML.parse(document.getElementById("new-information"),
        // function() { 
// //          document.getElementById("new-information");
        // }); }catch(ex){}
//         
        // $("#hot-entries-container").append($("#new-information").html())
          // new_div.remove();
//         
        // loading = false;
        
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