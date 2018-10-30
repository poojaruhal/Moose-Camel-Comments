accessing
artefact: anObject
	self
		assert: [ anObject isNotNil ]
		description: [ 'Code artefact must not be nil' ].

	artefact := anObject