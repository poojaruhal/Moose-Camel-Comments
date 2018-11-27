instance creation
errorFor: aRBNode
	^ (self resultFor: aRBNode)
		isValid: false;
		isPartiallyValid: false;
		errorNode: aRBNode