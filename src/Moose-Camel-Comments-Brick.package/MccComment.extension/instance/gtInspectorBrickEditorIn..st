*Moose-Camel-Comments-Brick
gtInspectorBrickEditorIn: aComposite
	<gtInspectorPresentationOrder: 4>

	^ aComposite blocText
		title: 'Live' translated;
		display: [
			| theReferences aText |
			theReferences := self references.
			aText := self asString asRopedText.
			theReferences do: [ :eachReference |
				| aSubText |
				aSubText := aText from: eachReference from to: eachReference to.
				eachReference style: aSubText.
				aSubText attributes: {
					BrTextClickAttribute new 
						beNotOverwritableByStyler;
						action: [ :clickedText :aTarget :anEvent | eachReference browseDueTo: anEvent ] } ].
				aText ]