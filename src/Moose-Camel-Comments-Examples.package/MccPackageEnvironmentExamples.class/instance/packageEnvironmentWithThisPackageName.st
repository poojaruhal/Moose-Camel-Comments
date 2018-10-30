environment - examples
packageEnvironmentWithThisPackageName
	<gtExample>
	| packageEnvironment |

	packageEnvironment := MccPackageEnvironment named: self class package name.
	
	self assert: packageEnvironment packages equals: { self class package }.
	self assert: packageEnvironment allClasses equals: self class package definedClasses asArray.

	^ packageEnvironment