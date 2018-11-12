accessing
code 
	^ (string, '[[[' asParser, string , ']]]' asParser  ==> [ :aToken | aToken third ]) star.