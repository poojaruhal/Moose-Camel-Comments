initialization
initializeWith: anObject
	"Initialize this comment with a given code artefact that depends on the comment type
	For example class comment must be initialized with a Class while method comments with a compiled method"

	self artefact: anObject