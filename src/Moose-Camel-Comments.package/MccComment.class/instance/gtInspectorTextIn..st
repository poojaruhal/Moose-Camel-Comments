gt-inspector-extension
gtInspectorTextIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
			title: 'Text' translated;
			display: [ self asString ]