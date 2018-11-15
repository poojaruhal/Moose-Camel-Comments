accessing
code 
	^ '[[[' asPParser, string, ']]]' asPParser  ==> [ :aToken | aToken second as: String ]