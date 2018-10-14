accessing
nouns
	<gtExample>
	<description: 'collect nouns from a sentence'>
	
	| nouns aSentence |
	
	aSentence := self sentence.
	nouns := aSentence splitAndCollectAsOrderedCollection.
	
	^ nouns.