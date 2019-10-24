Class {
	#name : #McCodeChangesBrowser,
	#superclass : #Object,
	#instVars : [
		'v1c',
		'v2c',
		'v1m',
		'v2m'
	],
	#category : #'Moose-Camel-Comment-History'
}

{ #category : #computation }
McCodeChangesBrowser >> commonMethodsIn: cv1Methods and: cv2Methods [ 
	"methods present in v1 and v2"
	^ (cv1Methods collect: #first) intersection: (cv2Methods collect: #second).
]

{ #category : #computation }
McCodeChangesBrowser >> detectChangesIn: cv1Methods and: cv2Methods [ 
	"methods present in v1 and v2"
	|differentMethods|
	self halt.
	differentMethods := (((cv1Methods union: cv2Methods) difference: (cv1Methods intersection: cv2Methods))).
	
	^ differentMethods collect: [ :p |
		|m1 m2|
		
		m1 :=  cv1Methods detect: [:f | p  = f first] ifNone: [ nil]. 
		m2 :=  cv2Methods detect: [:f | p  = f first] ifNone: [nil].
		m1 isEmptyOrNil 
		ifTrue: [  #methodAdded -> p  ]
		ifFalse: [ 
			m2 isEmptyOrNil 
			ifTrue: [ #methodRemoved -> p ]
			ifFalse: [  
				m1 ~= m2 
				ifTrue: [
					m1 second = m2 second "condition 2"
					ifTrue: [  #methodCodeChanged -> p  ]
					ifFalse: [ 
						m1 third = m2 third
						 ifTrue: [ #methodDuplicated -> p ]
						ifFalse: [ #methodRenamed -> p  ]
					]
			 	]
		  ]]]. 	
	
    
]

{ #category : #computation }
McCodeChangesBrowser >> detectClassDefinitionChanges [

 ^ (v2c select: [ :e | 
	((v1c collect:#key) includes: e key)] thenCollect: [  :e | 
		 |def1 def2|
	def1 := (v1c detect: [ :c | e key = c key ]) value.
	def2 := (v2c detect: [ :c | e key = c key ]) value.
	def1 = def2
		ifTrue: [ 
			 e key -> #ClassDefNotChanged]
		ifFalse: [
			|changes|
				changes := OrderedCollection new.
				def1 first ~= def2 first ifTrue: [ changes add: #instanceSideChanged ].
				def1 second ~= def2 second ifTrue: [ changes add: #classSideChanged ].
				e key ->  ('-' join: changes).
					]])
]

{ #category : #computation }
McCodeChangesBrowser >> detectMethodDefinitionChanges [

^ v2m select: [ :e | 
	((v1m collect:#key) includes: e key)] thenCollect: [  :e | 
	|c1Methods c2Methods|
		"e :=  (vm2 detect: [:a | a key = 'MorphicEvent'])."
		c1Methods := ((v1m detect: [:a | a key = e key]) value) sorted: [ :a :b | a first < b first ]. 
		c2Methods := (e value)sorted: [ :a :b | a first < b first ]. 
	
		((c1Methods = c2Methods) or: [((c1Methods difference: c2Methods) isEmpty and: [ (c2Methods difference: c1Methods)isEmpty])])
		ifTrue: [ e key -> #methodsNotChanged]
		ifFalse:[ 
		 e key -> (self detectChangesIn: c1Methods and: c2Methods).
	]
].

]

{ #category : #initialization }
McCodeChangesBrowser >> initialize [
	 super initialize.
	v1c := nil.
	v2c := nil.
	v1m := nil.
	v2m := nil.
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

	v1c := ((v1Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						collect: [ :m | 
							{m second.
							m third} ]) flatten ]) sorted: [ :a :b | a key < b key ].
	v2c := ((v2Parsed groupedBy: [ :e | e first ]) associations
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
	
	v1m := ((v1Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						collect: [ :m | 
							{m third.m second.m fourth} ]) 
					]) sorted: [ :a :b | a key < b key ].
	
	v2m := ((v2Parsed groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key ->(f value
						collect: [ :m | 
							{m third.m second.m fourth} ])
				   ]) sorted: [ :a :b | a key < b key ]
]
