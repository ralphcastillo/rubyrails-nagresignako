// posts/new.js

NAGRESIGNAKO.posts.new = function() {
	// Your js code for the cars controller here
	var loading = false;
	var page = 0;
	var post_count = 0;

	$(window).scroll(function() {
		if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10) && !loading) {
			loading = true;
			$(document).trigger("posts.new.load-items");
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
				beforeSend: function(){
					$(document).find('#new-entries-container').append('<div id="loading-container">Loading <img src="/assets/ajax-loader.gif" /></div>');
				},
				complete : function() {
					$(document).find('#new-entries-container #loading-container').remove();
				},
				success : function(data) {
					$("#new-entries-container").append(data);
					loading = false;
	
					var new_div = $("<div/>").attr("id", "new-information").append(data);
					$("body").append(new_div);
	
					try {
						FB.XFBML.parse(document.getElementById("new-information"), function() {
						});
						
						LF.CommentCount({ replacer: function(element, count) { 
		        			element.innerHTML = count +' Comment'+ (count === 1 ? '' : 's');
		    				}
						});
					} catch(ex) {
					}
	
					$("#hot-entries-container").append($("#new-information").html())
					new_div.remove();
	
				}
			});
		}else{			
			$(document).find('#new-entries-container').append('<div id="end-of-file"><img src="/assets/boy.png" /></div>');
		}
		
	});
}