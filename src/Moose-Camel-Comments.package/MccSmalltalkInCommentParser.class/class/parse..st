parsing
parse: aString
	| theSnippets aStringToSplit  |

	aString
		ifEmpty: [ ^ aString ].

	aStringToSplit := ({ Character cr . Character lf } includes: aString last)
		ifTrue: [ aString ]
		ifFalse: [ aString, String cr ]. 

	theSnippets := aStringToSplit splitOn: ('(\',String cr,'|\', String lf, ')[\s|\-]*(\',String cr,'|\', String lf, ')') asRegex.

	^ theSnippets flatCollect: [ :eachSnippet |
		Array streamContents: [ :aStream |
			| result stringToParse |
			
			stringToParse := eachSnippet.
			result := (MccSmalltalkInCommentParser new sea) parse: stringToParse.
			
			[ result isNotEmpty and: [ stringToParse isNotEmpty ] ] whileTrue: [
				aStream nextPut: (result first as: String).
				aStream nextPut: (result second).
				stringToParse := result third as: String.
				result := (MccSmalltalkInCommentParser new sea) parse: stringToParse ] ] ]