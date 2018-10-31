browsing
browseDueTo: anEvent
	"Browse reference artefact"

	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: self artefact).
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self artefact;
		sourceElement: anEvent target)