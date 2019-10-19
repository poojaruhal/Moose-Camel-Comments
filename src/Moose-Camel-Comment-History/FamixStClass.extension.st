Extension { #name : #FamixStClass }

{ #category : #'*Moose-Camel-Comment-History' }
FamixStClass >> moCaComment [
	^ self comments ifEmpty: '' ifNotEmpty: [ :f | f first content ]
]
