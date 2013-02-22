// posts/new.js

NAGRESIGNAKO.posts.new = function() {
	// Your js code for the cars controller here
	var loading = false;
	var page = 0;

	$(document).ready(function() {
		bind_vote_down();
		bind_vote_up();
	});

	$(window).scroll(function() {
		if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10) && !loading) {
			loading = true;
			$(document).trigger("posts.new.load-items");
			bind_vote_up();
			bind_vote_down();
		}
	});

	$(document).bind("posts.new.load-items", function() {
		$.ajax({
			url : "/new",
			data : {
				page : ++page
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
	})
	bind_vote_up = function() {
		$('.entry-item .entry-votes .btn.up').bind("click", function() {

			var post_id = $(this).attr('post-id');
			var $this = $(this);

			$.ajax({
				url : "/posts/vote_up/" + post_id,
				data : {},
				dataType : "html",
				complete : function() {
				},
				success : function(data) {
					$this.html(data);
				}
			});

			return false;
		});
	}
	bind_vote_down = function() {
		$('.entry-item .entry-votes .btn.down').bind("click", function() {

			var post_id = $(this).attr('post-id');
			var $this = $(this);

			$.ajax({
				url : "/posts/vote_down/" + post_id,
				data : {},
				dataType : "html",
				complete : function() {
				},
				success : function(data) {
					$this.html(data);
				}
			});

			return false;
		});
	}
}