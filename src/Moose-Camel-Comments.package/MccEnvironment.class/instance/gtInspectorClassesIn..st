gt-inspector-extension
gtInspectorClassesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite table
		title: 'Classes' translated;
		display: [ self allClasses ]