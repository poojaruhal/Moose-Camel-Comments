accessing
packages: anArray
	packages := anArray collect: [ :eachPackage | eachPackage asPackage ].