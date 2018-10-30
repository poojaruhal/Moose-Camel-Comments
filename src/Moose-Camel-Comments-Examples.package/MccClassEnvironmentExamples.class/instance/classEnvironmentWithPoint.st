environment - examples
classEnvironmentWithPoint
	<gtExample>
	| aClassEnvironment |
	
	aClassEnvironment := MccClassEnvironment with: Point.

	self assert: aClassEnvironment classes equals: { Point }.
	self assert: (aClassEnvironment hasClassNamed: 'Point').
	self assert: (aClassEnvironment hasClassNamed: #Point).
	self assert: (aClassEnvironment hasClassNamed: #Rectangle) not.

	^ aClassEnvironment