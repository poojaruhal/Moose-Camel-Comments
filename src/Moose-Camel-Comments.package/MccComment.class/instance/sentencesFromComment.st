accessing
sentencesFromComment
	<return: #Collection of: #MccSentence>
	
	 ^ self sentences:
			((MccClassCommentProcessor fromComment: self comment)
					splitIntoSentences).
