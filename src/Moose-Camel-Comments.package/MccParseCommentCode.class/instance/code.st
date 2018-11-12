accessing
code 
	^ (string, '[[[' asParser, string , ']]]' asParser, string  ==> [ :aToken | aToken third ]) star.