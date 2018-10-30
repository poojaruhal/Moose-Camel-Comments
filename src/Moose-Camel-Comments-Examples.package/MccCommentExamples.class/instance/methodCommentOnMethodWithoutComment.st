examples - comment
methodCommentOnMethodWithoutComment
	<gtExample>
	| aMethodComment |

	aMethodComment := MccMethodComment of: MccClassWithoutComment >> #methodWithoutComment.

	self assert: (aMethodComment isKindOf: MccEmptyComment).
	self assert: aMethodComment artefact equals: MccClassWithoutComment >> #methodWithoutComment.
	self assert: aMethodComment asString equals: ''.
	self assert: aMethodComment references equals: #().
	
	^ aMethodComment