// posts/hot.js

NAGRESIGNAKO.posts.hot = function() {
	// Your js code for the cars controller here
	var loading = false;
	var page = 0;
	var post_count = 0;

	$(window).scroll(function() {
		if (($(window).scrollTop() >= $(document).height() - $(window).height() - 10) && !loading) {
			loading = true;
			$(document).trigger("posts.hot.load-items");
			bind_vote_up();
			bind_vote_down();
			$('.report-spam-area a').unbind("click");
			bind_report_spam();
		}
	});

	$(document).bind("posts.hot.load-items", function() {
		if(post_count < parseInt($(document).find('#hot-entries-container').attr('total-count'))){
		$.ajax({
			url : "/hot",
			data : {
				page : ++page,
				post_count : post_count += 10,
			},
			dataType : "html",
			beforeSend: function(){
				$(document).find('#hot-entries-container').append('<div id="loading-container">Loading <img src="/assets/ajax-loader.gif" /></div>');
			},
			complete : function() {
				$(document).find('#hot-entries-container #loading-container').remove();
			},
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
			$(document).find('#hot-entries-container').append('<div id="end-of-file"><img src="/assets/boy.png" /></div>');
		}
	});
}