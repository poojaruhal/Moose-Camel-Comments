accessing
stopwords
	"Split and return a collection of stopwords (with possible duplications) in this comment"
	<return: #Collection of: #MccWord>

	^ self words select: #isStopword