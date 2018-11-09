private
computeWords
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccWord>

	^ (self sentences flatCollect: #words) reject: #isEmpty