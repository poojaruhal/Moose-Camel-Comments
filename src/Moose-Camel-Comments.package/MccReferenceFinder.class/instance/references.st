searching
references
	"Find and return code artefact references from a comment within provided environment"
	<return: #Collection of: #MccReference>
	
	^ self comment sentences flatCollect: [ :aSentense |
		| theReferences |
		theReferences := self referencesIn: aSentense.
		theReferences do: [ :eachReference | eachReference comment: self comment ].
		theReferences ]