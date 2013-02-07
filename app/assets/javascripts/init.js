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
}