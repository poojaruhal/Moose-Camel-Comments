references
referencesIn: aMccEnvironment
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ {
		MccClassReferenceFinder new
			comment: self;
			environment: aMccEnvironment.
		MccMethodReferenceFinder new
			comment: self;
			environment: aMccEnvironment;
			classOrMetaclass: self commentClass
	} flatCollect: #references