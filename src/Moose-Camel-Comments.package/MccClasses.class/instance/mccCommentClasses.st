accessing
mccCommentClasses
	
	<return: #Array of: #MccComment>
	
	^ mccCommentClasses:=  self allClasses collect: 
			[ :eachClass | MccComment fromClass: eachClass].