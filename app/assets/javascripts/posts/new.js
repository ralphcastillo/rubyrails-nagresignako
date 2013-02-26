// posts/new.js

NAGRESIGNAKO.posts.new = function() {
	// Your js code for the cars controller here
	var loading = false;
	var page = 0;
	var post_count = 0;

	$(document).ready(function() {
		bind_vote_down();
		bind_vote_up();
		bind_report_spam();
	});

	$(window).scroll(function() {
		if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10) && !loading) {
			loading = true;
			$(document).trigger("posts.new.load-items");
			bind_vote_up();
			bind_vote_down();
			bind_report_spam();
		}
	});

	$(document).bind("posts.new.load-items", function() {
		if(post_count < parseInt($(document).find('#new-entries-container').attr('total-count'))){
			$.ajax({
				url : "/new",
				data : {
					page : ++page,
					post_count : post_count += 10,
				},
				dataType : "html",
				complete : function() {
				},
				success : function(data) {
					$("#new-entries-container").append(data);
					loading = false;
	
					var new_div = $("<div/>").attr("id", "new-information").append(data);
					$("body").append(new_div);
	
					try {
						FB.XFBML.parse(document.getElementById("new-information"), function() {
						});
					} catch(ex) {
					}
	
					$("#hot-entries-container").append($("#new-information").html())
					new_div.remove();
	
				}
			});
		}else{
			$(document).find('#end-of-file').show();
		}
		
	})
	bind_vote_up = function() {
		$('.entry-item .entry-votes .btn.up').bind("click", function() {

			var post_id = $(this).attr('post-id');
			var $this = $(this);

			$.ajax({
				url : "/posts/vote_up/" + post_id,
				data : {},
				dataType : "html",
				success : function(data) {
					$this.html(data);
					$(document).trigger("posts.update.vote_down", [$this.siblings('.entry-item .entry-votes .btn.down'), post_id]);
				}
			});

			return false;
		});
	}
	bind_vote_down = function() {
		$('.entry-item .entry-votes .btn.down').bind("click", function() {

			var post_id = $(this).attr('post-id');
			var $this = $(this);

			// var current_value = parseInt($this.find('span strong').html());
			// $this.find('span strong').html(++current_value);

			$.ajax({
				url : "/posts/vote_down/" + post_id,
				data : {},
				dataType : "html",
				success : function(data) {
					$this.html(data);
					$(document).trigger("posts.update.vote_up", [$this.siblings('.entry-item .entry-votes .btn.up'), post_id]);
				}
			});

			return false;
		});
	}

	$(document).bind("posts.update.vote_up", function(event, element, id) {
		$.ajax({
			url : "/posts/update_vote_up/" + id,
			data : {},
			dataType : "html",
			success : function(data) {
				element.html(data);
			}
		});
	})

	$(document).bind("posts.update.vote_down", function(event, element, id) {
		$.ajax({
			url : "/posts/update_vote_down/" + id,
			data : {},
			dataType : "html",
			success : function(data) {
				element.html(data);
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
					$this.hide();
				}
			});

			return false;
		});
	}
}