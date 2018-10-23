private
splitIntoSentences
	| sentences | 
	
	sentences:= self comment splitOn: $. asString.
	sentences:= sentences select: #isNotEmpty.
	
	^ sentences
	
	