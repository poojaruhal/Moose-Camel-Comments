private-accessing
words
	<return:#Array of:#MccWords>
	
	^ words ifNil: [ words := self createWords ]