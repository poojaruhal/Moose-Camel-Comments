Extension { #name : #CompiledMethod }

{ #category : #'*Moose-Camel-Comments' }
CompiledMethod >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ MccMethodComment of: self
]
