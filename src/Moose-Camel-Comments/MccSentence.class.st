"
I represent the sentence from a comment. I have information about the Nouns, verbs.

    Instance Variables
	nouns:		<Object>
	sentence:		<Object>

"
Class {
	#name : #MccSentence,
	#superclass : #Object,
	#instVars : [
		'nouns',
		'string',
		'interval'
	],
	#category : #'Moose-Camel-Comments-Model - Text'
}

{ #category : #'instance creation' }
MccSentence class >> fromSentence: aSentence [
	^ self new sentence: aSentence
]

{ #category : #'instance creation' }
MccSentence class >> string: aSentence [
	^ self new string: aSentence
]

{ #category : #comparing }
MccSentence >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ string = anObject sentence
]

{ #category : #accessing }
MccSentence >> asString [
	<return: #String>
	
	^ string
]

{ #category : #'gt-inspector-extension' }
MccSentence >> gtInspectorSentenceIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
		title: 'Sentence' translated;
		display: [  self asString ]
]

{ #category : #'gt-inspector-extension' }
MccSentence >> gtInspectorSentenceNounsIn: aComposite [
	<gtInspectorPresentationOrder: 3>

	^ aComposite list
			title: 'List of Noun Words';
			display: [MccSentenceProcessor fromSentence:( self sentence)splitIntoNouns].
]

{ #category : #'gt-inspector-extension' }
MccSentence >> gtInspectorWordsIn: aComposite [
	<gtInspectorPresentationOrder: 2>

	^ aComposite fastList
		title: 'Words' translated;
		display: [  self words ]
]

{ #category : #accessing }
MccSentence >> hasNegative [
	
	| negativeSentiments |
	
	negativeSentiments := MccCommentLinguisticAnlyzer new negativeSentiments.

	^ negativeSentiments anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]
]

{ #category : #accessing }
MccSentence >> hasTemplateStyle [
	
	| template templateSections|
	
	template := MccCommentTemplate new.
	
	templateSections := OrderedCollection new.
	
	templateSections addAll: {  
	'Intent' -> (template intentWords anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]).
	'Responsibility' -> (template responsibilityVerbs anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]).
	'PublicAPI' -> (template publicAPIs anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]).
	'Example' -> (template exampleWords anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]).
	'InternalRepresenation' -> (template internalRepresentationAndKeyImplementationWords anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]).
	'Instance Variable' -> (template instanceVariableWords anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ])
	}.
	
	^ templateSections isNotEmpty.	


]

{ #category : #accessing }
MccSentence >> hasWarning [
	
	| warnings |
	
	warnings := MccCommentLinguisticAnlyzer new warningWords.

	^ warnings anySatisfy: [ :each | ((self sentence) asLowercase) includesSubstring: (each asLowercase) ]
]

{ #category : #comparing }
MccSentence >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ string hash
]

{ #category : #initialization }
MccSentence >> initialize [
	super initialize.

	nouns := OrderedCollection new.
	interval := 0 to: 0
]

{ #category : #accessing }
MccSentence >> interval [
	^ interval
]

{ #category : #accessing }
MccSentence >> interval: anObject [
	interval := anObject
]

{ #category : #testing }
MccSentence >> isEmpty [ 
	"a sentence is said to be empty if it does not contain any word or all MccWord are empty.
	If a sentence contains seperator symbol, then also it is marked as empty."
	
	^ self words allSatisfy: [ :aWord | aWord isEmpty] 
]

{ #category : #testing }
MccSentence >> isNotEmpty [ 
	"a sentence is said to be empty if it does not contain any word or all MccWord are empty.
	If a sentence contains seperator symbol, then also it is marked as empty."
	
	^ self isEmpty not 
]

{ #category : #accessing }
MccSentence >> nouns [
	^ nouns
]

{ #category : #accessing }
MccSentence >> nouns: aCollectionOfNounWords [

	aCollectionOfNounWords do: [ :eachNounWord | 
		nouns add: (MccNoun fromWord: eachNounWord)].

]

{ #category : #printing }
MccSentence >> printOn: aStream [
	aStream print: self sentence
]

{ #category : #accessing }
MccSentence >> sentence [
	<return: #String>

	^ string
]

{ #category : #accessing }
MccSentence >> sentence: aString [
	string := aString trimmed
]

{ #category : #accessing }
MccSentence >> string: aString [
	self string: aString interval: (1 to: aString size - 1)
]

{ #category : #accessing }
MccSentence >> string: aString interval: anInterval [
	| aTrimmedDelta aStart |
	"anInterval is a location of the sentence within the original text"

	string := aString trimmed.

	"delta is how many whitespace characters were trimmed from the start of the string"
	aTrimmedDelta := (aString
		detectIndex: [ :each | each isSeparator not ]
		ifNone: [ aString size ]) - 1.

	aStart := anInterval first + aTrimmedDelta.
	interval := aStart to: aStart + string size - 1
]

{ #category : #accessing }
MccSentence >> words [
	<return: #Collection of: #MccWord>
	
	^ Array streamContents: [ :aStream | 
		| aCommentString |
		(aCommentString := self asString)
			splitOn: [ :eachChar | (eachChar isDigit or: [ eachChar isLetter or: [ eachChar = $: "for mutators" ] ]) not ]
			indicesDo: [ :start :end |
				| aWord anOffset aString |
				aString := aCommentString copyFrom: start to: end.
				anOffset := (interval first - 1) max: 0.
				aWord := MccWord string: aString.
				aWord interval: (start + anOffset to: end + anOffset).
				aStream nextPut: aWord ] ]
]
