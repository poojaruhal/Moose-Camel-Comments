accessing
sentences
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>

	^ sentences ifNil: [ sentences := self computeSentences ]