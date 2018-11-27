Extension { #name : #Text }

{ #category : #'*Moose-Camel-Comments' }
Text >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ MccTextComment of: self
]
