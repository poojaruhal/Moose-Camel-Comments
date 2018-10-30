references
references
	"Return a collection of references from this comment in a default environment"
	<return: #Collection of: #MccReference>

	^ self referencesIn: MccSystemEnvironment default