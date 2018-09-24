accessing
packages
	<return: #Array of: #Packages>
	packages := packages collect: [ :eachPackage | eachPackage asPackage ].
	
	^ packages	