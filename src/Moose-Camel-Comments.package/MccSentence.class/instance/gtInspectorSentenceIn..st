gt-inspector-extension
gtInspectorSentenceIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
		title: 'Sentence' translated;
		display: [  self asString ]