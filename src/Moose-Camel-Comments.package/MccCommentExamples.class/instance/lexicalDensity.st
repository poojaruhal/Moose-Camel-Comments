as yet unclassified
lexicalDensity
	<gtExample>
	<description: 'collect lexical density of a comment of class MccComment'>
	|aCollectionOfSentenceLexicalDensity|
	
	aCollectionOfSentenceLexicalDensity := self sentences collect:[:eachSentence | eachSentence isNotNil
		ifTrue:[eachSentence lexicalDensity]].

	^ ((aCollectionOfSentenceLexicalDensity sum)/(aCollectionOfSentenceLexicalDensity size)).
	
	