accessing
withComments
	
	<return: #Array of: #MccComment>
	
	 ^ mccCommentClasses:=  (self select: #hasComment) collect: #mccComment.
	
