private - testing
isGlobal: aRBNode
	^ aRBNode isVariable
		and: [ self class environment includesKey: aRBNode name ]