as yet unclassified
allClassesOfPackages
	<return: #Array of: #Classes>
	
	^ self packages collect:[:eachPackage | eachPackage -> eachPackage definedClasses]
	