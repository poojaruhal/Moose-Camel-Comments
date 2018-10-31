accessing
string: aString interval: anInterval
	| aTrimmedDelta aStart |
	"anInterval is a location of the sentence within the original text"

	string := aString trimmed.

	"delta is how many whitespace characters were trimmed from the start of the string"
	aTrimmedDelta := (aString
		detectIndex: [ :each | each isSeparator not ]
		ifNone: [ aString size ]) - 1.

	aStart := anInterval first + aTrimmedDelta.
	interval := aStart to: aStart + string size - 1