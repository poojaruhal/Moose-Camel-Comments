accessing
sentencesFromComment
	<return: #Collection of: #MccSentence>
	
	 ^ self sentences:((MccClassCommentProcessor new)
					comment: self comment;
					splitIntoSentences).
