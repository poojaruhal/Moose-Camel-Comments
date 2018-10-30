I represent a class comment


http://ws.stfx.eu/NLALC31ISLDR
sources := SourceFileArray new: 10.
sources at: 1 put: (SourceFiles at: 1).
sources at: 2 put: (SourceFiles at: 2).
sources at: 3 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV10.sources' asFileReference readStream).
sources at: 4 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV20.sources' asFileReference readStream).
sources at: 5 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV30.sources' asFileReference readStream).
sources at: 6 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\SqueakV39.sources' asFileReference readStream).
sources at: 7 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV50.sources' asFileReference readStream).
sources at: 8 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV60.sources' asFileReference readStream).
sources at: 9 put: ('C:\Users\Sabine\Documents\Pharo\images\moose-5.1\moose-5.0.changes' asFileReference readStream).
sources at: 10 put: ('C:\Users\Sabine\Documents\Pharo\images\moose-5.1\moose-6.0.changes' asFileReference readStream).
sources.

class := Float.

remoteString := class class instanceSide organization commentRemoteString.

changes := Array streamContents: [ :aStream | sources
	changeRecordsFrom: remoteString sourcePointer
	className: class name
	isMeta: false
	do: [ :each | aStream nextPut: each ] ].
