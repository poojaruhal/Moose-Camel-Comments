Class {
	#name : #MccSmalltalkInCommentParserResult,
	#superclass : #Object,
	#instVars : [
		'errorNode',
		'errorResult',
		'isValid',
		'isPartiallyValid',
		'filteredAST',
		'originalAST'
	],
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #'instance creation' }
MccSmalltalkInCommentParserResult class >> for: anRBNode [
	^ self new
		isValid: true;
		isPartiallyValid: true;
		filteredAST: anRBNode;
		originalAST: anRBNode copy
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> errorNode [
	^ errorNode
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> errorNode: anObject [
	errorNode := anObject
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> errorResult [
	^ errorResult
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> errorResult: anObject [
	errorResult := anObject
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> filteredAST [
	^ filteredAST
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> filteredAST: anObject [
	filteredAST := anObject
]

{ #category : #'as yet unclassified' }
MccSmalltalkInCommentParserResult >> gtInspectorValidPartIn: aComposite [
	<gtInspectorPresentationOrder: 1>
	
	^ (self filteredAST gtInspectorSourceCodeIn: aComposite)
		title: 'Filtered'
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> isPartiallyValid [
	^ isPartiallyValid
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> isPartiallyValid: anObject [
	isPartiallyValid := anObject
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> isValid [
	^ isValid
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> isValid: anObject [
	isValid := anObject
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> originalAST [
	^ originalAST
]

{ #category : #accessing }
MccSmalltalkInCommentParserResult >> originalAST: anObject [
	originalAST := anObject
]
