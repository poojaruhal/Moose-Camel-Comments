"
<Example>
hub:= MccSmalltalkHubStatistics new.
projects:= hub projects.
projects groupBy: #commits.
first:= projects first.
first timestamp year.
timestamps:= hub timestampsByTimeline.
hub projectsInBarChartByTimeline. 


Difference of all Pharo versions
an OrderedDictionary('Pharo_1'->a Dictionary('average number of lines in comments'->7.063981042654029 'average number of stopwords'->26.981042654028435 'average number of unique words'->42.980252764612956 'average number of words'->67.87677725118483 'avg number of pronouns'->2.3949447077409163 'total lines'->8943 'total number of comments'->1266 'total pronouns'->3032 'total stopwords'->34158 'total words'->85932 ) 'Pharo_2'->a Dictionary('average number of lines in comments'->5.678607467204843 'average number of stopwords'->20.815338042381434 'average number of unique words'->34.41624621594349 'average number of words'->52.71442986881937 'avg number of pronouns'->2.1816347124117055 'total lines'->11255 'total number of comments'->1982 'total pronouns'->4324 'total stopwords'->41256 'total words'->104480 ) 'Pharo_3'->a Dictionary('average number of lines in comments'->4.5366227398099905 'average number of stopwords'->15.867606497088568 'average number of unique words'->26.68464603125958 'average number of words'->40.26785167024211 'avg number of pronouns'->1.7388905914802328 'total lines'->14803 'total number of comments'->3263 'total pronouns'->5674 'total stopwords'->51776 'total words'->131394 ) 'Pharo_4'->a Dictionary('average number of lines in comments'->4.601805149986727 'average number of stopwords'->15.874170427395805 'average number of unique words'->27.116803822670562 'average number of words'->40.548181576851604 'avg number of pronouns'->1.685160605256172 'total lines'->17335 'total number of comments'->3767 'total pronouns'->6348 'total stopwords'->59798 'total words'->152745 ) 'Pharo_5'->a Dictionary('average number of lines in comments'->4.565518835220707 'average number of stopwords'->15.79939912179339 'average number of unique words'->26.964178414605964 'average number of words'->40.19828980818119 'avg number of pronouns'->1.7524844002773283 'total lines'->19755 'total number of comments'->4327 'total pronouns'->7583 'total stopwords'->68364 'total words'->173938 ) 'Pharo_6'->a Dictionary('average number of lines in comments'->4.5333204558624685 'average number of stopwords'->16.004056403322387 'average number of unique words'->27.205331272937993 'average number of words'->40.271199536411046 'avg number of pronouns'->1.8371643809155882 'total lines'->23469 'total number of comments'->5177 'total pronouns'->9511 'total stopwords'->82853 'total words'->208484 ) 'Pharo_7'->a Dictionary('average number of lines in comments'->4.794136392606756 'average number of stopwords'->16.336838750796687 'average number of unique words'->28.01402166985341 'average number of words'->41.51800509878904 'avg number of pronouns'->2.181325685149777 'total lines'->30088 'total number of comments'->6276 'total pronouns'->13690 'total stopwords'->102530 'total words'->260567 ))
"
Class {
	#name : #MccStatisticsExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Statistics'
}

