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
		
	^ self environment allClasses select: #hasComment.
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

{ #category : #'as yet unclassified' }
MccClassWithComment >> randomSamplingOfCommentClasses [
<gtExample>

	^ (((1 to: 120) 
	collect: [ :e | self classesWithComment atRandom ]) asSet asOrderedCollection 
	groupedBy: [ :e | 
		|sentences|
		sentences := e mccComment sentences.
		sentences size = 1 
			ifTrue: [ #oneSentence ]
			ifFalse: [
				sentences size <=10
					ifTrue:[#MultiSentence]
					ifFalse:[#MultiParagraph]
				  ]	])
]
