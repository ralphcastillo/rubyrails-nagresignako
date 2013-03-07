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
  });
  
  
  /* LIVE CONTROLS FOR VOTE INTERACTIONS */
 	$('.entry-item .entry-votes .btn.up').live("click", function() {

		var post_id = $(this).attr('post-id');
		var $this = $(this);

		if($this.find('i.resign-sprite').hasClass('upvote-active')){
			return false;
		}else{
			var current_value = parseInt($this.find('span strong').html());
			$this.find('span strong').html(++current_value);
			$this.find('i.resign-sprite').removeClass('upvote-inactive');
			$this.find('i.resign-sprite').addClass('upvote-active');
			
			var button_sibling = $this.siblings('.entry-item .entry-votes .btn.down');
			
			if(button_sibling.find('i.resign-sprite').hasClass('downvote-active')){
				var sibling_current_value = parseInt(button_sibling.find('span strong').html());
				button_sibling.find('span strong').html(--sibling_current_value);
				button_sibling.find('i.resign-sprite').removeClass('downvote-active');
				button_sibling.find('i.resign-sprite').addClass('downvote-inactive');
			}
			
			$.ajax({
				url : "/posts/vote_up/" + post_id,
				data : {},
				dataType : "html",
				success : function(data) {
					$(document).trigger("posts.update.vote_down", [$this.siblings('.entry-item .entry-votes .btn.down'), post_id]);
				}
			});
		}			
		
		return false;
	}); 
	
	$('.entry-item .entry-votes .btn.down').live("click", function() {

		var post_id = $(this).attr('post-id');
		var $this = $(this);
		
		if($this.find('i.resign-sprite').hasClass('downvote-active')){
			return false;
		}else{
			var current_value = parseInt($this.find('span strong').html());
			$this.find('span strong').html(++current_value);
			$this.find('i.resign-sprite').removeClass('downvote-inactive');
			$this.find('i.resign-sprite').addClass('downvote-active');
			
			var button_sibling = $this.siblings('.entry-item .entry-votes .btn.up');
			
			if(button_sibling.find('i.resign-sprite').hasClass('upvote-active')){
				var sibling_current_value = parseInt(button_sibling.find('span strong').html());
				button_sibling.find('span strong').html(--sibling_current_value);
				button_sibling.find('i.resign-sprite').removeClass('upvote-active');
				button_sibling.find('i.resign-sprite').addClass('upvote-inactive');
			}
			
			$.ajax({
				url : "/posts/vote_down/" + post_id,
				data : {},
				dataType : "html",
				success : function(data) {
					$(document).trigger("posts.update.vote_up", [$this.siblings('.entry-item .entry-votes .btn.up'), post_id]);
				}
			});
		}

		return false;
	});
	
	$('.report-spam-area a').live("click", function() {

		var post_id = $(this).attr('post-id');
		var $this = $(this);

		$.ajax({
			url : "/posts/report/" + post_id,
			data : {},
			dataType : "html",
			success : function(data) {
				$('<div class="notice-message">Reported as Spam</div>').insertBefore($this.parent().parent().parent().find('.entry-header-area'));
				$this.hide();
			}
		});

		return false;
	});
	
	$(document).bind("posts.update.vote_up", function(event, element, id) {
		$.ajax({
			url : "/posts/update_vote_up/" + id,
			data : {},
			dataType : "html",
			success : function(data) {
				//element.html(data);
			}
		});
	})

	$(document).bind("posts.update.vote_down", function(event, element, id) {
		$.ajax({
			url : "/posts/update_vote_down/" + id,
			data : {},
			dataType : "html",
			success : function(data) {
				//element.html(data);
			}
		});
	})
}