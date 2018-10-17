baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec
			baseline: 'Camel' with: [ spec repository: 'github://poojaruhal65/Moose-Camel/src' ].

		spec package: #'Moose-Camel-Comments' with: [ spec requires: #(Camel) ].
		spec group: 'default' with: #('Moose-Camel-Comments') ]