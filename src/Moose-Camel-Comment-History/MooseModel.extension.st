Extension { #name : #MooseModel }

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesAddedSince: aModel [
	^ ((self allModelClasses asSet collect: #name) difference: (aModel allModelClasses asSet  collect: #name)) collect: [ :e | self allModelClasses detect: [ :f | f name = e ] ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesCommentChangedSince: aModel [
	^ (((((self allModelClasses asSet collect: #name)
		intersection: (aModel allModelClasses asSet collect: #name))
		select: [ :e | 
			| a b |
			a := aModel allModelClasses detect: [ :f | f name = e ].
			b := self allModelClasses detect: [ :f | f name = e ].
			a moCaComment ~= b moCaComment ])
		collect: [ :e | 
			| a b |
			a := aModel allModelClasses detect: [ :f | f name = e ].
			b := self allModelClasses detect: [ :f | f name = e ].
			(a moCaComment
				ifEmpty: [ #commentAdded ]
				ifNotEmpty: [ b moCaComment
						ifEmpty: [ #commentRemoved ]
						ifNotEmpty: [ #commentChanged ] ]) -> b ]) groupedBy: #key)
		collect: [ :e | 
			(((e collect: #value)
				groupedBy: [ :f | ('-' split: f parentPackage name) first ])
				associations sorted: [ :a :b | a value size > b value size ])
				asOrderedDictionary ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesCommentContentChangedSince: aModel [
	^ (((((self allModelClasses asSet collect: #name)
		intersection: (aModel allModelClasses asSet collect: #name))
		select: [ :e | 
			| a b |
			a := aModel allModelClasses detect: [ :f | f name = e ].
			b := self allModelClasses detect: [ :f | f name = e ].
			a moCaComment ~= b moCaComment ])
		collect: [ :e | 
			| a b |
			a := aModel allModelClasses detect: [ :f | f name = e ].
			b := self allModelClasses detect: [ :f | f name = e ].
			(a moCaComment
				ifEmpty: [ #commentAdded ]
				ifNotEmpty: [ b moCaComment
						ifEmpty: [ #commentRemoved ]
						ifNotEmpty: [ #commentChanged ] ]) -> {(aModel name->a). (self name ->b)}]) groupedBy: #key)
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesDiffSince: aModel [
	^ {(#addedClasses
		->
			(((self moCaModelClassesAddedSince: aModel)
				groupedBy: [ :e | ('-' split: e parentPackage name) first ])
				associations sorted: [ :a :b | a value size > b value size ])
				asOrderedDictionary).
	(#removedClasses
		->
			(((self moCaModelClassesRemovedSince: aModel)
				groupedBy: [ :e | ('-' split: e parentPackage name) first ])
				associations sorted: [ :a :b | a value size > b value size ])
				asOrderedDictionary).
	(#sameClasses
		->
			(((self moCaModelClassesSameSince: aModel)
				groupedBy: [ :e | ('-' split: e parentPackage name) first ])
				associations sorted: [ :a :b | a value size > b value size ])
				asOrderedDictionary)} asDictionary
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesRemovedSince: aModel [
	^ ((aModel allModelClasses asSet collect: #name) difference: (self allModelClasses asSet  collect: #name)) collect: [ :e | aModel allModelClasses detect: [ :f | f name = e ] ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelClassesSameSince: aModel [
	^ ((self allModelClasses asSet collect: #name)
		intersection: (aModel allModelClasses asSet collect: #name))
		collect: [ :e | self allModelClasses detect: [ :f | f name = e ] ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelComponentsAddedSince: aModel [
	^ ((self allModelPackages asSet
		collect: [ :e | ('-' split: e name) first ])
		difference:
			(aModel allModelPackages asSet
				collect: [ :e | ('-' split: e name) first ]))
		collect: [ :e | 
			e
				-> (self allModelPackages select: [ :f | ('-' split: f name) first = e ]) ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelComponentsDiffSince: aModel [
	^ {(#added
		->
			((self moCaModelComponentsAddedSince: aModel)
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary).
	(#removed
		->
			((self moCaModelComponentsRemovedSince: aModel)
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary).
	(#same
		->
			((self moCaModelComponentsSameSince: aModel)
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary)}
		asDictionary
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelComponentsRemovedSince: aModel [
	^ ((aModel allModelPackages asSet
		collect: [ :e | ('-' split: e name) first ])
		difference:
			(self allModelPackages asSet
				collect: [ :e | ('-' split: e name) first ]))
		collect: [ :e | 
			e
				->
					(aModel allModelPackages
						select: [ :f | ('-' split: f name) first = e ]) ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelComponentsSameSince: aModel [
	^ ((self allModelPackages asSet
		collect: [ :e | ('-' split: e name) first ])
		intersection:
			(aModel allModelPackages asSet
				collect: [ :e | ('-' split: e name) first ]))
		collect: [ :e | 
			e
				-> (self allModelPackages select: [ :f | ('-' split: f name) first = e ]) ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelPackagesAddedSince: aModel [
	^ ((self allModelPackages asSet collect: #name)
		difference: (aModel allModelPackages asSet collect: #name))
		collect: [ :e | self allModelPackages detect: [ :f | f name = e ] ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelPackagesDiffSince: aModel [
	^ {(#addedPackages
		->
			(((self moCaModelPackagesAddedSince: aModel)
				groupedBy: [ :e | ('-' split: e name) first ]) associations
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary).
	(#removedPackages
		->
			(((self moCaModelPackagesRemovedSince: aModel)
				groupedBy: [ :e | ('-' split: e name) first ]) associations
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary).
	(#samePackages
		->
			(((self moCaModelPackagesSameSince: aModel)
				groupedBy: [ :e | ('-' split: e name) first ]) associations
				sorted: [ :a :b | 
					(a value sum: [ :e | e classes size ])
						> (b value sum: [ :e | e classes size ]) ]) asOrderedDictionary)}
		asDictionary
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelPackagesRemovedSince: aModel [
	^ ((aModel allModelPackages asSet collect: #name)
		difference: (self allModelPackages asSet collect: #name))
		collect: [ :e | aModel allModelPackages detect: [ :f | f name = e ] ]
]

{ #category : #'*Moose-Camel-Comment-History' }
MooseModel >> moCaModelPackagesSameSince: aModel [
	^ ((self allModelPackages asSet collect: #name)
		intersection: (aModel allModelPackages asSet collect: #name))
		collect: [ :e | self allModelPackages detect: [ :f | f name = e ] ]
]
