Extension { #name : #FAMIXClass }

{ #category : #'*Moose-Camel-Comment-History' }
FAMIXClass >> moCaComment [
	^ self comments ifEmpty: '' ifNotEmpty: [ :f | f first content ]
]
