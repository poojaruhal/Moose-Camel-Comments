Class {
	#name : #McVersionBrowser,
	#superclass : #Object,
	#category : #'Moose-Camel-Comment-History'
}

{ #category : #accessing }
McVersionBrowser >> allClassNames [
" get classes of all Pharo version- unique "
	^ (self allPharoModels flatCollect: [ :e | e allModelClasses collect: #name ]) asSet
]

{ #category : #accessing }
McVersionBrowser >> allPharoModels [
"get all moose models of Pharo"
 ^ MooseModel root asOrderedCollection.
]

{ #category : #accessing }
McVersionBrowser >> allVersionComments [
" get the version when comment was added to the class "
 ^ self allVersionedClasses associations collect: [ :e | 
	| comments changes |
	comments := e value associations sorted: [ :a :b | a key < b key ].
	changes := comments withIndexCollect: [ :f :i | | exists |
		exists := f value isNotEmpty.
		i = 1
			ifTrue: [ 
				f key -> (exists 
					ifTrue: [ #added ])]]].
]

{ #category : #accessing }
McVersionBrowser >> allVersionCommentsChanged [
	"get all the classes of whose comments are changed in any of the succedding version. By change we means if a class comment is removed, or the content is changed in the later versions"
	
	^ (self allVersionedChanges associations 
			select: [ :e | |commentStatus|
			commentStatus := e value values.
			((commentStatus includes: #added) and: [(commentStatus includes:  #changed) or: [ commentStatus includes: #removed ]])]) asOrderedDictionary .
]

{ #category : #accessing }
McVersionBrowser >> allVersionCommentsChangedWithCommentContent [
	"get all the classes with comment content of whose comments are changed in any of the succedding version. By change we means if a class comment is removed, or the content is changed in the later versions"

	^ self allVersionCommentsChanged associations
		collect: [ :e | 
			| commentsContent gf |
			commentsContent := self allVersionedClasses at: e key.
			gf := (e value associations
				collect: [ :f | 
					f key -> {f value.
							(commentsContent at: f key)} ]) asOrderedDictionary.
			e key -> gf ]
]

{ #category : #accessing }
McVersionBrowser >> allVersionedChanges [
"get all changes in the commet history when the comment was added, changed, removed for all classes of all pharo versions"
	^ (self allVersionedClasses associations
		collect: [ :e | 
			| comments changes |
			comments := e value associations sorted: [ :a :b | a key < b key ].
			changes := comments
				withIndexCollect: [ :f :i | 
					| exists |
					exists := f value isNotEmpty.
					i = 1
						ifTrue: [ f key
								-> (exists
										ifTrue: [ #added ]
										ifFalse: [ #noComment ]) ]
						ifFalse: [ | other otherExists changed |
							other := (comments at: i - 1) value.
							otherExists := other isNotEmpty.
							changed := f value ~= other.
							f key
								->(exists = otherExists
										ifTrue: [ changed
												ifTrue: [ #changed ]
												ifFalse: [ #unchanged ] ]
										ifFalse: [ exists
												ifTrue: [ #added ]
												ifFalse: [ #removed ] ]) ] ].
			e key -> changes asOrderedDictionary ]) asDictionary
]

{ #category : #accessing }
McVersionBrowser >> allVersionedClasses [
"get all the classes of all pharo versions with or wihtout comments, if there are"
	(self allClassNames
		collect: [ :className | 
			className
				->
					(((self allPharoModels
						withIndexCollect: [ :aModel :i | 
							i
								->
									(aModel allModelClasses
										detect: [ :class | class name = className ]
										ifNone: [ nil ]) ]) reject: [ :f | f value isNil ])
						collect: [ :f | 
							f key
								->
									(f value comments ifEmpty: [ '' ] ifNotEmpty: [ :g | g first content ]) ])
						asDictionary ]) asDictionary
]
