accessing
text 
	^ (string, ('[[[' asParser, string , ']]]' asParser), string  ==> [ :aToken |  { aToken first . aToken third } ]) star.