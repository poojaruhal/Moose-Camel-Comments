accessing
packages

	packages := packages collect: [ :eachPackage | eachPackage asPackage ].
	^ packages	