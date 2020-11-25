"
I represent a comment of some code artefact.



//TODO

I use information from MccClasses.

I know  comment, class of the comment.
My aim is to collect maximum information from a comment. 
I can collect potential reference classes from comment.
I am composed of sentences.
I collect actual classes referenced my commentClass and potential classes from comment text.
Once I have both the information, I can compare the inconsistency.

    Instance Variables
	comment:		<Object>
	commentClass:		<Object>
	prefixOfPackage:		<Object>
	referencedClasses:		<Object>
	sentences:		<Object>.
			

Reimplement the following in Pharo to split text in sentences

import re
alphabets= ""([A-Za-z])""
prefixes = ""(Mr|St|Mrs|Ms|Dr)[.]""
suffixes = ""(Inc|Ltd|Jr|Sr|Co)""
starters = ""(Mr|Mrs|Ms|Dr|He\s|She\s|It\s|They\s|Their\s|Our\s|We\s|But\s|However\s|That\s|This\s|Wherever)""
acronyms = ""([A-Z][.][A-Z][.](?:[A-Z][.])?)""
websites = ""[.](com|net|org|io|gov)""

def split_into_sentences(text):
    text = "" "" + text + ""  ""
    text = text.replace(""\n"","" "")
    text = re.sub(prefixes,""\\1<prd>"",text)
    text = re.sub(websites,""<prd>\\1"",text)
    if ""Ph.D"" in text: text = text.replace(""Ph.D."",""Ph<prd>D<prd>"")
    text = re.sub(""\s"" + alphabets + ""[.] "","" \\1<prd> "",text)
    text = re.sub(acronyms+"" ""+starters,""\\1<stop> \\2"",text)
    text = re.sub(alphabets + ""[.]"" + alphabets + ""[.]"" + alphabets + ""[.]"",""\\1<prd>\\2<prd>\\3<prd>"",text)
    text = re.sub(alphabets + ""[.]"" + alphabets + ""[.]"",""\\1<prd>\\2<prd>"",text)
    text = re.sub("" ""+suffixes+""[.] ""+starters,"" \\1<stop> \\2"",text)
    text = re.sub("" ""+suffixes+""[.]"","" \\1<prd>"",text)
    text = re.sub("" "" + alphabets + ""[.]"","" \\1<prd>"",text)
    if ""”"" in text: text = text.replace("".”"",""”."")
    if ""\"""" in text: text = text.replace("".\"""",""\""."")
    if ""!"" in text: text = text.replace(""!\"""",""\""!"")
    if ""?"" in text: text = text.replace(""?\"""",""\""?"")
    text = text.replace(""."","".<stop>"")
    text = text.replace(""?"",""?<stop>"")
    text = text.replace(""!"",""!<stop>"")
    text = text.replace(""<prd>"",""."")
    sentences = text.split(""<stop>"")
    sentences = sentences[:-1]
    sentences = [s.strip() for s in sentences]
    return sentences
"
Class {
	#name : #MccComment,
	#superclass : #Object,
	#instVars : [
		'artefact',
		'sentences',
		'words',
		'code',
		'text',
		'statistics',
		'lemmas',
		'templateSections'
	],
	#category : #'Moose-Camel-Comments-Model - Comment'
}

