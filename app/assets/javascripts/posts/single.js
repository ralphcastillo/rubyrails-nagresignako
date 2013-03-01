// posts/single.js

NAGRESIGNAKO.posts.single = function() {
	// Your js code for the cars controller here
	var loading = false;
	var page = 0;
	var post_count = 0;

	$(document).ready(function() {
		bind_vote_down();
		bind_vote_up();
		bind_report_spam();
	});
	bind_vote_up = function() {
		$(document).find('.entry-item .entry-votes .btn.up').bind("click", function() {
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
	}
	bind_vote_down = function() {
		$('.entry-item .entry-votes .btn.down').bind("click", function() {

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
	}

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
	bind_report_spam = function() {
		$('.report-spam-area a').bind("click", function() {

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
	}
}