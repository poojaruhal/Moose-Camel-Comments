searching
findExactReferencesIn: aSentence
	"Find and return exact class references"
	<return: #Collection of: #MccReference>

	^ Array streamContents: [ :aStream | 
		aSentence words do: [ :eachWord |
			classOrMetaclass
				classAndMethodFor: eachWord asSymbol
				do: [ :c :aMethod | aStream nextPut: (MccMethodReference new
					interval: eachWord interval;
					artefact: aMethod) ]
				ifAbsent: [] ] ]