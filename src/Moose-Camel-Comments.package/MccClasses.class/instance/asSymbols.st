converting
asSymbols

	^ self allClasses collect: [ :eachClass | eachClass name asLowercase asSymbol ]