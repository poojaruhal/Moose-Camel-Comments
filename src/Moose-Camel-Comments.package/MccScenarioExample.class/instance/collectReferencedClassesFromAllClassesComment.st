gt-examples
collectReferencedClassesFromAllClassesComment
	<gtExample>
	<description:'Collect  referenc classes  from classs comment'>
	
	| referncedClassesByAllMethods classesReferencedFromComment |
	
	referncedClassesByAllMethods := self allClassesOfCompilerPackageAsSymbols.
	classesReferencedFromComment :=
		self allClassesWithComments collect: [ :eachClass |
			|mccComment sentences | 
			mccComment := MccComment fromClass: eachClass.
			sentences := mccComment sentencesFromComment sentences.
			
			sentences flatCollect: [ :eachSentence | 
				| nouns |
				nouns:= eachSentence splitIntoNouns asArray.
				referncedClassesByAllMethods intersection: nouns.]
	 ].

	^ classesReferencedFromComment
