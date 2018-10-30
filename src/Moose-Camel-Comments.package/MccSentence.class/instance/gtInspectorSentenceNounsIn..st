gt-inspector-extension
gtInspectorSentenceNounsIn: aComposite
	<gtInspectorPresentationOrder: 3>

	^ aComposite list
			title: 'List of Noun Words';
			display: [MccSentenceProcessor fromSentence:( self sentence)splitIntoNouns].