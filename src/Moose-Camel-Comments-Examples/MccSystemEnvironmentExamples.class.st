Class {
	#name : #MccSystemEnvironmentExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Environment- Examples'
}

{ #category : #accessing }
MccSystemEnvironmentExamples >> allClasses [
	"all classes with comments from systemEnvironment"
	<gtExample>
		
	^ MccSystemEnvironment default allClasses
]

{ #category : #accessing }
MccSystemEnvironmentExamples >> allMethods [
	"all classes with comments from systemEnvironment"
	<gtExample>
		
	^ MccSystemEnvironment default allMethods
]
