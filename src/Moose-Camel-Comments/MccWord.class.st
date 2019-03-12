"
I represent a word in a sentense
"
Class {
	#name : #MccWord,
	#superclass : #Object,
	#instVars : [
		'string',
		'interval'
	],
	#category : 'Moose-Camel-Comments-Model - Text'
}

{ #category : #'instance creation' }
MccWord class >> string: aString [
	^ self new string: aString
]

{ #category : #comparing }
MccWord >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ string = anObject string
]

{ #category : #accessing }
MccWord >> asString [
	^ self string
]

{ #category : #accessing }
MccWord >> asSymbol [
	^ self string asSymbol
]

{ #category : #comparing }
MccWord >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ string hash
]

{ #category : #initialization }
MccWord >> initialize [
	super initialize.
	
	
]

{ #category : #accessing }
MccWord >> interval [
	^ interval
]

{ #category : #accessing }
MccWord >> interval: anObject [
	interval := anObject
]

{ #category : #testing }
MccWord >> isEmpty [
	
	^self string size = 0
]

{ #category : #testing }
MccWord >> isNotEmpty [
	
	^ self isEmpty not
]

{ #category : #testing }
MccWord >> isPronoun [

	^ self pronouns includes:(self string) asLowercase.
]

{ #category : #testing }
MccWord >> isPronoun:aWord [
	
	^ self pronouns includes:aWord asLowercase.
]

{ #category : #testing }
MccWord >> isStopword [

	^ self stopwords includes:(self string) asLowercase.
]

{ #category : #testing }
MccWord >> isStopword:aWord [
	
	^ self stopwords includes:aWord asLowercase.
]

{ #category : #printing }
MccWord >> printOn: aStream [
	aStream print: self string
]

{ #category : #'as yet unclassified' }
MccWord >> pronouns [
	"list of stopwords"
	
	^ #( 'i' 'me' 'myself' 'mine' 'my' 'we' 'we''d' 'we''ll' 'we''re' 'we''ve' 'us' 'ourselves' 'ourself' 'ours' 'our' 'he' 'he''d' 'he''ll' 'he''s' 'her' 'hers' 'herself' 'him' 'himself' 'his' 'it' 'it''s' 'its' 'itself' 'she' 'she''d' 'she''ll' 'she''s' 'their' 'theirs' 'them' 'themselves' 'they' 'they''d' 'they''ll' 'they''re' 'they''ve' 'youd' 'youll' 'youre' 'youve' 'you' 'you''d' 'you''ll' 'you''re' 'you''ve' 'your' 'yours' 'yourself' 'yourselves' '###' 'its' 'theyll' 'theyre' 'theyve' 'whats' 'whos' 'what' 'what''s' 'which' 'who' 'who''s' 'whom' 'whose')
]

{ #category : #'as yet unclassified' }
MccWord >> stopwords [
	"list of stopwords"
	
	^ #( '!!' '?!' '??' '!?' '`' '``' '''''' '-lrb-' '-rrb-' '-lsb-' '-rsb-' ',' '' ':' ';' '"' '''' '?' '<' '>' '{' '}' '[' ']' '+' '-' '(' ')' '&' '%' '$' '@' '!' '^' '#' '*' '' '' '''ll' '''s' '''m' 'a' 'about' 'above' 'after' 'again' 'against' 'all' 'am' 'an' 'and' 'any' 'are' 'aren''t' 'as' 'at' 'be' 'because' 'been' 'before' 'being' 'below' 'between' 'both' 'but' 'by' 'can' 'can''t' 'cannot' 'could' 'couldn''t' 'did' 'didn''t' 'do' 'does' 'doesn''t' 'doing' 'don''t' 'down' 'during' 'each' 'few' 'for' 'from' 'further' 'had' 'hadn''t' 'has' 'hasn''t' 'have' 'haven''t' 'having' 'he' 'he''d' 'he''ll' 'he''s' 'her' 'here' 'here''s' 'hers' 'herself' 'him' 'himself' 'his' 'how' 'how''s' 'i' 'i''d' 'i''ll' 'i''m' 'i''ve' 'if' 'in' 'into' 'is' 'isn''t' 'it' 'it''s' 'its' 'itself' 'let''s' 'me' 'more' 'most' 'mustn''t' 'my' 'myself' 'no' 'nor' 'not' 'of' 'off' 'on' 'once' 'only' 'or' 'other' 'ought' 'our' 'ours ' 'ourselves' 'out' 'over' 'own' 'same' 'shan''t' 'she' 'she''d' 'she''ll' 'she''s' 'should' 'shouldn''t' 'so' 'some' 'such' 'than' 'that' 'that''s' 'the' 'their' 'theirs' 'them' 'themselves' 'then' 'there' 'there''s' 'these' 'they' 'they''d' 'they''ll' 'they''re' 'they''ve' 'this' 'those' 'through' 'to' 'too' 'under' 'until' 'up' 'very' 'was' 'wasn''t' 'we' 'we''d' 'we''ll' 'we''re' 'we''ve' 'were' 'weren''t' 'what' 'what''s' 'when' 'when''s' 'where' 'where''s' 'which' 'while' 'who' 'who''s' 'whom' 'why' 'why''s' 'with' 'won''t' 'would' 'wouldn''t' 'you' 'you''d' 'you''ll' 'you''re' 'you''ve' 'your' 'yours' 'yourself' 'yourselves' '###' 'return' 'arent' 'cant' 'couldnt' 'didnt' 'doesnt' 'dont' 'hadnt' 'hasnt' 'havent' 'hes' 'heres' 'hows' 'im' 'isnt' 'its' 'lets' 'mustnt' 'shant' 'shes' 'shouldnt' 'thats' 'theres' 'theyll' 'theyre' 'theyve' 'wasnt' 'were' 'werent' 'whats' 'whens' 'wheres' 'whos' 'whys' 'wont' 'wouldnt' 'youd' 'youll' 'youre' 'youve' )
]

{ #category : #accessing }
MccWord >> string [
	^ string
]

{ #category : #accessing }
MccWord >> string: aString [
	self string: aString interval: (1 to: aString size - 1)
]

{ #category : #accessing }
MccWord >> string: aString interval: anInterval [
	string := aString.
	interval := anInterval
]
