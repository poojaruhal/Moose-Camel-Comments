accessing
sentences
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>
	| theSentences |

	theSentences := (self asString splitOn: $. asString) select: #isNotEmpty.
	^ theSentences collect: [ :eachSentenceString | MccSentence fromSentence: eachSentenceString ]