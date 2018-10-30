printing
printOn: aStream
	aStream
		nextPutAll: 'Comment of ';
		nextPut: $(;
		nextPutAll: self artefact asString;
		nextPut: $)