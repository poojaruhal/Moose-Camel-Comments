Class {
	#name : #McCodeChangesBrowser,
	#superclass : #Object,
	#instVars : [
		'vc1',
		'vc2',
		'vm1',
		'vm2'
	],
	#category : #'Moose-Camel-Comment-History'
}

{ #category : #'as yet unclassified' }
McCodeChangesBrowser >> detectClassDefinitionChanges [

 ^ (vc2 select: [ :e | 
	((vc1 collect:#key) includes: e key)] thenCollect: [  :e | 
		 |def1 def2|
	def1 := (vc1 detect: [ :c | e key = c key ]) value.
	def2 := (vc2 detect: [ :c | e key = c key ]) value.
	def1 = def2
		ifTrue: [ 
			"e key -> #ClassDefinitionSame"
			 e key -> #False]
		ifFalse: [
			|changes|
				changes := OrderedCollection new.
				def1 first ~= def2 first ifTrue: [ changes add: #instanceSideChanged ].
				def1 second ~= def2 second ifTrue: [ changes add: #classSideChanged ].
				e key -> changes.
					]])
]

{ #category : #'as yet unclassified' }
McCodeChangesBrowser >> detectMethodDefinitionChanges [

^ vm2 select: [ :e | 
	((vm1 collect:#key) includes: e key)] thenCollect: [  :e | 
	|c1Methods c2Methods|
		"e :=  (v2 detect: [:a | a key = 'MorphicEvent'])."
		c1Methods := ((vm1 detect: [:a | a key = e key]) value) sorted: [ :a :b | a first < b first ]. 
		c2Methods := (e value)sorted: [ :a :b | a first < b first ]. 
	
		((c1Methods = c2Methods) or: [((c1Methods difference: c2Methods) isEmpty and: [ (c2Methods difference: c1Methods)isEmpty])]) 
		ifTrue: [ e key -> #methodsNotChanged]
		ifFalse:[ 
			|c1Differences c2Differences c1DifferencesMethodNames c2DifferencesMethodNames methodsChanged commonMethods |
			c1Differences :=  (c1Methods difference: c2Methods).
			c2Differences :=  (c2Methods difference: c1Methods).
			
			c1DifferencesMethodNames := c1Differences collect: #first.
			c2DifferencesMethodNames := c2Differences collect: #first.
					
			
			methodsChanged := OrderedCollection new.
			commonMethods := c1DifferencesMethodNames intersection: c2DifferencesMethodNames.
			
			commonMethods ifNotEmpty: [
				|c1 c2|
						 (commonMethods select: [ :p |
						c1 := c1Differences detect: [:f | p = f first].
						c2 := c2Differences detect: [:f | p = f first].
						c1 second = c2 second]) ifNotEmpty: [  
					methodsChanged add:  #methodsCodeChanged].
					
					(commonMethods select: [ :m |
						c1 := c1Differences detect: [:f | m = f first].
						c2 := c2Differences detect: [:f | m = f first].
						c1 second ~= c2 second]) ifNotEmpty: [  
					methodsChanged add: #methodsDuplicated]].
					
				(c1DifferencesMethodNames difference: c2DifferencesMethodNames)
				ifNotEmpty: [ methodsChanged add: #methodsRemoved].
				(c2DifferencesMethodNames difference: c1DifferencesMethodNames)
				 ifNotEmpty: [ methodsChanged add: #methodsAdded].
			
		 e key -> ('-' join: methodsChanged).
	]
].

]

{ #category : #initialization }
McCodeChangesBrowser >> initialize [
	 super initialize.
	vc1 := nil.
	vc2 := nil.
	vm1 := nil.
	vm2 := nil.
]

{ #category : #initialization }
McCodeChangesBrowser >> parseClassesDefinitionFrom: v1FilePath and: v2FilePath [

	|v1Parsed v2Parsed reader|
	reader := NeoCSVReader on: v1FilePath asFileReference readStream.
	v1Parsed := reader upToEnd.
	reader close.

	reader := NeoCSVReader on: v2FilePath asFileReference readStream.
	v2Parsed := reader upToEnd.
	reader close.

	vc1 := ((v1Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						collect: [ :m | 
							{m second.
							m third} ]) flatten ]) sorted: [ :a :b | a key < b key ].
	vc2 := ((v2Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						collect: [ :m | 
							{m second.
							m third} ]) flatten ]) sorted: [ :a :b | a key < b key ].
]

{ #category : #initialization }
McCodeChangesBrowser >> parseMethodDefinitionFrom: v1FilePath and: v2FilePath [
	| v1Parsed v2Parsed reader |
	
	reader := NeoCSVReader on: v1FilePath asFileReference readStream.
	v1Parsed := reader upToEnd.
	reader close.
	
	reader := NeoCSVReader on: v2FilePath asFileReference readStream.
	v2Parsed := reader upToEnd.
	reader close.
	
	vm1 := ((v1Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						collect: [ :m | 
							{m third.m second.m fourth} ]) 
					]) sorted: [ :a :b | a key < b key ].
	
	vm2 := ((v2Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key ->(f value
						collect: [ :m | 
							{m third.m second.m fourth} ])
				   ]) sorted: [ :a :b | a key < b key ]
]
