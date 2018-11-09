as yet unclassified
gtInspectorallClassesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastList
		title: 'Classes';
		display: [ self ];
		format: [ :eachClass | eachClass printString ]