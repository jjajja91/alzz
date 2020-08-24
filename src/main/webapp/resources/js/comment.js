/**
 * 
 */

console.log("comment module......................................");

var commentService = (function() {

	function getList(param, callback, error) {
		
		var boardId = param.boardId;
		
		$.getJSON("/comments/" + boardId + ".json", 
				function(data) {
					if(callback) {
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error) {
						error();
					}
		});
	}
	
	
	return {
		getList : getList
	};
	
})();