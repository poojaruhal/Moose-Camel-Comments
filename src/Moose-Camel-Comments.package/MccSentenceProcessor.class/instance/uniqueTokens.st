converting
uniqueTokens
	|aCoreResponse|
	
	aCoreResponse := self coreNlpResponse: self sentence.
	^ aCoreResponse tokens uniqueTokens.
	
	