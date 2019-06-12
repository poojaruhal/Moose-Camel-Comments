"
I represent a class with comment. I contain methods that also have comments that reference other classes, variables or methods.

Users can reference other classes directly, for example:
 - MccClassWithoutComment is a direct and precise reference to a class that does not have a comment
 - ClassWithoutComment is a direct but partial reference to a class that omits package prefix
 - ""class without comment"" is a class referene given in natural language. Our aim is to detect such references and show them to user
"
Class {
	#name : #MccClassWithComment,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Artefacts'
}

{ #category : #accessing }
MccClassWithComment >> classesWithComment [
	"all classes with comments from MooseEnvironment"
	<gtExample>
		
	^ (self mooseEnvironment allClasses select: #hasComment) asOrderedCollection.
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> distributeStrats [
	<gtExample>
	"chose 363 comments using random sampling approach"
	|allClasses strats|
	
	allClasses := self classesWithComment.
	
	^ strats := (allClasses collect: [ :e | 
	|length|
	length := e comment sentences size.
	length = 1
	ifTrue: [ #'1-1' -> e]
	ifFalse: [ 
		length = 2
		ifTrue: [ #'2-2' -> e ]
		ifFalse: [ 
			(length between: 3 and: 6) 
			ifTrue: [ #'3-6' -> e ]
			ifFalse: [ #'7-272' -> e]
		 ]
	  ]])groupedBy: [ :e | e key  ] .
]

{ #category : #accessing }
MccClassWithComment >> environment [ 
	"all classes with comments from systemEnvironment"
	<gtExample>
		
	^ MccSystemEnvironmentExamples new.
]

{ #category : #accessing }
MccClassWithComment >> methodsWithComment [
	"I am a method with comment"
	
	
]

{ #category : #accessing }
MccClassWithComment >> mooseEnvironment [
	"all classes with comments from mooseEnvironment"

	<gtExample>
	| otherFileReference mooseModelEnvironment |
	
	otherFileReference := '/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/Moose-Model-CSV/pharo7-moose-model-classes-comments-withoutHeader.csv'
		asFileReference.
	
	mooseModelEnvironment := MccExternalEnvironment fromCSV: otherFileReference of: 7.
	^ mooseModelEnvironment
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> plotRandomSamplingDistribution [
	"chose 363 comments using random sampling approach"

	<gtExample>
	| sampleSetFreq b ds |
	
	sampleSetFreq := self randomSamplingOfExternalEnvironment associations
		collect: [ :e | e key -> e value size ].
		
	b := RTGrapher new.
	b extent: 300 @ 300.
	ds := RTData new.
	ds dotShape
		color: [ :e | 
			e value = 0
				ifTrue: [ Color blue alpha: 0.1 ]
				ifFalse: [ Color red alpha: 0.8 ] ].
	ds points: sampleSetFreq.
	ds x: #key.
	ds y: #value.
	b add: ds.
	b axisX noDecimal.
	b axisY noDecimal.
	^ b
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> randomSamplingOfExternalEnvironment [
	<gtExample>
	"chose 363 comments using random sampling approach"
	|allClasses|
	
	allClasses := self classesWithComment.
	
	^ ((((1 to: 363)  collect: [:e |
		|aClass|
	aClass := allClasses atRandom.
	allClasses remove: aClass.
	 aClass.
	   ]) collect: [:e | 	e comment sentences size
	 ]) sorted) groupedBy: [ :e | e value ].

]

{ #category : #accessing }
MccClassWithComment >> selectedClassesComment [
	"selected classes comment for manual study from MooseEnvironment"
	<gtExample>
		
	^((self mooseEnvironment allClasses select:[:e | (self selectedClassesForManualStudy) includes: e name]) select:#hasComment) asOrderedCollection.
]

{ #category : #accessing }
MccClassWithComment >> selectedClassesForManualStudy [
	"selected classes for manual study with comments from MooseEnvironment"
		
	<gtExample>
	
	^ #('SugsStoresIntoInstVar' 'ManifestRingCoreKernel' 'FailingTestResourceTestCase' 'IceTipAddSSHCredentialsModel' 'OCThisContextVariable' 'EpClassChange' 'OSWindowExposeEvent' 'FillStyleBorder' 'RGContainerTest' 'IceTipAbstractCredentialCommand' 'ClyClassContextOfFullBrowser' 'FFIExternalEnumerationTests' 'FLPrimitiveCluster' 'TApplyingOnClassSide' 'InlineTextDiffBuilder' 'WatchpointWindow' 'GLMPortReference' 'RPackageTestCase' 'ClyClassWithFlags' 'MCWorkingHistoryBrowser' 'WeakIdentityValueDictionaryTests' 'AndreasSystemProfilerTest' 'EpHelp' 'TIndexAccess' 'EmptyLayout' 'FLContextSerializationTest' 'ClassTagAdded' 'OSWindowMoveEvent' 'MCClassDefinition' 'ZnEndianessReadWriteStream' 'FTOutline' 'RFASTTranslator' 'EpBehaviorNameChange' 'SugsDeprecateMethod' 'PreorderGuideTest' 'OSTouchRotationEvent' 'FLSerializationError' 'LockableTabMorph' 'ExampleForTest12' 'FindReplaceService' 'FastTablePresenter' 'PrivacyChangedAnnoucement' 'HelpBrowserTest' 'IceTipGitHubRepositoryPanel' 'IdentityTransform' 'EpLogBrowserOperationVisitor' 'FLPositive64SmallIntegerCluster' 'PharoSyntaxTutorialTest' 'ClySortMethodByPackageFunction' 'ClyCritiqueMenuItemMorph' 'GLMMorphicPagerRenderer' 'StrikeFontStoredSetting' 'FLSingletonMockEnforced' 'GoferMerge' 'RBAddClassTraitChange' 'ManifestCollectionsStrings' 'MCReader' 'RFNewValueReification' 'EpBehaviorChange' 'AllocationTest' 'TickSelectionCheckboxButtonMorph' 'ManifestFiles' 'MCVersionLoaderStopped' 'ExampleForTest11' 'NECVarTypeGuesser' 'SpecDemoCheckboxesPage' 'WideCharacterSetTest' 'RbScriptingSetBeforeModel' 'FFICompilerPluginTests' 'MorphicImageAdapter' 'TAddForUniquenessTest' 'AnimationSettings' 'RFReceiverReification' 'GLMPopupBrick' 'RGNamespace' 'SDL_Version' 'DateAndTimeTest' 'EpMethodRemoval' 'RubSmalltalkCodeMode' 'ManifestSystemLocalization' 'ManifestCollectionsSupport' 'ClySugsMethodContext' 'IceGitHubBranchSelectCommand' 'NNavDirectionParent' 'RubPrimarySelectionUpdatedInModel' 'GTDebuggerSystemSettings' 'NavigationHistory' 'Model' 'MorphTreeColumn' 'KMKeymapTest' 'RBPharoBootstrapRule' 'AbstractEnumerationVisitorTest' 'RePatternCodeRule' 'RFSenderReification' 'ClyClassSideBoldTableDecorator' 'RBSearchingLiteralRule' 'FLTraitSerializationTest' 'RBIfTrueReturnsRule' 'ClyOverriddenMethodTag' 'IceTipAction' 'GTBrowseMethodDebuggerAction' 'EpBehaviorCommentChange' 'SmallDictionaryTest' 'TimeTest' 'ClySpotterModel' 'MD5Test' 'FIFOQueueTests' 'EpProtocolChange' 'KeyNotFound' 'PackageNodeExample' 'LargeNegativeInteger' 'RPackageRenamed' 'ProportionalLayout' 'GRTemporaryNeitherReadNorWrittenRule' 'SparseLargeArray' 'GLMLipsumWithSegmentsExample' 'OSTouchGestureNeedingThresholdDetector' 'TOccurrencesTest' 'ShAbstractClassBuilderTest' 'GTSpotterEventCollectorTest' 'FinderClassNode' 'RBAddMetaclassChange' 'LazyClassListExample' 'FFITestStructureByPlatform' 'OSTouchThreeFingersScrollEndEvent' 'OSTouchOneFingerHoldEvent' 'BehaviorTest' 'WeakRegistryTest' 'SDL2' 'AdditionalMethodStateTest' 'ColorChooserMorph' 'ShNoChangesInClass' 'SDL_MouseButtonEvent' 'FLGlobalCluster' 'EyeMethodContextInspector' 'MCMockAPoolDictionary' 'ZipWriteStreamTests' 'ClyExplicitAbstractClassExample' 'TDictionaryImplementationTest' 'ReSettings' 'IceTipRemoveFromRepositoryPackageCommand' 'CannotDeleteFileException' 'Abort' 'RenrakuRuleCreationHelp' 'CallbackForWin64X64' 'ManifestNetworkUUID' 'RBRefactoringClassesHelp' 'OmSessionStoreUpdated' 'FLSmallIntegerCluster' 'IceNothingToCommit' 'SortFunctionTest' 'MCSubDirectoryRepositoryTest' 'ReLogExceptionStrategy' 'FFIExternalStructurePlatformTests' 'RubCancelEditRequested' 'FormCanvas' 'RBBrowserEnvironmentsClassesHelp' 'DADependentPackageItemDiff' 'FLSerializationTest' 'LGitSafeFFICalloutMethodBuilder' 'WeakKeyAssociation' 'ClyAbstractClassExample' 'SHStyleElement' 'TonelCommentScanner' 'ReTestClassNotInPackageWithTestEndingName' 'RBLiteralArrayCharactersRule' 'PointerLayout' 'ShSuperclassChangedDetector' 'SpaceTallyItem' 'StoredSettingsMergerTest' 'MetacelloLookupProjectSpecForLoad' 'GLMBrickRubricStyle' 'RBAddProtocolChange' 'EpLogBrowserOperation' 'CannotDecompileNativeBoostCalls' 'ReEntityCriticized' 'IllegalResumeAttempt' 'IceTipCommitDiffModel' 'LGitDiffDelta' 'ClyInheritedTraitScope' 'OSTouchActionPointerEvent' 'OSWindowEventVisitor' 'ImageModel' 'TextDoIt' 'BISettingPreviewer' 'RBAddPoolVariableChange' 'TickingWindowModel' 'IceTipCommand' 'IceTipItemPosition' 'KMPragmaKeymapBuilder' 'RGSlice' 'TreeNodeModel' 'ClyTraitMethodDecorator' 'TextModel' 'RBSendsMethodDictRule' 'SpecPragmaCollector' 'GLMWindowRequest' 'TraitAlias' 'DADependencyFromClass' 'ReExceptionProperty' 'VTermTestRunner' 'Notification' 'NOCModel' 'ProtocolAdded' 'BalloonEngine' 'RBRemoveClassChange' 'IceUnbornProjectReader' 'FLMaterialization' 'ClyGroupedCritiqueResult' 'HaltOnCountIconStyler' 'AthensCubicBezier' 'TabManagerModel' 'IceSemanticVersion' 'OverridesDeprecatedMethodRule' 'TPointAccess' 'NECPreferences' 'FinderPragmaMethodNode' 'RBAddClassVariableChange' 'GLMDropDownListPresentation' 'GTRawObjectVariablesBrowser' 'MCCodeTool' 'IceGitHubPullRequestDataSource' 'GTBytecodeDebuggerSession' 'GLMAnnouncer' 'MethodAdded' 'ShSmalltalkGlobalsEnvironment' 'ZnRequestResponseHandledEvent' 'IceTipInstallVersionCommand' 'IceTipPullCommand' 'RBNullFormatter' 'TraitMethodDescription' 'HECharacter' 'RBRemoveParameterRefactoring' 'SycMethodCommand' 'GLMEmptyPopupBrick' 'SycNewClassCreationCommand' 'FFICallbackType' 'AthensFontDescription' 'AthensCairoSurface' 'RxMatchOptimizer' 'HETrait' 'FloatingPointException' 'IceTipRepositoriesBrowser' 'RBCascadeNode' 'ClyClassGroupProvider' 'EUCTextConverter' 'GTFilter' 'ClyAllVariablesQuery' 'IceTipRepairFetchRemoteBranch' 'RFMethodReification' 'RBLiteralArrayContainsSuspiciousTrueFalseOrNilRule' 'SycMoveMethodsToPackageCommand' 'InstanceVariableSlot' 'ClyPackageScope' 'BaseSlot' 'DualChangeSorterApplication' 'ModificationForbidden' 'RubHoverHighlightSegmentMorph' 'RBDefineBasicCheckRule' 'ClyAllClassVariablesQuery' 'FBDASTBuilder' 'OSWindowWorldMorph' 'ClyGlobalVariable' 'RBRefersToClassRule' 'ReAbstractRule' 'RBCompositeRefactoryChange' 'ZipDirectoryMember' 'BalloonMorph' 'HEExtendedEnvironment' 'RBPackageEnvironment' 'IRMethod' 'DialogWindow' 'GLMMorphicFastTreeRenderer' 'ChangeSorterApplication' 'IceTipEditCredentialCommand' 'RBAddClassRefactoring' 'IceBasicProjectReader' 'PreDebugResumeDebugAction' 'GTEventRecorderSettings' 'TimeZone' 'RBMetaclass2' 'SpecExamples' 'ZnServerSession' 'RussianEnvironment' 'GLMOSWindowWorldMorph' 'FLPointCluster' 'NullAnnotationContext' 'CNGBTextConverter' 'IceTipRepairCheckoutBranch' 'RBCommentNodeVisitor' 'SimpleSwitchMorph' 'ReSourceAnchor' 'IceTipBrowser' 'ZnEntity' 'FTExampleMethodTableDataSource' 'SycInspectVariableCommand' 'ClyItemCellMorph' 'TableContainerPresenter' 'ClyFindMethodInBrowserCommand' 'RBMoveClassTransformation' 'AthensSurface' 'FBDLoopScanner' 'RBAbstractClass' 'OCCompilerNotifyingTest' 'ClyTypedQuery' 'ClyItemStringFilter' 'FT2Constants' 'LayoutFrame' 'RubFloatingEditorBuilder' 'ClyMethodVisibilityLevel' 'FFICallbackReturnValue' 'BottomBorder' 'ClyAllClassGroupsQuery' 'WidgetExamples' 'ListPresenter' 'BitBlt' 'TraitedClass' 'AthensSceneView' 'ProcessList' 'Privacy' 'MorphicUIBugTest' 'Point' 'ExternalData' 'FFIUnknownLibrary' 'ClyInheritedMethodGroup' 'SycMessageOriginHack' 'RBMethodName' 'IceTipGitHubPullRequestListBrowser' 'EncoderForV3' 'Integer' 'PharoDocCommentNode' 'RxsPredicate' 'RBAddReturnStatementTransformation' 'RBClassModelFactory' 'FT2BitmapSize' 'RBRenameVariableTransformation' 'ExternalStructure' 'AthensPathConverter' 'AnnouncementSetWithExclusions' 'OCASTTranslator' 'RBAllAnyNoneSatisfyRule' 'ShiftClassInstaller' 'ClyOldMessageBrowserQuery' 'MD5NonPrimitive' 'GLMPresentation' 'FTAllItemsStrategy' 'ImageMorph' 'ClyItemLocalHierarchyProperty' 'RBTrueFalseDuplicationRule' 'ClyMethodSourcesQuery' 'PermaLink' 'ClyEnvironmentPlugin' 'FFIExternalStructureReferenceHandle' 'ZdcByteArrayManager' 'MetacelloCommandLineHandler' 'Class' 'CornerRounder' 'FTPClient' 'DateParser' 'Color' 'ExpanderMorphContracted' 'RBRefactoryTyper' 'HermesCommandLineHandler' 'ClySystemEnvironment' 'GTEventCollector')
]

{ #category : #'as yet unclassified' }
MccClassWithComment >> stratifiedSamplingOfExternalEnvironment [
	"chose 363 comments using stratified sampling approach"

	<gtExample>
	| group1 group2 group3 group4 strataSampleSet |
	group1 := self distributeStrats value at: #'1-1'.
	group2 := self distributeStrats value at: #'2-2'.
	group3 := self distributeStrats value at: #'3-6'.
	group4 := self distributeStrats value at: #'7-272'.
	strataSampleSet := OrderedCollection new.
	
	strataSampleSet
		addAll:
			(((1 to: 175)
				collect: [ :e | 
					| aClass |
					aClass := group1 atRandom.
					group1 remove: aClass.
					aClass value ]),
			((1 to: 55)
				collect: [ :e | 
					| aClass |
					aClass := group2 atRandom.
					group2 remove: aClass.
					aClass value ]),
				
			((1 to: 69)
				collect: [ :e | 
					| aClass |
					aClass := group3 atRandom.
					group3 remove: aClass.
					aClass value ]),
				
		((1 to: 66)
				collect: [ :e | 
					| aClass |
					aClass := group4 atRandom.
					group4 remove: aClass.
					aClass value ])).
				
	^ strataSampleSet
]
