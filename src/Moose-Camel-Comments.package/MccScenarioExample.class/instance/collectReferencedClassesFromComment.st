gt-examples
collectReferencedClassesFromComment
	<gtExample>
	<description:'Collect  referenc classes  of a classs comment'>
	
	| mccComment referncedClassesByAllMethods sentences classesReferencedFromComment |

	mccComment := MccCommentExamples new.
	referncedClassesByAllMethods := mccComment referencedClassesFromProject.
	referncedClassesByAllMethods := referncedClassesByAllMethods collect:
		[:eachClass | eachClass name asLowercase asSymbol].
	sentences := mccComment sentences.
	classesReferencedFromComment:= sentences flatCollect:[ :aSentence  | 
		| nouns |
		nouns := aSentence splitIntoNouns asArray.
		nouns intersection: referncedClassesByAllMethods ].
	
	^ classesReferencedFromComment

