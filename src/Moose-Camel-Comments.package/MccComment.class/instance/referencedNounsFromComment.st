gt-examples
referencedNounsFromComment
	<return: #Array of: #ReferencedClass>
			
	self sentencesFromComment.
	^ self sentences 
			flatCollect: [ :eachSentence | 
				 ((MccSentenceProcessor fromSentence: eachSentence) splitIntoNouns) asArray].