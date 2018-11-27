*Moose-Camel-Comments
gtInspectorParsedCommentIn: aComposite
	<gtInspectorPresentationOrder: 30>
	
	^ aComposite fastList
		title: 'Parsed';
		display: [ MccSmalltalkInCommentParser parse: self ]