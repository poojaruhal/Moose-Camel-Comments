gt-inspector-extension
gtInspectorSentencesIn: aComposite
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite fastList
		title: 'Sentences' translated;
		display: [ self sentences ]