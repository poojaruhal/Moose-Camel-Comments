examples - comment
classCommentOnClassWithComment
	<gtExample>
	| aClassComment |
	
	aClassComment := MccClassComment of: MccClassWithComment.

	self assert: (aClassComment isKindOf: MccClassComment).
	self assert: aClassComment commentClass equals: MccClassWithComment.
	self assert: aClassComment asString equals: MccClassWithComment comment.
	
	^ aClassComment