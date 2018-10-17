as yet unclassified
collectReferenceClassesFromComment

	|referencedNounsFromComment otherCommonClassesFromComment systemSubjects|
	"Collect all the nouns"
	referencedNounsFromComment:= self referencedNounsFromComment.
	otherCommonClassesFromComment:= OrderedCollection new.
	systemSubjects:= MccClassGoal new systemSubjects.

	referencedNounsFromComment do:[:eachNoun |
		|noun|
		noun := eachNoun noun.
		(noun beginsWithAnyOf:(MccPackageEnvironment new prefix))
		ifTrue:[
			referencedClasses add:noun.]
		ifFalse:[
			(systemSubjects includes: noun)
				ifTrue:[otherCommonClassesFromComment add:noun]
			]].
	
		^ referencedClasses
