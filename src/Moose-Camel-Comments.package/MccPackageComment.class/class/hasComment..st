testing
hasComment: anObject
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ anObject packageManifestOrNil isNotNil and: [ anObject packageManifestOrNil hasComment ]