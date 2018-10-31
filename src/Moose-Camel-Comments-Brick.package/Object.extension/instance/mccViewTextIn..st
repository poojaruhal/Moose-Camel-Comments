*Moose-Camel-Comments-Brick
mccViewTextIn: aView
	<gtView>
	
	self mccComment isEmpty
		ifTrue: [ ^ aView empty ].
	
	^ aView textEditor
		priority: 0;
		title: 'Camel';
		text: [ self mccComment gtViewText ]