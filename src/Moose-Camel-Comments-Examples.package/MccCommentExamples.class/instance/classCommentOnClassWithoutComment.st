examples - comment
classCommentOnClassWithoutComment
	<gtExample>
	| aClassComment |

	aClassComment := MccClassComment of: MccClassWithoutComment.

	self assert: (aClassComment isKindOf: MccEmptyComment).
	self assert: aClassComment artefact equals: MccClassWithoutComment.
	self assert: aClassComment asString equals: ''.
	self assert: aClassComment references equals: #().
	
	^ aClassComment