accessing
commentStamps

|sources|

sources := Array new: 9.
sources at: 1 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV10.sources' asFileReference).
sources at: 2 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV20.sources' asFileReference).
sources at: 3 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV30.sources' asFileReference).
sources at: 4 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\SqueakV39.sources' asFileReference).
sources at: 5 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV40.sources' asFileReference).
sources at: 6 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV50.sources' asFileReference).
sources at: 7 put: ('C:\Users\Sabine\Documents\Pharo\vms\40-x86\PharoV60.sources' asFileReference).
sources at: 8 put: (SourceFiles at: 1).
sources at: 9 put: (SourceFiles at: 2).
sources.
"!AColorSelectorMorph commentStamp: 'gvc 5/18/2007 13:52'!"
sources do: [ :source |
	 ].
	^ commentStamps