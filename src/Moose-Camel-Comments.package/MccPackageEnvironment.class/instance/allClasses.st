navigation
allClasses
	<return: #Array of: #Classes>
	
	^ MccClasses fromClasses: (self packages flatCollect:[:eachPackage | eachPackage classes])
	