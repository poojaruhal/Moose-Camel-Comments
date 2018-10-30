searching
findExactReferencesIn: aSentence
	"Find and return exact class references"
	<return: #Collection of: #MccReference>
	| directlyReferencedClasses |

	directlyReferencedClasses := Array streamContents: [ :aStream | 
		aSentence words do: [ :eachWord |
			self environment
				classNamed: eachWord asSymbol
				ifFound: [ :aClass | aStream nextPut: aClass ]
				ifNone: [  ] ] ].
		
	^ directlyReferencedClasses collect: [ :aClass | MccClassReference new artefact: aClass ]