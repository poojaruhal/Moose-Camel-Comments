Extension { #name : #Object }

{ #category : #'*Moose-Camel-Comments' }
Object >> gtInspectorMccCommentReferencesIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 40>
	
	^ aComposite
		composite: [ :aTabbedComposite |
			| pragmas mccComment |
	
			mccComment := self mccComment.
		
			aTabbedComposite title: 'Comment'.
			aTabbedComposite when: [ (mccComment isKindOf: MccEmptyComment) not ].
			aTabbedComposite
				act: [ mccComment inspect ]
				iconName:  #smallInspectIt
				entitled: 'Inspect'.
			
			pragmas := Pragma
				allNamed: aGTInspector class extensionsPragma
				from: mccComment class
				to: MccComment
				sortedUsing: [ :x :y | (x argumentAt: 1) < (y argumentAt: 1) ].
			pragmas := pragmas select: [ :aPragma | aGTInspector shouldDisplayPresentationCreatedBy: aPragma method ].
			mccComment gtInspectorPresentationsFromPragmas: pragmas In: aTabbedComposite inContext: aGTInspector ]
]

{ #category : #'*Moose-Camel-Comments' }
Object >> mccComment [
	"Return a comment of this object if applicable"
	<return: #MccComment>

	^ MccEmptyComment of: self
]
