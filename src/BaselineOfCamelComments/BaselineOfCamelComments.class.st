Class {
	#name : #BaselineOfCamelComments,
	#superclass : #BaselineOf,
	#category : 'BaselineOfCamelComments'
}

{ #category : #baselines }
BaselineOfCamelComments >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec
			baseline: 'Camel' with: [ spec repository: 'github://poojaruhal65/Moose-Camel/src' ].

		spec package: #'Moose-Camel-Comments' with: [ spec requires: #(Camel) ].
		spec package: #'Moose-Camel-Comments-Examples' with: [ spec requires: #('Moose-Camel-Comments') ].
	
		spec group: 'default' with: #('Moose-Camel-Comments' 'Moose-Camel-Comments-Examples') ]
]
