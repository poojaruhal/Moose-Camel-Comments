ui
gtInspectorPackagesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastList
		title: 'Packages';
		display: [ self packages ]