NAGRESIGNAKO = new Object();
NAGRESIGNAKO.posts = new Object;
NAGRESIGNAKO.common = new Object;

NAGRESIGNAKO.common.init = function (){
  // Your js code for all pages here
  
  $(document).ajaxComplete(function(){

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
    $("header.navbar-scrolled").animate({marginTop: "+=40", opacity: 1}, "fast");
    $("footer.scroll-to-top-area").animate({marginBottom: "+=112", opacity: 1}, "fast");
  });
  
  $(document).bind("common.hide.hiddencontrols", function() {
    $("header.navbar-scrolled").animate({marginTop: "-=40", opacity: 0}, "fast");
    $("footer.scroll-to-top-area").animate({marginBottom: "-=112", opacity: 0}, "fast");
  })
}