visiting
visitAssignmentNode: anAssignmentNode
	assignments add: anAssignmentNode variable.
	
	^ self resultFor: anAssignmentNode