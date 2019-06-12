"
The class shows the style Default Template follows.
It sliced the template and collect words from the template. It is used to define how much a class is close to template.

The default template looks like:
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #MccCommentTemplate,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'word-lists' }
MccCommentTemplate >> colloborators [
	"a verb that expresses the class’s responsibility"
	
	^ #('colloborate' 'Collaborators' 'I interact' 'I interacts') 
]

{ #category : #'word-lists' }
MccCommentTemplate >> exampleWords [
	"a verb that expresses the class’s desire/goal"
	
	^ #('example' 'examples').
]

{ #category : #'word-lists' }
MccCommentTemplate >> instanceVariableWords [
	"a verb that expresses the class’s desire/goal"
	
	^ #('instance variables' 'instance variables').
]

{ #category : #'word-lists' }
MccCommentTemplate >> intentWords [
	"a verb that expresses the class’s desire/goal"
	
	^ #('I represent' 'I am' 'I''m').
]

{ #category : #'word-lists' }
MccCommentTemplate >> internalRepresentationAndKeyImplementationWords [
	"a verb that expresses the class’s desire/goal"
	
	^ #('Internal Representation' 'Internal Representations' 'Key Implementation' 'Key Implementations' 'Implementation Point' 'Implementation Points').
]

{ #category : #'word-lists' }
MccCommentTemplate >> publicAPIs [
	"a phrase to show public api section in the template"
	
	^ #('Public API' 'Key Messages' 'create instances' 'create instance')
]

{ #category : #'word-lists' }
MccCommentTemplate >> responsibilityVerbs [
	"a verb that expresses the class’s responsibility"
	
	^ #('my responsibilites' 'my responsibility' 'my main responsibilites' 'I do' 'I know')
]
