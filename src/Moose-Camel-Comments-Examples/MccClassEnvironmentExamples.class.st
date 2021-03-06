"
Example to represent class environment
"
Class {
	#name : #MccClassEnvironmentExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Environment- Examples'
}

{ #category : #'environment - examples' }
MccClassEnvironmentExamples >> classEnvironmentWithPoint [
	<gtExample>
	| aClassEnvironment |
	
	aClassEnvironment := MccClassEnvironment with: Point.

	self assert: aClassEnvironment classes equals: { Point }.
	self assert: (aClassEnvironment hasClassNamed: 'Point').
	self assert: (aClassEnvironment hasClassNamed: #Point).
	self assert: (aClassEnvironment hasClassNamed: #Rectangle) not.

	^ aClassEnvironment
]
