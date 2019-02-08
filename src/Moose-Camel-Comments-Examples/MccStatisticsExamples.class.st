"
<Example>
hub:= MccSmalltalkHubStatistics new.
projects:= hub projects.
projects groupBy: #commits.
first:= projects first.
first timestamp year.
timestamps:= hub timestampsByTimeline.
hub projectsInBarChartByTimeline. 
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
	
	|anExternalEnvironment mccCommentAnalysis|
	
	anExternalEnvironment := MccExternalEnvironmentExamples new externalEnvironmentModel.
	mccCommentAnalysis := MccCommentStatistics with: anExternalEnvironment.
	^ mccCommentAnalysis metrics.
]

{ #category : #navigation }
MccStatisticsExamples >> mccStatistics [
	<gtExample>
	<return: #Instance of: #MccStatistics>
	
	^ (MccStatistics with: ((MccSystemEnvironment new) allClasses as:MccClasses))
]

{ #category : #navigation }
MccStatisticsExamples >> smalltalkHubProjectsTimestamp [
	<gtExample>
	<return: #Array of: 'Timestamp'>
	
	^ MccSmalltalkHubStatistics new timestampsByYear

]
