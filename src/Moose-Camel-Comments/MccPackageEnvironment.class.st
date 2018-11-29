"
I am an environment consisting of packages
"
Class {
	#name : #MccPackageEnvironment,
	#superclass : #MccEnvironment,
	#instVars : [
		'packages'
	],
	#category : #'Moose-Camel-Comments-Model - Environment'
}

{ #category : #'instance creation' }
MccPackageEnvironment class >> all [
	"Create a package enviroment with all packages in the system"
	<return: #MccPackageEnvironment>

	^ self withAll: RPackageOrganizer default packages
]

{ #category : #'instance creation' }
MccPackageEnvironment class >> allNamed: thePackageNames [
	^ self withAll: (thePackageNames collect: #asPackage)
]

{ #category : #'instance creation' }
MccPackageEnvironment class >> named: aPackageName [
	^ self with: aPackageName asPackage
]

{ #category : #'instance creation' }
MccPackageEnvironment class >> with: aPackage [
	^ self new packages: { aPackage }
]

{ #category : #'instance creation' }
MccPackageEnvironment class >> withAll: aCollectionOfPackages [
	^ self new packages: aCollectionOfPackages
]

{ #category : #navigation }
MccPackageEnvironment >> allClasses [
	<return: #Array of: #Classes>
	
	^ self packages flatCollect: #definedClasses
]

{ #category : #'gt-inspector-extension' }
MccPackageEnvironment >> gtInspectorPackagesIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Packages' translated;
		display: [ self packages ];
		format: #name
]

{ #category : #initialization }
MccPackageEnvironment >> initialize [
	super initialize.

	packages := OrderedCollection new
]

{ #category : #accessing }
MccPackageEnvironment >> packages [
	<return: #Array of: #RPackage>
	
	^ packages	
]

{ #category : #accessing }
MccPackageEnvironment >> packages: thePackages [
	packages := thePackages
]
