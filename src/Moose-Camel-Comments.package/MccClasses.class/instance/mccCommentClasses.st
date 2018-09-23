accessing
mccCommentClasses
	
		 ^ mccCommentClasses:=  self allClasses collect: [ :eachClass | 
				 MccComment fromClass: eachClass].