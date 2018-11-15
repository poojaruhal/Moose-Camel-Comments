accessing
text 
	^ (string, ('[[[' asParser, string , ']]]' asParser) ==> [ :aToken |  { aToken first } ]) star.