gt-examples
mccComment
	<gtExample>
	<description: 'Return an instance of MccComment class'>
	
	| classesWithComments mccComment aClass|
	
	classesWithComments := (MccClassesExamples new) withComments.
	"aClass := classesWithComments asArray first."
	aClass := NlpQuestionsDistance.
	
	^ mccComment := MccComment fromClass: aClass.
	
	