gt-examples
allPackages
	<gtExample>

	| packagesToConsider packageEnvironment |

	packagesToConsider := #(Brick Bloc).
	packageEnvironment := MccPackageEnvironment ofPackages: packagesToConsider.
	
	^ packageEnvironment packages
	