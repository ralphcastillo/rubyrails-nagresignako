// posts/single.js

NAGRESIGNAKO.posts.single = function() {
	fyre.conv.load({}, [conversationInfo], function(widget) {
    widget.on('commentPosted', function (data) {
        // Do something, perhaps using data
        	LF.CommentCount({ replacer: function(element, count) { 
    			element.innerHTML = count +' Comment'+ (count === 1 ? '' : 's');
				}
			});
	    });
	});
}