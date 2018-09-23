accessing
sentencesFromComment
	
	 ^ self sentences:((MccClassCommentProcessor new)
					comment: self comment;
					splitIntoSentences).