{ #category : #navigation }
MccStatisticsExamples >> classMetrics [
	<gtExample>
	<return: #Dictionary of: 'class Metrics'>
	
	^ self mccStatistics classMetrics.
]

{ #category : #navigation }
MccStatisticsExamples >> commentMetrics [
	<gtExample>
	<return: #Dictionary of: 'Comment Metrics'>
	
	|anExternalEnvironment mccCommentStatistics|

	anExternalEnvironment := MccExternalEnvironmentExamples new externalEnvironmentModel.
	mccCommentStatistics := MccCommentStatistics with: anExternalEnvironment.
	^ mccCommentStatistics compute.
]

{ #category : #navigation }
MccStatisticsExamples >> commentPronouns [
	<gtExample>
	<return: #Dictionary of: 'Comment Metrics'>
	
	|anExternalEnvironment mccCommentStatistics|
	
	anExternalEnvironment := MccExternalEnvironmentExamples new externalEnvironmentModel.
	mccCommentStatistics := MccCommentStatistics with: anExternalEnvironment.
	^ mccCommentStatistics collectPronouns.
]

{ #category : #navigation }
MccStatisticsExamples >> computeCodeClassChanges [
	<gtExample>
	| reader v1 v2 classChanges |
	
	reader := NeoCSVReader
		on:
			'/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/classDefinitionHash/Pharo2-ClassDefinitionsHash.csv'
				asFileReference readStream.
	v1 := reader upToEnd.
	reader close.
	
	reader := NeoCSVReader
		on:
			'/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/classDefinitionHash/Pharo3-ClassDefinitionsHash.csv'
				asFileReference readStream.
	v2 := reader upToEnd.
	reader close.
	
	v1 := ((v1 groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						flatCollect: [ :m | 
							{m second.
							m third} ]) ]) sorted: [ :a :b | a key < b key ].
	
	v2 := ((v2 groupedBy: [ :e | e first ]) associations
		collect: [ :f | 
			f key -> (f value
						flatCollect: [ :m | 
							{m second.
							m third} ]) ]) sorted: [ :a :b | a key < b key ].
	
	classChanges := (v2
		select: [ :e | (v1 collect: #key) includes: e key ]
		thenCollect: [ :e |
			|def1 def2| 
			def1 := (v1 detect: [ :c | e key = c key ]) value.
			def2 := (v2 detect: [ :c | e key = c key ]) value.
			def1 = def2
				ifTrue: [ e key -> #ClassDefintiionSame ]
				ifFalse: [ ((def1 intersection: def2) size = def1 size
						and: [ (def1 intersection: def2) size = def2 size ])
						ifTrue: [ e key -> #ClassDefintiionSame ]
						ifFalse: [ (def1 first ~= def2 first or: [ def1 second ~= def2 second ])
								ifTrue: [ | classDefChanged |
									classDefChanged := OrderedCollection new.
									def1 first ~= def2 first
										ifTrue: [ classDefChanged add: #InstanceSideChanged ].
									def1 second ~= def2 second
										ifTrue: [ classDefChanged add: #ClassSideChanged ].
									e key -> (#ClassDefintiionChanged -> classDefChanged) ] ] ] ])
		groupedBy: [ :e | e value ].
		
	^ classChanges.
]

{ #category : #navigation }
MccStatisticsExamples >> followsTemplateStyle [
	<gtExample>
	"return collection of MccClasses that follows template style in the class comments"
	<return: #Collection of:#MccClasses>
	^ (self mccStatistics environment mccCommentClasses
		select:[ :aMccCommentClass | 
			aMccCommentClass matchTemplateStyle ]
	  thenCollect: [:aMccCommentClass |
		 	aMccCommentClass -> aMccCommentClass matchedTemplateSections.
		])
]

{ #category : #navigation }
MccStatisticsExamples >> followsTemplateStyleInPharo7 [
	<gtExample>
	"return collection of MccClasses that follows template style in the class comments"
	<return: #Collection of:#MccClasses>
	^ (((MccClassWithComment new classesWithComment)collect:  #comment)
		select:[ :aMccCommentClass | 
			aMccCommentClass matchTemplateStyle ]
	  thenCollect: [:aMccCommentClass |
		 	aMccCommentClass -> aMccCommentClass matchedTemplateSections.
		])
]

{ #category : #navigation }
MccStatisticsExamples >> followsTemplateStyleInPharo7ManualStudy [
	<gtExample>
	"return collection of MccTextClasses that follows template style in the class comments"
	<return: #Collection of:#MccClasses>
	^ 	((MccClassWithComment new selectedClassesComment)
		select:[ :aMccCommentClass | 
			aMccCommentClass comment matchTemplateStyle ]
	  thenCollect: [:aMccCommentClass |
		 	aMccCommentClass -> aMccCommentClass comment matchedTemplateSections.
		])
]

{ #category : #navigation }
MccStatisticsExamples >> linesOfCodeInClass [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment sum: [ :aClass | aClass linesOfCode ]
]

{ #category : #navigation }
MccStatisticsExamples >> linesOfCodeInMethods [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment
		sum: [ :aClass | 
			aClass methods
				ifEmpty: [ 0 ]
				ifNotEmpty: [ aClass methods
						sum: [ :aMethod | 
							aMethod comment isNil
								ifFalse: [ 
									aMethod linesOfCode - (aMethod comment splitOn: Character cr) size - 1 ]
								ifTrue: [ aMethod linesOfCode - 1 ] ] ] ]
]

{ #category : #navigation }
MccStatisticsExamples >> linesOfCommentInClass [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment mccCommentClasses
		sum: [ :aClassComment | aClassComment sentences size ]
]

{ #category : #navigation }
MccStatisticsExamples >> linesOfCommentInMethods [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment
		sum: [ :aClass | 
			aClass methods
				ifEmpty: [ 0 ]
				ifNotEmpty: [ aClass methods
						sum: [ :aMethod | 
							aMethod comment isNil
								ifTrue: [ 0 ]
								ifFalse: [ (aMethod comment splitOn: Character cr) size ] ] ] ]
]

{ #category : #navigation }
MccStatisticsExamples >> mccStatistics [
	<gtExample>
	<return: #Instance of: #MccStatistics>
	
	^ (MccStatistics with: ((MccSystemEnvironment new) allClasses as:MccClasses))
]

{ #category : #navigation }
MccStatisticsExamples >> negativeSentimentsInClassComment [
	<gtExample>
	<return: #Collection of:#MccComment>
	^ (self mccStatistics environment mccCommentClasses
		collect:[ :aMccCommentClass | 
	aMccCommentClass hasNegative ifTrue:[
		 aMccCommentClass -> aMccCommentClass negativeSentences
		]
	ifFalse: [ aMccCommentClass -> #() ]
	]) reject: [ :a | a value isEmpty ].
]

{ #category : #navigation }
MccStatisticsExamples >> numberOfClasses [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment size
]

{ #category : #navigation }
MccStatisticsExamples >> numberOfMethods [
	<gtExample>
	<return: #Number>
	^ self mccStatistics environment
		sum: [ :aClass | 
			aClass methods
				ifEmpty: [ 0 ]
				ifNotEmpty: [ aClass methods size] ]
]

{ #category : #navigation }
MccStatisticsExamples >> smalltalkHubProjectsTimestamp [
	<gtExample>
	<return: #Array of: 'Timestamp'>
	
	^ MccSmalltalkHubStatistics new timestampsByYear

]

{ #category : #navigation }
MccStatisticsExamples >> statOfTemplateSectionMatches [
	<gtExample>
	"return statstics of template sections matches with the comment"
	<return: #Collection of:#Number>
	|commentsFollowTemplate stat|
	commentsFollowTemplate :=   self followsTemplateStyleInPharo7.
	stat := OrderedCollection new.
	
	stat add: ('Intent' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Intent']])).
	stat add: ('Responsibility' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Responsibility']])).	
	stat add: ('Collaborators' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Collaborators']])).	
	stat add: ('PublicAPI'->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'PublicAPI']])).
	stat add: ('Example' -> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Example']])).
	stat add: ('InternalRepresenation' -> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'InternalRepresenation']])).
	stat add: ('InstanceVariable'-> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'InstanceVariable']])).
		
	^ stat
]

{ #category : #navigation }
MccStatisticsExamples >> statOfTemplateSectionMatchesInManualStudy [
	<gtExample>
	"return statstics of template sections matches with the comment"
	<return: #Collection of:#Number>
	|commentsFollowTemplate stat|
	commentsFollowTemplate :=   self followsTemplateStyleInPharo7ManualStudy.
	stat := OrderedCollection new.
	
	stat add: ('Intent' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Intent']])).
	stat add: ('Responsibility' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Responsibility']])).	
	stat add: ('Collaborators' ->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Collaborators']])).	
	stat add: ('PublicAPI'->(commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'PublicAPI']])).
	stat add: ('Example' -> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'Example']])).
	stat add: ('InternalRepresenation' -> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'InternalRepresenation']])).
	stat add: ('InstanceVariable'-> (commentsFollowTemplate select:[:each | 
 			each value keys anySatisfy: [:a | a = 'InstanceVariable']])).
		
	^ stat
]

{ #category : #navigation }
MccStatisticsExamples >> totalCommentLines [
	<gtExample>
	<return: #Number>
	^ self linesOfCommentInClass + self linesOfCommentInMethods.
]

{ #category : #navigation }
MccStatisticsExamples >> warningsInClassComment [
	<gtExample>
	<return: #Collection of:#MccComment>
	^ (self mccStatistics environment mccCommentClasses
		collect:[ :aMccCommentClass | 
	aMccCommentClass hasWarnings ifTrue:[
		 aMccCommentClass -> aMccCommentClass warningSentences
		]
	ifFalse: [ aMccCommentClass -> #() ]
	]) reject: [ :a | a value isEmpty ].
]
