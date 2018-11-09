accessing
mccCommentClasses
	
	<return: #Array of: #MccComment>
	
	 ^ mccCommentClasses:=  self classesWithComments collect: #mccComment.
	
