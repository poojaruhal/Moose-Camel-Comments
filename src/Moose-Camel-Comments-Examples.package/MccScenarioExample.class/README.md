Pakcage that we are considering.
[[[
aMccPackageEnviornment := MccPackageEnvironment ofPackages: #(Brick Bloc).
]]]

Collect all the class from mentioned packages.
[[[
			mccClasses := aMccPackageEnviornment allMccClasses.
			]]]

Collect all the classes with comments.
[[[
			mccCommentClasses := mccClasses mccCommentClasses.
			]]]

Take a comment as a example.
[[[
			mccComment := mccCommentClasses at:11.
			]]]

Actual reference to the classes.
[[[
			referencedClassesFromProject:= mccComment referencedClassesFromProject.
	]]]

Collect potential classes from the comment.
[[[
			mccComment collectReferenceClassesFromComment ]]]




