gt-examples
allPackages
	<gtExample>

	| packagesToConsider packageEnvironment |

	packagesToConsider := #(Brick).
	packageEnvironment := MccPackageEnvironment ofPackages: packagesToConsider.
	
	^ packageEnvironment packages.
	