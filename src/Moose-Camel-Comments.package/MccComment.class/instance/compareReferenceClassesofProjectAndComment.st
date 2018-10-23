gt-examples
compareReferenceClassesofProjectAndComment
	<return: #Array of: #ReferencedClass>
				
	^ ((self referencedClassesFromProject) intersection: (self referencedNounsFromComment)).