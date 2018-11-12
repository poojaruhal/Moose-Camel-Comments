accessing
string
	^ ('[[[' asParser / ']]]' asParser ) negate star flatten trim