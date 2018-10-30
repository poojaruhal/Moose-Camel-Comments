instance creation
of: anObject
	<return: #MccComment>

	^ (self hasComment: anObject)
		ifTrue: [ self basicNew initialize initializeWith: anObject ]
		ifFalse: [ MccEmptyComment of: anObject ]