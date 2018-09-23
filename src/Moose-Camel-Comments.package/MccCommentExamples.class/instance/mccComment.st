gt-examples
mccComment
	<gtExample>
	
	|classesWithComments|
	classesWithComments := (MccClassesExamples new) withComments.
	^ MccComment fromClass:(classesWithComments asArray first)
	
	