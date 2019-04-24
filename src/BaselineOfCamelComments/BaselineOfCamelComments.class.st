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
			baseline: 'Camel' with: [ spec repository: 'github://poojaruhal/Moose-Camel/src' ];
			baseline: 'PetitParser2' with: [ spec repository: 'github://kursjan/petitparser2' ];
			baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			baseline: 'NeoCSV' with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
			
		spec package: #'Moose-Camel-Comments' with: [ spec requires: #(Camel PetitParser2 NeoJSON NeoCSV) ].
		spec package: #'Moose-Camel-Comments-Examples' with: [ spec requires: #('Moose-Camel-Comments') ].
	
		spec group: 'default' with: #('Moose-Camel-Comments' 'Moose-Camel-Comments-Examples') ]
]
