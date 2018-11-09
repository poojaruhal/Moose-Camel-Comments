private-accessing
createWords
	<return:#Array of:#MccWords>
	
	^ (self lines flatCollect: #words) reject: #isEmpty.