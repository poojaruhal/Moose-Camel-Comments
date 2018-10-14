gt-examples
referencedClassesFromProject
	<return: #Array of: #ReferencedClass>
	
	^ (self commentClass methods reject: #isExtension) flatCollect: #referencedClasses