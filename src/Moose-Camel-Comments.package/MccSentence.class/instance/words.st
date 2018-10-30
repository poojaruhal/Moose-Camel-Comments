accessing
words
	<return: #Collection of: #MccWord>

	^ (self asString splitOn: String space) asArray
		select: #isNotEmpty
		thenCollect: [ :eachWordString | MccWord string: eachWordString ]