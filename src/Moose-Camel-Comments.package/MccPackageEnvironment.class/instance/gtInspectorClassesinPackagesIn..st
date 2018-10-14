ui
gtInspectorClassesinPackagesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastList
		title: 'Classes in Packages';
		display: [ self allClassesOfPackages flatCollect:[:eachAssociation | eachAssociation value ]].