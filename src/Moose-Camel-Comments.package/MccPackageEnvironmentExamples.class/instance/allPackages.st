gt-examples
allPackages
<gtExample>

	|packagesToConsider packageEnvironment|

	packagesToConsider := #(Compiler).
	packageEnvironment := MccPackageEnvironment ofPackages: packagesToConsider.
	^ packageEnvironment packages.
	