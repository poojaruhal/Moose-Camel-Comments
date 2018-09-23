navigation
allClasses

	^ MccClasses fromClasses: (self packages flatCollect:[:eachPackage | eachPackage classes])
	