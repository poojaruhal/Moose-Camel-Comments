gt-inspector-extension
gtInspectorWordsIn: aComposite
	<gtInspectorPresentationOrder: 2>

	^ aComposite fastList
		title: 'Words' translated;
		display: [  self words ]