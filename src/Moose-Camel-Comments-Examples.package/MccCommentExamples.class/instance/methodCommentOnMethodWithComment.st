examples - comment
methodCommentOnMethodWithComment
	<gtExample>
	| aMethodComment |
	
	aMethodComment := MccMethodComment of: MccClassWithComment >> #methodWithComment.

	self assert: (aMethodComment isKindOf: MccMethodComment).
	self assert: aMethodComment method equals: MccClassWithComment >> #methodWithComment.
	self assert: aMethodComment asString equals: (MccClassWithComment >> #methodWithComment) comment.
	
	^ aMethodComment