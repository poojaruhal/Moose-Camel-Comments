as yet unclassified
allClassesOfPackages
	<return: #Array of: #Classes>
	
	^ self packages flatCollect:[:eachPackage | 
		eachPackage classes].
	