gt-examples
collectReferencedClassesFromAllClassesComment
	<gtExample>
	<description:'Collect  referenc classes  from classs comment'>
	| referncedClassesByAllMethods classesReferencedFromComment |
	
	referncedClassesByAllMethods := self allClassesOfSelectedPackageAsSymbols.
	classesReferencedFromComment :=
		self allClassesWithComments
			flatCollect: [ :eachClass |
				|mccComment sentences | 
				mccComment := MccComment fromClass: eachClass.
				sentences := mccComment sentencesFromComment sentences.

				sentences
					flatCollect: [ :eachSentence | 
						| nouns |
						"nouns: ({'brick'.'block'.'blelement' })."
						nouns:= (MccSentenceProcessorExamples new splitIntoNouns) asArray.
						referncedClassesByAllMethods intersection: nouns] ]
			as: Set.

	^ classesReferencedFromComment
