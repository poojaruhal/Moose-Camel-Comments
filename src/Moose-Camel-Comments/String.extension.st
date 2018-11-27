Extension { #name : #String }

{ #category : #'*Moose-Camel-Comments' }
String >> gtInspectorParsedCommentIn: aComposite [
	<gtInspectorPresentationOrder: 30>
	
	^ aComposite fastList
		title: 'Parsed';
		display: [ MccSmalltalkInCommentParser parse: self ]
]

{ #category : #'*Moose-Camel-Comments' }
String >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ MccTextComment of: self
]
