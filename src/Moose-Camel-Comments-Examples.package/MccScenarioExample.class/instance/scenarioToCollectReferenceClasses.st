gt-examples
scenarioToCollectReferenceClasses
	<gtExample>
	<description:'Collect all classes referenced by class comments'>
	
	| allSystemClasses allClassesOfCompilerPackageAsSymbols allClassesWithComments |
	
	allSystemClasses := self allSystemClasses.
	allClassesOfCompilerPackageAsSymbols:= self allClassesOfSelectedPackageAsSymbols.
	allClassesWithComments:= self allClassesWithComments.
	
	
