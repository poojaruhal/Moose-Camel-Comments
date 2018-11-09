accessing
totalNumberOfLines
	"return lines of code including comments except empty lines".
	
	^ self allEntities sum: [ :eachMethod | eachMethod linesOfCode - 1 ]