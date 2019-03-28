"
Pakcage that we are considering.
[[[
aMccPackageEnviornment := MccPackageEnvironment ofPackages: #(Brick Bloc).
]]]

Collect all the class from mentioned packages.
[[[
			mccClasses := aMccPackageEnviornment allMccClasses.
			]]]

Collect all the classes with comments.
[[[
			mccCommentClasses := mccClasses mccCommentClasses.
			]]]

Take a comment as a example.
[[[
			mccComment := mccCommentClasses at:11.
			]]]

Actual reference to the classes.
[[[
			referencedClassesFromProject:= mccComment referencedClassesFromProject.
	]]]

Collect potential classes from the comment.
[[[
			mccComment collectReferenceClassesFromComment ]]]





"
Class {
	#name : #MccScenarioExample,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples'
}

{ #category : #'gt-examples' }
MccScenarioExample >> allClassesOfSelectedPackage [
	<gtExample>
	<description:'collect all classes of Compiler package'>
	
	^ MccClassesExamples new allMccCommentClasses.
]

{ #category : #'gt-examples' }
MccScenarioExample >> allClassesOfSelectedPackageAsSymbols [
	<gtExample>
	<description:'collect all classes of Compiler package as symbols'>
	
	^  MccClassesExamples new asSymbols
]

{ #category : #'gt-examples' }
MccScenarioExample >> allClassesWithComments [
	<gtExample>
	<description:'collect all classes of Compiler with comments'>

 	^ MccClassesExamples new classesWithComments.
]

{ #category : #'gt-examples' }
MccScenarioExample >> allSystemClasses [
	<gtExample>
	<description:'collect all system classes'>

 	^ SystemNavigation default allClasses.
]

{ #category : #'gt-examples' }
MccScenarioExample >> collectReferencedClassesFromAllClassesComment [
	<gtExample>
	<description:'Collect  referenc classes  from classs comment'>
	| referncedClassesByAllMethods classesReferencedFromComment |
	
	referncedClassesByAllMethods := self allClassesOfSelectedPackageAsSymbols.
	classesReferencedFromComment :=
		self allClassesWithComments
			flatCollect: [ :aMccClassComment |
				| sentences | 
				sentences := aMccClassComment sentences.

				sentences
					flatCollect: [ :eachSentence | 
						| nouns |
						"nouns: ({'brick'.'block'.'blelement' })."
						nouns:= (MccSentenceProcessorExamples new splitIntoNouns) asArray.
						referncedClassesByAllMethods intersection: nouns] ]
			as: Set.

	^ classesReferencedFromComment

]

{ #category : #'gt-examples' }
MccScenarioExample >> collectReferencedClassesFromComment [
	<gtExample>
	<description:'Collect  referenc classes  of a classs comment'>
	
	| mccComment referncedClassesByAllMethods sentences classesReferencedFromComment |

	mccComment := MccCommentExamples new.
	referncedClassesByAllMethods := mccComment referencedClassesFromProject.
	referncedClassesByAllMethods := referncedClassesByAllMethods collect:
		[:eachClass | eachClass name asLowercase asSymbol].
	sentences := mccComment sentences.
	classesReferencedFromComment:= sentences flatCollect:[ :aSentence  | 
		| nouns |
		"nouns:= ({'brick'.'block'.'blelement' })"
		nouns := (MccSentenceProcessorExamples new splitIntoNouns) asArray.
		nouns intersection: referncedClassesByAllMethods ].
	
	^ classesReferencedFromComment


]

{ #category : #'gt-examples' }
MccScenarioExample >> scenarioToCollectReferenceClasses [
	<gtExample>
	<description:'Collect all classes referenced by class comments'>
	
	| allSystemClasses allClassesOfCompilerPackageAsSymbols allClassesWithComments |
	
	allSystemClasses := self allSystemClasses.
	allClassesOfCompilerPackageAsSymbols:= self allClassesOfSelectedPackageAsSymbols.
	allClassesWithComments:= self allClassesWithComments.
	
	

]
