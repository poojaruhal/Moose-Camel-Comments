examples - comment
textCommentOnNumberDescription
	<gtExample>
	| aText aTextComment |
	
	aText := 'Number holds the most general methods for dealing with numbers.'.
	
	aTextComment := MccTextComment of: aText.
	self assert: (aTextComment isKindOf: MccTextComment).
	self assert: aTextComment text equals: aText.
	self assert: aTextComment asString equals: aText.

	^ aTextComment