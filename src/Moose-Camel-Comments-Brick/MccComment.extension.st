Extension { #name : #MccComment }

{ #category : #'*Moose-Camel-Comments-Brick' }
MccComment >> gtInspectorBrickEditorIn: aComposite [
	<gtInspectorPresentationOrder: 4>

	^ aComposite blocText
		title: 'Live' translated;
		display: [ self gtViewText ]
]

{ #category : #'*Moose-Camel-Comments-Brick' }
MccComment >> gtViewText [
	<return: #BlText>
	| theReferences aText codeSnippets |

	theReferences := self references.
	aText := self asString asRopedText.
	theReferences do: [ :eachReference |
		| aSubText |
		aSubText := aText from: eachReference from to: eachReference to.
		eachReference style: aSubText.
		aSubText attributes: {
			BrTextClickAttribute new 
				beNotOverwritableByStyler;
				action: [ :clickedText :aTarget :aTextEditor :anEvent | eachReference browseDueTo: anEvent ] } ].
		
	codeSnippets := MccSmalltalkInCommentParser parse: self asString.
	codeSnippets do: [ :eachToken | eachToken codeDo: [ :aCodeToken |
		| aSubText |
		aSubText := aText from: eachToken start to: eachToken stop.
		aSubText
			replacingAdornment: [
				BrEditorElement new
					margin: (BlInsets all: 10);
					padding: (BlInsets all: 10);
					editor: (BrTextEditor new
						styler: (BrRBTextStyler new);
						text: aSubText asString asRopedText monospace);
					background: (Color white);
					look: BrShadowLook;
					constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical matchParent.
						c textFlow pushLine ] ] ] ].

	^ aText
]

{ #category : #'*Moose-Camel-Comments-Brick' }
MccComment >> gtViewTextIn: aView [
	<gtView>

	^ aView textEditor
		title: 'Camel';
		priority: 0;
		text: [ self gtViewText ]
]
