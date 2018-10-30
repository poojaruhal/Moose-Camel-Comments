testing
classNamed: aClassName ifFound: aFoundBlock ifNone: aNoneBlock
	"Find a class with an exact given name in this environment and evaluate aFoundBlock if such class exists
	and aNoneBlock otherwise"
	<return: #Object>
	
	^ self allClasses
		detect: [ :eachClass | eachClass name = aClassName ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock