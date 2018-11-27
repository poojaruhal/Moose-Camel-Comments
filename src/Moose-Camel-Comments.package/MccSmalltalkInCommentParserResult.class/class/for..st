instance creation
for: anRBNode
	^ self new
		isValid: true;
		isPartiallyValid: true;
		filteredAST: anRBNode;
		originalAST: anRBNode copy