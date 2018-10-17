ui
gtInspectorPackagesIn: aComposite
	<gtInspectorPresentationOrder: 0>

	^ aComposite table
		title: 'Packages';
		display: [( self packagesAsSymbols) asOrderedCollection]