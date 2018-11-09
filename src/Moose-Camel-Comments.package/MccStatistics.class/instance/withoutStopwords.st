private-accessing
withoutStopwords
	<return:#Array of:#MccWords>
		
	^ self words reject: #isStopword.