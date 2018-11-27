as yet unclassified
gtInspectorValidPartIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	^ (self filteredAST gtInspectorSourceCodeIn: aComposite)
		title: 'Filtered'