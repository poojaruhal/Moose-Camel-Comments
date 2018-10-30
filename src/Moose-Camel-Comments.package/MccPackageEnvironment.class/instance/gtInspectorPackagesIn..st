gt-inspector-extension
gtInspectorPackagesIn: aComposite
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Packages' translated;
		display: [ self packages ];
		format: #name