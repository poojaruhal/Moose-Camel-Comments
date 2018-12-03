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
MccStatisticsExamples >> mccStatistics [
	<gtExample>
	<return: #Instance of: #MccStatistics>
	
	^ (MccStatistics with: ((MccSystemEnvironment new) allClasses as:MccClasses))
]

{ #category : #navigation }
MccStatisticsExamples >> smalltalkHubProjectsTimestamp [
	<gtExample>
	<return: #Array of: 'Timestamp'>
	
	^ MccSmalltalkHubStatistics new timestampsByTimeline

]
