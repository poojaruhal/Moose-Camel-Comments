*Moose-Camel-Comments-Brick
gtViewTextIn: aView
	<gtView>

	^ aView textEditor
		title: 'Camel';
		priority: 0;
		text: [ self gtViewText ]