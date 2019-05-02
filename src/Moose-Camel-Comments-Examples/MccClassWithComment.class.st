"
I represent a class with comment. I contain methods that also have comments that reference other classes, variables or methods.

Users can reference other classes directly, for example:
 - MccClassWithoutComment is a direct and precise reference to a class that does not have a comment
 - ClassWithoutComment is a direct but partial reference to a class that omits package prefix
 - ""class without comment"" is a class referene given in natural language. Our aim is to detect such references and show them to user
"
Class {
	#name : #MccClassWithComment,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Artefacts'
}

{ #category : #accessing }
MccClassWithComment >> classesWithComment [
	"all classes with comments from systemEnvironment"
	<gtExample>
		
	^ (self mooseEnvironment allClasses select: #hasComment) asOrderedCollection.
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> distributeStrats [
	<gtExample>
	"chose 363 comments using random sampling approach"
	|allClasses strats|
	
	allClasses := self classesWithComment.
	
	^ strats := (allClasses collect: [ :e | 
	|length|
	length := e comment sentences size.
	length = 1
	ifTrue: [ #'1-1' -> e]
	ifFalse: [ 
		length = 2
		ifTrue: [ #'2-2' -> e ]
		ifFalse: [ 
			(length between: 3 and: 6) 
			ifTrue: [ #'3-6' -> e ]
			ifFalse: [ #'7-272' -> e]
		 ]
	  ]])groupedBy: [ :e | e key  ] .
]

{ #category : #accessing }
MccClassWithComment >> environment [ 
	"all classes with comments from systemEnvironment"
	<gtExample>
		
	^ MccSystemEnvironmentExamples new.
]

{ #category : #accessing }
MccClassWithComment >> methodsWithComment [
	"I am a method with comment"
	
	
]

{ #category : #accessing }
MccClassWithComment >> mooseEnvironment [
	"all classes with comments from systemEnvironment"

	<gtExample>
	| otherFileReference mooseModelEnvironment |
	
	otherFileReference := '/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/Moose-Model-CSV/pharo7-moose-model-classes-comments-withoutHeader.csv'
		asFileReference.
	
	mooseModelEnvironment := MccExternalEnvironment fromCSV: otherFileReference of: 7.
	^ mooseModelEnvironment
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> plotRandomSamplingDistribution [
	"chose 363 comments using random sampling approach"

	<gtExample>
	| sampleSetFreq b ds |
	
	sampleSetFreq := self randomSamplingOfExternalEnvironment associations
		collect: [ :e | e key -> e value size ].
		
	b := RTGrapher new.
	b extent: 300 @ 300.
	ds := RTData new.
	ds dotShape
		color: [ :e | 
			e value = 0
				ifTrue: [ Color blue alpha: 0.1 ]
				ifFalse: [ Color red alpha: 0.8 ] ].
	ds points: sampleSetFreq.
	ds x: #key.
	ds y: #value.
	b add: ds.
	b axisX noDecimal.
	b axisY noDecimal.
	^ b
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> randomSamplingOfExternalEnvironment [
	<gtExample>
	"chose 363 comments using random sampling approach"
	|allClasses|
	
	allClasses := self classesWithComment.
	
	^ ((((1 to: 363)  collect: [:e |
		|aClass|
	aClass := allClasses atRandom.
	allClasses remove: aClass.
	 aClass.
	   ]) collect: [:e | 	e comment sentences size
	 ]) sorted) groupedBy: [ :e | e value ].

]

{ #category : #'as yet unclassified' }
MccClassWithComment >> stratifiedSamplingOfExternalEnvironment [
	"chose 363 comments using stratified sampling approach"

	<gtExample>
	| group1 group2 group3 group4 strataSampleSet |
	group1 := self distributeStrats value at: #'1-1'.
	group2 := self distributeStrats value at: #'2-2'.
	group3 := self distributeStrats value at: #'3-6'.
	group4 := self distributeStrats value at: #'7-272'.
	strataSampleSet := OrderedCollection new.
	
	strataSampleSet
		addAll:
			(((1 to: 175)
				collect: [ :e | 
					| aClass |
					aClass := group1 atRandom.
					group1 remove: aClass.
					aClass value ]),
			((1 to: 55)
				collect: [ :e | 
					| aClass |
					aClass := group2 atRandom.
					group2 remove: aClass.
					aClass value ]),
				
			((1 to: 69)
				collect: [ :e | 
					| aClass |
					aClass := group3 atRandom.
					group3 remove: aClass.
					aClass value ]),
				
		((1 to: 66)
				collect: [ :e | 
					| aClass |
					aClass := group4 atRandom.
					group4 remove: aClass.
					aClass value ])).
				
	^ strataSampleSet
]
