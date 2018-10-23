accessing
tokens
	|aCoreResponse|
	
	aCoreResponse := self coreNlpResponse: self sentence.
	^ aCoreResponse tokens.
	
	