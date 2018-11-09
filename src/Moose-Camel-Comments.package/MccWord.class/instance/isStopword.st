testing
isStopword

	^ self stopwords includes:(self string) asLowercase.