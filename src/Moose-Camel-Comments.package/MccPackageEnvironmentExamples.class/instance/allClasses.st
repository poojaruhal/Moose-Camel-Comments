gt-examples
allClasses
<gtExample>
	|allClasses|

	^ allClasses := self allPackages flatCollect: [ :eachPackage | eachPackage classes] 
