gt-examples
referencedClassesFromComment
	<return: #Array of: #ReferencedClass>
				
				self sentencesFromComment.
				^ self sentences 
					collect: [ :eachSentence | 
						 eachSentence splitIntoNouns asArray].