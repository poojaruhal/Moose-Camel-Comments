gt-examples
mccComment
	<gtExample>
	<description: 'Return an instance of MccComment class'>
	
	| classesWithComments mccComment aClass|
	
	classesWithComments := (MccClassesExamples new) classesWithComments.
	"aClass := classesWithComments asArray first."
	aClass := ('BlElement' asClass).
	
	^ mccComment := MccComment fromClass: aClass.
	
	