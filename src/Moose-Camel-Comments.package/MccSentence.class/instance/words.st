accessing
words
	<return: #Collection of: #MccWord>
	
	^ Array streamContents: [ :aStream | 
		| aCommentString |
		(aCommentString := self asString)
			splitOn: [ :eachChar | (eachChar isDigit or: [ eachChar isLetter ]) not ]
			indicesDo: [ :start :end |
				| aWord anOffset aString |
				aString := aCommentString copyFrom: start to: end.
				anOffset := (interval first - 1) max: 0.
				aWord := MccWord string: aString.
				aWord interval: (start + anOffset to: end + anOffset).
				aStream nextPut: aWord ] ]