NAGRESIGNAKO = new Object();
NAGRESIGNAKO.posts = new Object;
NAGRESIGNAKO.common = new Object;

NAGRESIGNAKO.common.init = function (){
  // Your js code for all pages here
  
  $(document).ajaxComplete(function(){
    try{ FB.XFBML.parse(); }catch(ex){}
    try { twttr.widgets.load(); } catch(ex) {}
    try { gapi.plusone.go(); } catch (ex) {}
  });
  
  var _showing = false;
  
  $(window).scroll(function () { 
    if (($(window).scrollTop() >= $(window).height()) && !_showing) {
      _showing = true;
      $(document).trigger("common.show.hiddencontrols");
    }
    
    if (($(window).scrollTop() < $(window).height()) && _showing)  {
      _showing = false; 
      $(document).trigger("common.hide.hiddencontrols");
    }
  });
  
  $(document).bind("common.show.hiddencontrols", function() {
    $("header.navbar-scrolled").animate({marginTop: "+=43"}, "fast");
    $("footer.scroll-to-top-area").animate({marginBottom: "+=62"}, "fast");
  });
  
  $(document).bind("common.hide.hiddencontrols", function() {
    $("header.navbar-scrolled").animate({marginTop: "-=43"}, "fast");
    $("footer.scroll-to-top-area").animate({marginBottom: "-=62"}, "fast");
  })
}