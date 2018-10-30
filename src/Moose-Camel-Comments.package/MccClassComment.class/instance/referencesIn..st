accessing
referencesIn: aMccEnvironment
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ (MccClassReferenceFinder new
		comment: self;
		environment: aMccEnvironment) references