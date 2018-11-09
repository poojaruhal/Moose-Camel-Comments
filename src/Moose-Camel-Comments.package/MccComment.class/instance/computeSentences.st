private
computeSentences
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>

	^ Array streamContents: [ :aStream | 
		| aCommentString |
		(aCommentString := self asString)
			splitOn: String cr
			indicesDo: [ :start :end |
				| aString |
				aString := aCommentString copyFrom: start to: end.
				aString ifNotEmpty: [
					aStream nextPut: (MccSentence new string: aString interval: (start to: end)) ] ] ]