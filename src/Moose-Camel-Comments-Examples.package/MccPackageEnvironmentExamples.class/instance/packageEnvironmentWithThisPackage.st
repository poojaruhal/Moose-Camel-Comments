environment - examples
packageEnvironmentWithThisPackage
	<gtExample>
	| packageEnvironment |

	packageEnvironment := MccPackageEnvironment with: self class package.
	
	self assert: packageEnvironment packages equals: { self class package }.
	self assert: packageEnvironment allClasses equals: self class package definedClasses asArray.

	^ packageEnvironment