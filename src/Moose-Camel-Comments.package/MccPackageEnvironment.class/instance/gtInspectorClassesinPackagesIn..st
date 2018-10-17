ui
gtInspectorClassesinPackagesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite table
		title: 'Classes';
		display: [ self allDefinedClasses].