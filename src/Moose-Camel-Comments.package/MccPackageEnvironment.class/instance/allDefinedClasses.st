navigation
allDefinedClasses
	<return: #Array of: #Classes>
	
	^ self packages flatCollect:[:eachPackage | eachPackage definedClasses].
	