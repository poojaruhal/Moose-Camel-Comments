gt-examples
collectReferenceClasses
<gtExample>
<description:'Collect  referenc classes  from classs comment'>

	^ self allClassesWithComments collect: [ :eachClass |
	|mccComment sentences| 
	mccComment := MccComment fromClass: eachClass.
	sentences := mccComment sentencesFromComment sentences.
	sentences collect: [ :eachSentence | 
		|nouns referencedNounsInComment |
		nouns:= eachSentence splitIntoNouns asArray.
		referencedNounsInComment := self allClassesOfCompilerPackageAsSymbols intersection: nouns.
		 ]
	 ]