{ #category : #'instance creation' }
MccComment class >> fromClass: aClass [
	^ self of: aClass
]

{ #category : #testing }
MccComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
MccComment class >> new [
	self error: 'Use one of: instead'
]

{ #category : #'instance creation' }
MccComment class >> of: anObject [
	<return: #MccComment>

	^ (self hasComment: anObject)
		ifTrue: [  self basicNew initialize initializeWith: anObject ]
		ifFalse: 	[ MccEmptyComment of:anObject ]
]

{ #category : #accessing }
MccComment >> artefact [
	"Return a code artefact whose comment I represent"
	<return: #Object>

	^ artefact
]

{ #category : #accessing }
MccComment >> artefact: anObject [
	"anObject can be nil"

	artefact := anObject
]

{ #category : #converting }
MccComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MccComment >> classificationOnBasisOfParagraph [
	^ self sentences size = 0
		ifTrue: [ #empty ]
		ifFalse: [ self sentences size = 1
				ifTrue: [ #oneSentence ]
				ifFalse: [ (self artefact trimBoth lines anySatisfy: #isEmpty)
						ifTrue: [ #multiParagraph ]
						ifFalse: [ #oneParagraph ] ] ]
]

{ #category : #accessing }
MccComment >> code [
	"returns array of code tokens from comment"
	| aParser aParsedString theTokens |

	aParser := MccSmalltalkInCommentParser.
	aParsedString := aParser parse: self asString.
	theTokens := (aParsedString isEmptyOrNil) ifTrue: [ '' ] ifFalse: [aParsedString textAndCodeTokens].
	code := theTokens select: [ :eachToken | 
		eachToken isCode ].
	^ code
]

{ #category : #private }
MccComment >> computeSentences [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>
	| counter |
	counter := 0.
	
	^ Array streamContents: [ :aStream | 
		| aCommentString |
		(aCommentString := self computeSentencesWithRegex)
			splitOn: '<stop>'
			indicesDo: [ :start :end |
				| aString computedStart computedEnd |
				computedStart := start - (6*counter).
				computedEnd := end - (6*counter).
				counter := counter + 1.
				aString := aCommentString copyFrom: start to: end.
				aString trim ifNotEmpty: [
					aStream nextPut: (MccSentence new string: aString interval: (computedStart to: computedEnd)) ] ] ]
]

{ #category : #private }
MccComment >> computeSentencesWithRegex [
"return a new version of comment with indicators on where to split"
	| alphabets prefixes suffixes numbers starters acronyms websites sentenceEndings textToSplit |
	alphabets := '([A-Za-z])'.
	prefixes := '(Mr|St|Mrs|Ms|Dr|etc|resp)[.]'.
	suffixes := '(Inc|Ltd|Jr|Sr|Co)'.
	numbers := '(\d+)[.]'.
	starters := 	'(Mr|Mrs|Ms|Dr|He\s|She\s|It\s|They\s|Their\s|Our\s|We\s|But\s|However\s|That\s|This\s|Wherever)'.
	acronyms := '([A-Za-z][.][A-Za-z][.]([A-Za-z][.])?)'.
	websites := '[.](com|net|org|io|gov)'.
	sentenceEndings := '(\.|\?|\!)+'.

	textToSplit := self asString.
	textToSplit := '', textToSplit, ''.
	textToSplit := textToSplit copyWithRegex: '(\',String cr,'|\', String lf, ')' matchesReplacedWith: ' <stop>'.
	textToSplit := textToSplit copyWithRegex: prefixes matchesTranslatedUsing: [:each | each copyReplaceAll: '.' 	with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: websites matchesTranslatedUsing: [:each | each copyReplaceAll: '.' 	with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: (acronyms, ' ', starters) matchesTranslatedUsing: [:each | each 	copyReplaceAll: '. ' with: '.<stop> '].
	textToSplit := textToSplit copyWithRegex: acronyms matchesTranslatedUsing: [:each | each copyReplaceAll: '.' 	with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: ('\s', alphabets, '[.] ') matchesTranslatedUsing: [:each | each 	copyReplaceAll: '.' with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: (' ', suffixes, '[.] ', starters) matchesTranslatedUsing: [:each | each 	copyReplaceAll: '. ' with: '.<stop> '].
	textToSplit := textToSplit copyWithRegex: (' ', suffixes, '[.]') matchesTranslatedUsing: [:each | each 	copyReplaceAll: '.' with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: (' ', alphabets, '[.]') matchesTranslatedUsing: [:each | each 	copyReplaceAll: '.' with: '<prd>'].
	textToSplit := textToSplit copyWithRegex: numbers matchesTranslatedUsing: [:each | each copyReplaceAll: '.' 	with: '<prd>'].

	textToSplit := textToSplit copyReplaceAll: '?''' with: '''?'.
	textToSplit := textToSplit copyReplaceAll: '.''' with: '''.'.
	textToSplit := textToSplit copyReplaceAll: '!''' with: '''!'.
	textToSplit := textToSplit copyReplaceAll: '...''' with: '''...'.
	textToSplit := textToSplit copyReplaceAll: '?"' with: '"?'.
	textToSplit := textToSplit copyReplaceAll: '."' with: '".'.
	textToSplit := textToSplit copyReplaceAll: '!"' with: '"!'.
	textToSplit := textToSplit copyReplaceAll: '..."' with: '"...'.

	textToSplit := textToSplit copyWithRegex: sentenceEndings matchesTranslatedUsing: [:each | each, '<stop>'].

	textToSplit := textToSplit copyReplaceAll: '<prd>' with: '.'.

	"splitArray := text splitOn: '<stop>'.
	splitArray remove: (sentences last).
	sentences := splitArray collect: [ :each | each trim ]."
	^ textToSplit
]

{ #category : #private }
MccComment >> computeWords [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccWord>

	^ (self sentences flatCollect: #words) reject: #isEmpty
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorCodeSnippetsIn: aComposite [
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite fastList
		title: 'Code Snippets' translated;
		display: [ self code ];
		when: [  self code isNotEmpty ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorMccCommentReferencesIn: aComposite inContext: aGTInspector [
	"Override extension from Object to break infinite recursion"
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorReferencesIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ aComposite fastList
		title: 'References' translated;
		display: [ self references ];
		when: [  self references isNotEmpty ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorSentencesIn: aComposite [
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite fastList
		title: 'Sentences' translated;
		display: [ self sentences ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorStatisticsIn: aComposite [
	<gtInspectorPresentationOrder: 1>
	^ aComposite table
		title: 'Linguistic Overview' translated;
		display: [ self metrics associations ];
		beMultiple;
		column: 'Metric' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorTextIn: aComposite [
	"<gtInspectorPresentationOrder: 3>"
	
	^ aComposite fastList
		title: 'Text' translated;
		display: [ self text ];
		when: [  self text isNotEmpty ]
]

{ #category : #'as yet unclassified' }
MccComment >> hasNegative [
	^ self negativeSentences isNotEmpty
]

{ #category : #'as yet unclassified' }
MccComment >> hasTemplateStyle [

	^ self matchedTemplateSections isNotEmpty.
]

{ #category : #'as yet unclassified' }
MccComment >> hasWarnings [
	^ self warningSentences isNotEmpty
]

{ #category : #initialization }
MccComment >> initializeWith: anObject [
	"Initialize this comment with a given code artefact that depends on the comment type
	For example class comment must be initialized with a Class while method comments with a compiled method"

	self artefact: anObject
]

{ #category : #testing }
MccComment >> isEmpty [
	<return: #Boolean>
	
	^ self asString isEmpty
]

{ #category : #testing }
MccComment >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #copying }
MccComment >> lemmas [
	"collect lemmas from McCoreResonse"
	<return:#Set of: #MccWord>

	lemmas ifNil: [lemmas := (self sentences flatCollect: [  :aSentence |
		|aResponse mccCoreResponsetokens aSet|
		
		aResponse := McCoreResponse queryService: (aSentence asString).
		mccCoreResponsetokens := aResponse tokens.
		aSet := ((mccCoreResponsetokens lemmas) asSet) reject: [:aWord |
		 (MccWord string:aWord) isPunctuation].
		aSet collect:[:aWord | MccWord string:aWord].
	]) asSet].

	^ lemmas
]

{ #category : #'as yet unclassified' }
MccComment >> matchTemplateStyle [
	 
	templateSections := OrderedCollection new.
	
	templateSections := {  
	'Intent' -> (self sentences select:#hasIntentWords).
	'Responsibility' -> (self sentences select:#hasResponsibilityWords).
	'Collaborators' -> (self sentences select:#hasColloborators).
	'PublicAPI' -> (self sentences select:#hasPublicAPIs).
	'Example' -> (self sentences select:#hasExampleWords).
	'InternalRepresenation' -> (self sentences select:#hasImplementationWords).
	'InstanceVariable' -> (self sentences select:#hasInstanceVariableWords)
	}asDictionary.

	^ (self templateSections select: [ :each | each value isNotEmpty]) isNotEmpty
]

{ #category : #'as yet unclassified' }
MccComment >> matchedTemplateSections [

	^ self templateSections reject:[:each | each value isEmpty].

]

{ #category : #'as yet unclassified' }
MccComment >> meanPronouns [
	<return: #Number>
	|upperBound averagePronouns isPersonal pron|
	upperBound := 5.
	averagePronouns :=  ((self pronouns size * 100) / self words size) asFloat truncated.
	pron := self pronouns collect: [ :e | e asString asSymbol ].
	isPersonal := ((pron includes: #I) or: [ pron includes: #i ]).
	((averagePronouns > upperBound) and: [isPersonal])
	ifTrue: [ ^ 'Personal writing style' ]
	ifFalse: [ ^ 'Formal writing style' ]
]

{ #category : #'as yet unclassified' }
MccComment >> meanStopwords [
	<return: #Number>
	|upperBound averageStopwords|
	averageStopwords :=  ((self stopwords size * 100) / self words size)asFloat truncated.
	upperBound := 30.
	
	averageStopwords > upperBound ifTrue: [ ^ 'Too many functional words in your sentences' ]
	ifFalse: [ ^ 'You are fine' ]
]

{ #category : #'as yet unclassified' }
MccComment >> meanWordLength [
	<return: #Number>
	" words per sentence-25"
	|averageWords upperBound lowerBound|
	upperBound := 25.
	lowerBound := 7.
	averageWords :=  self words size/self sentences size.
	
	averageWords > upperBound ifTrue: [ ^ 'Too many words in your sentences' ]
	ifFalse: [averageWords < lowerBound ifTrue: [ ^ 'Too few words in your sentences, make the sentence bigger' ]
		ifFalse: [ ^ 'You have a nice combination of short and bigger sentences' ]  ]
]

{ #category : #metrics }
MccComment >> metrics [ 

	<return:#Dictionary>

	statistics := OrderedDictionary new.
	
	self statistics addAll:
	{ 
	'Lengthy sentences' -> self meanWordLength.
	'Functional words ' -> self meanStopwords .
	'Writing style' -> self meanPronouns.
	'Vocabulary Richness'-> self vocabularyRichness.
	'Readability' -> self readabilityStatus.	
	 }asDictionary.
	
 	^ self statistics. 
]

{ #category : #'as yet unclassified' }
MccComment >> negativeSentences [
	^ self sentences select:#hasNegative
]

{ #category : #printing }
MccComment >> printOn: aStream [
	aStream
		nextPutAll: 'Comment of ';
		nextPut: $(;
		nextPutAll: self artefact asString;
		nextPut: $)
]

{ #category : #accessing }
MccComment >> pronouns [
	"Split and return a collection of pronpuns (with possible duplications) in this comment"
	<return: #Collection of: #MccWord>

	^ self words select: #isPronoun
]

{ #category : #accessing }
MccComment >> readabilityStatus [
	"Return a status "
	<return: #Object>
	|rc commentReadability readabilityScore cr|
		" 0 = good; 1 = needs toning; 2 = flabby."
	readabilityScore := {(0 -> 'Good').(1 -> 'Needs Toning').(2 -> 'Flabby')}asOrderedDictionary .
	rc := CommentReadabilityChecker new. 
	commentReadability := ((self sentences collect: [ :e |
		|anArrayOfWords|
		anArrayOfWords := e words collect: [ :w | w asString asSymbol ]. 
	rc readabilityOf: anArrayOfWords])sum: [:e |  e])/self sentences size.
	cr := 
	(commentReadability < 1 and: [ commentReadability > 0 ])
	ifTrue: [ 1 ] ifFalse: [commentReadability > 2 ifTrue: [ 2 ] ifFalse: [ 0 ] ].
	^ readabilityScore at: cr.
]

{ #category : #references }
MccComment >> references [
	"Return a collection of references from this comment in a default environment"
	<return: #Collection of: #MccReference>

	^ self referencesIn: MccSystemEnvironment default
]

{ #category : #references }
MccComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ self subclassResponsibility
]

{ #category : #accessing }
MccComment >> sentences [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>

	^ sentences ifNil: [ sentences := self computeSentences ]
]

{ #category : #accessing }
MccComment >> statistics [
	^ statistics
]

{ #category : #accessing }
MccComment >> stopwords [
	"Split and return a collection of stopwords (with possible duplications) in this comment"
	<return: #Collection of: #MccWord>

	^ self words select: #isStopword
]

{ #category : #accessing }
MccComment >> templateSections [
	^ templateSections
]

{ #category : #accessing }
MccComment >> text [
	"returns array of text tokens from comment"
	| aParser theTokens |
 
	aParser := MccSmalltalkInCommentParser.
	theTokens := (aParser parse: self asString) textAndCodeTokens.
	text := theTokens select: [ :eachToken | 
		eachToken isText ].
	^ text
]

{ #category : #'gt-inspector-extension' }
MccComment >> view [

	|b ds|
	
	b := RTGrapher new.
	b extent: 500 @ 200.
	ds := RTData new.
	ds interaction highlight.
	ds points: self metrics associations.
	ds barShape width: 10.
	ds y: [ :e |  e value ].
	ds barChartWithBarTitle: #key.
	b add: ds.
	b axisY.
	b axisX
		noTick;
		noLabel.
	^ b
]

{ #category : #'as yet unclassified' }
MccComment >> vocabulary [
	<return: #Number>
	^ self lemmas asSet size.
]

{ #category : #'as yet unclassified' }
MccComment >> vocabularyRichness [
	<return: #Number>
	| M S upperBound|
	upperBound := 60.
	M := self lemmas asSet size.
	"S := 100 * M ln / M squared."
	S := ((100*M)/(self words size)) asFloat truncated.
	S > 60 ifTrue: [ ^ 'You have rich vocabulary' ]
	ifFalse: [ ^ 'Simple vocabulary' ].
]

{ #category : #'as yet unclassified' }
MccComment >> warningSentences [
	^ self sentences select:#hasWarning
]

{ #category : #accessing }
MccComment >> words [
	"Split and return a collection of words in this comment"
	<return: #Collection of: #MccSentence>

	^ words ifNil: [ words := self computeWords ]
]
