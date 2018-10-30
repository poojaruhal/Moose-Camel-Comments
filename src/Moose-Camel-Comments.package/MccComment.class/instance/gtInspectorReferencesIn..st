gt-inspector-extension
gtInspectorReferencesIn: aComposite
	<gtInspectorPresentationOrder: 2>
	
	^ aComposite fastList
		title: 'References' translated;
		display: [ self references ]