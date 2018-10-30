testing
hasClassNamed: aClassName
	"Return true if there is a class in this environment with an exact name"
	<return: #Boolean>
	
	^ self
		classNamed: aClassName
		ifFound: [ true ]
		ifNone: [ false ]