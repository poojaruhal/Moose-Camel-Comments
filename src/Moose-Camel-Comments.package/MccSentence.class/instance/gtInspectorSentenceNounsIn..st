as yet unclassified
gtInspectorSentenceNounsIn: aComposite
	<gtInspectorPresentationOrder: 2>

	^ aComposite list
			title: 'List of Noun Words';
			display: [MccSentenceProcessor fromSentence:( self sentence)splitIntoNouns].