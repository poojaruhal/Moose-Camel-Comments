navigation
allMethods
	"Return all methods in this environment"
	<return: #Collection of: #CompiledMethod>

	^ self allClasses flatCollect: [ :eachClass | eachClass methods ]