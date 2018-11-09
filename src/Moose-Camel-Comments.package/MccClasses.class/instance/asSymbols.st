converting
asSymbols

	^ self collect: [ :eachClass | eachClass name asLowercase asSymbol ]