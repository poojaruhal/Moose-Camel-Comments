Array streamContents: [ :aStream |
	| result string |
	
	string := 'ha

object := Object new.

asdadasdasd

object printString.
object.

asfafasfj' copyReplaceAll: String cr with: String cr, '.'.


	result := (MccSmalltalkInCommentParser new sea) parse: string.
	
	[ result isNotEmpty and: [ string isNotEmpty ] ] whileTrue: [
		aStream nextPut: (result first as: String).
		aStream nextPut: (result second).
		string := result third as: String.
		result := (MccSmalltalkInCommentParser new sea) parse: string.
	] ]