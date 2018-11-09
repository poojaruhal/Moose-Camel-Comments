accessing
words
	"Split and return a collection of words in this comment"
	<return: #Collection of: #MccSentence>

	^ words ifNil: [ words := self computeWords ]