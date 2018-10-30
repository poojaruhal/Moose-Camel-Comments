instance creation
allNamed: thePackageNames
	^ self withAll: (thePackageNames collect: #asPackage)