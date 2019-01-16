Class {
	#name : #MccSmalltalkToken,
	#superclass : #PP2Token,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #enumerating }
MccSmalltalkToken >> allChildren [
	^ Array streamContents: [ :aStream |
		self children do: [ :each |
			aStream nextPut: each.
			aStream nextPutAll: each allChildren ] ]
]

{ #category : #enumerating }
MccSmalltalkToken >> allCodeAndTextDo: aBlock [
	self allChildren do: [ :eachNode | eachNode codeOrTextDo: aBlock ]
]

{ #category : #accessing }
MccSmalltalkToken >> children [
	^ { }
]

{ #category : #enumerating }
MccSmalltalkToken >> codeDo: aBlock [
	"Evaluate a given block if I am a code token"
]

{ #category : #enumerating }
MccSmalltalkToken >> codeOrTextDo: aBlock [
	
]

{ #category : #'as yet unclassified' }
MccSmalltalkToken >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 10>

	^ composite blocMondrian
		title: 'Tree';
		painting: [ :mondrian :x :presentation | self paintTreeWith: mondrian ]
]

{ #category : #'as yet unclassified' }
MccSmalltalkToken >> gtTreeFor: aView [
	<gtView>

	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #testing }
MccSmalltalkToken >> isCode [
	^ false
]

{ #category : #testing }
MccSmalltalkToken >> isEmpty [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
MccSmalltalkToken >> isEmptyOrNil [
	^ self isEmpty
]

{ #category : #testing }
MccSmalltalkToken >> isNotEmpty [
	<return: #Boolean>
	
	^ self isEmpty not
]

{ #category : #testing }
MccSmalltalkToken >> isText [
	^ false
]

{ #category : #'as yet unclassified' }
MccSmalltalkToken >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			(each isKindOf: MccSmalltalkCodeToken)
				ifTrue: [
					BrEditor new 
						zIndex: 10;
						background: (Color gray alpha: 0.1);
						geometry: (BlRectangle cornerRadius: 3);
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
						padding: (BlInsets all: 8);
						fitContent;
						styler: (BrRBTextStyler new);
						text: (each value asRopedText monospace) ]
				ifFalse: [
					(each isKindOf: MccSmalltalkTextToken)
						ifTrue: [
							BlTextElement new 
								zIndex: 10;
								background: Color white;
								constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
								text: (each value asRopedText foreground: Color gray)]
						ifFalse: [
							BlElement new 
								zIndex: 10;
								geometry: BlEllipse new;
								border: (BlBorder paint: Color black width: 1);
								background: (Color white);
								size: 20@20
						] ] ];
			with: (self withAllChildren).
	view edges
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 20;
		levelDistance: 40
]

{ #category : #parsing }
MccSmalltalkToken >> parse [
	<return: #MccSmalltalkToken>

	^ self subclassResponsibility
]

{ #category : #enumerating }
MccSmalltalkToken >> withAllChildren [
	^ { self }, self allChildren
]
