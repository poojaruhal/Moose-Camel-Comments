examples - comment
classCommentOnClassWithCommentOfTwoSentences
	<gtExample>
	| aClassComment |

	aClassComment := MccClassComment of: MccClassWithCommentOfTwoSentences.

	self assert: (aClassComment isKindOf: MccClassComment).
	self assert: aClassComment commentClass equals: MccClassWithCommentOfTwoSentences.
	self assert: aClassComment asString equals: MccClassWithCommentOfTwoSentences comment.
	self assert: aClassComment sentences size equals: 2.
	self assert: aClassComment sentences first asString equals: 'I am a class with a comment'.
	self assert: aClassComment sentences second asString equals: 'It consists of two sentenses'.

	^ aClassComment