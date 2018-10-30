printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Reference to ';
		print: artefact