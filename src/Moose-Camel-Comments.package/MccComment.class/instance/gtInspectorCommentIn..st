gt-inspector-extension
gtInspectorCommentIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
			title: 'Comment' translated;
			display: [ self asString ]