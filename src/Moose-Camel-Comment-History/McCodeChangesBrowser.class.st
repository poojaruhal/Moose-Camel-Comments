"
This class detects the changes of one class from other class. There are two types of changes in our defintion, changes in the class definition and another is changes in the methods. 
The class defintion includes class side and instance side definition whereas method changes include the methods added, removed and source code changed.

"
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

{ #category : #'as yet unclassified' }
McCodeChangesBrowser >> allCodeChanges [
	^ (self detectClassDefinitionChanges
		, self detectMethodDefinitionChanges groupedBy: [ :e | e key ])collect: [ :e | e value collect: [ :f |  f value ] ]
]

{ #category : #computation }
McCodeChangesBrowser >> detectChangesIn: cv1Methods and: cv2Methods [ 
	"methods present in v1 and v2"
	| cv1_transformed cv2_transformed diff|

	cv1_transformed := self transform: cv1Methods.
	cv2_transformed := self transform: cv2Methods.
	diff := cv2_transformed difference: cv1_transformed.
	
	^ diff collect: [ :p |
		|m1|
		
		m1 :=  cv1_transformed detect: [:f | p key = f key] ifNone: [ nil]. 
		m1 isNil 
		ifTrue: [ 
			|methodDetails detectedMethodByName| 
			methodDetails := (p key splitOn: '$').
			detectedMethodByName := cv1Methods 
				detect: [ :e | e first = methodDetails first ]
				ifNone: [ nil ].
			detectedMethodByName isNil 
				ifTrue: [ 
					(cv1Methods anySatisfy: [ :e | e third = p value])
						ifTrue: [ 
							((cv1Methods detect: [ :e | e third = p value ]) second = methodDetails second)
								ifTrue: [ #methodRenamed -> p ]
								ifFalse: [ #methodRenamedAndDuplicatedToOtherSide ]]
						ifFalse: [ #methodAdded -> p ]
							]
				ifFalse:[
					detectedMethodByName third =  p value
					 	ifTrue: [ #methodDuplicatedToOtherSide -> p ]
						ifFalse: [ #methodDuplicatedAndCodeChanged -> p ] ]]
		ifFalse: [ #methodCodeChanged -> p]
		  ].
	
	"^ differentMethods collect: [ :p |
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
					m1 second = m2 second " "condition 2"
					"ifTrue: [  #methodCodeChanged -> p  ]
					ifFalse: [ 
						m1 third = m2 third
						 ifTrue: [ #methodDuplicated -> p ]
						ifFalse: [ #methodRenamed -> p  ]
					]
			 	]
		  ]]]. "
	
    
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
				e key ->  (changes).
					]])
]

{ #category : #computation }
McCodeChangesBrowser >> detectMethodDefinitionChanges [

^ v2m select: [ :e | 
	((v1m collect:#key) includes: e key)] thenCollect: [  :e | 
	|c1Methods c2Methods|
		"e :=  (vm2 detect: [:a | a key = 'AbstractAdapter'])."
		c1Methods := ((v1m detect: [:a | a key = e key]) value) sorted: [ :a :b | a first < b first ]. 
		c2Methods := (e value)sorted: [ :a :b | a first < b first ]. 
	
		((c1Methods = c2Methods) or: [((c1Methods difference: c2Methods) isEmpty and: [ (c2Methods difference: c1Methods)isEmpty])])
		ifTrue: [ e key -> #methodsNotChanged ]
		ifFalse:[ 
			|changes changedMethods removedMethods sameMethods|
			
			changes := OrderedCollection new.
			sameMethods :=  self detectSameMethodsIn:  c1Methods and: c2Methods. 
			sameMethods ifNotNil: [changes add: (sameMethods)].			
			changedMethods := self detectChangesIn: c1Methods and: c2Methods.
			changedMethods ifNotNil: [changes add: (changedMethods)].
			removedMethods := self detectRemovedMethodsIn: c1Methods  and: c2Methods.
			removedMethods ifNotNil: [changes add: (removedMethods)].
		   e key -> (changes).
	]
].

]

{ #category : #computation }
McCodeChangesBrowser >> detectRemovedMethodsIn: cv1Methods and: cv2Methods [ 
	"methods present in v1 and v2"
	| cv1_transformed cv2_transformed diff|

	cv1_transformed := self transform: cv1Methods.
	cv2_transformed := self transform: cv2Methods.
	diff := cv1_transformed difference: cv2_transformed.
	
	^ ((diff reject: [ :p |
		|nameAndSideCondition nameAndCodeCondition |
		 nameAndSideCondition := ((cv2_transformed collect: #key) includes: p key).
		 nameAndCodeCondition := cv2Methods anySatisfy: 
					[ :e | ((e first = (p key splitOn: '$') first) or: [ e third = p value ])].
			(nameAndSideCondition and: [ nameAndCodeCondition ])
			]) collect: [ :p | #methodRemoved -> p ])
]

{ #category : #computation }
McCodeChangesBrowser >> detectSameMethodsIn: cv1Methods and: cv2Methods [ 
	"methods present in v1 and v2"
	| cv1_transformed cv2_transformed|

	cv1_transformed := self transform: cv1Methods.
	cv2_transformed := self transform: cv2Methods.
	^ ((cv1_transformed intersection: cv2_transformed) collect: [:p | #methodsNotChanged -> p])

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

{ #category : #computation }
McCodeChangesBrowser >> transform: methodsCollection [
	^ methodsCollection collect: [ :e | (e first,'$', e second) -> e third ].
	
]

{ #category : #accessing }
McCodeChangesBrowser >> v1m [
	^ v1m
]

{ #category : #accessing }
McCodeChangesBrowser >> v2m [
	^ v2m
]
