*Moose-Camel-Comments-Brick
gtViewText
	<return: #BlText>
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
	^ aText