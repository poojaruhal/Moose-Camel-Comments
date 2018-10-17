printing
printOn: aStream
	aStream
		nextPutAll: 'Comment of ';
		nextPutAll: self commentClass name