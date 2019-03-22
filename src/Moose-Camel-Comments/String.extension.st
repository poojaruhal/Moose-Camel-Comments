Extension { #name : #String }

{ #category : #'*Moose-Camel-Comments' }
String >> gtInspectorParsedCommentIn: aComposite [
	<gtInspectorPresentationOrder: 30>
	
	^ aComposite fastList
		title: 'Parsed';
		display: [ MccSmalltalkInCommentParser parse: self ]
]

{ #category : #'*Moose-Camel-Comments' }
String >> isWordContraction [
	| contractions |
	
	contractions := '(m[ |.]|re[ |.]|s[ |.]|t[ |.]|ve[ |.]|ll[ |.]|d[ |.])'.

	^ self matchesRegex: contractions
]

{ #category : #'*Moose-Camel-Comments' }
String >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ (self
		ifEmpty: [ MccEmptyComment ]
		ifNotEmpty: [ MccTextComment ]) of: self
]
