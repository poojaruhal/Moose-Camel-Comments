navigation
allComments
	"Return a collection of all comments defined in this environment"
	<return: #Collection of: #MccComment>

	^ self methods collect: [ :aCompiledMethod | aCompiledMethod  ]