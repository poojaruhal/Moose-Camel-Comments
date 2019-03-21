"
I am responsible for all packages and classes needs to be considered in experiment environment.
"
Class {
	#name : #MccPackageEnvironmentExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Environment- Examples'
}

{ #category : #'environment - examples' }
MccPackageEnvironmentExamples >> packageEnvironmentWithThisPackage [
	<gtExample>
	| packageEnvironment |

	packageEnvironment := MccPackageEnvironment with: self class package.
	
	self assert: packageEnvironment packages equals: { self class package }.
	self assert: packageEnvironment allClasses equals: self class package definedClasses asArray.

	^ packageEnvironment
]

{ #category : #'environment - examples' }
MccPackageEnvironmentExamples >> packageEnvironmentWithThisPackageName [
	<gtExample>
	| packageEnvironment |

	packageEnvironment := MccPackageEnvironment named: self class package name.
	
	self assert: packageEnvironment packages equals: { self class package }.
	self assert: packageEnvironment allClasses equals: self class package definedClasses asArray.

	^ packageEnvironment
]
