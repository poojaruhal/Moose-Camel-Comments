Extension { #name : #Class }

{ #category : #'*Moose-Camel-Comments' }
Class >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ MccClassComment of: self
]
