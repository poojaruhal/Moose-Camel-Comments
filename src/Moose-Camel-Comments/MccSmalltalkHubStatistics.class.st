"
I am responsible for showing timestamps and projects from smalltalk hub.
I have data from smalltalk hub in the form of JSON.
I can get JSON either from smalltalkhubDataExample or smalltalkhubFile.
Once I have correct data, I can give you the list of project as by timeline.
My method timestampsByTimeline is responsibile for providing timestamps of all the project sorted.

I can be used with: 

smalltalkHubProjects:= MccSmalltalkHubStatistics new.
smalltalkHubProjects timestampsByTimeline.


"
Class {
	#name : #MccSmalltalkHubStatistics,
	#superclass : #MccStatistics,
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #walking }
MccSmalltalkHubStatistics >> projects [
	<return:#Dictionary>
	
	^ self smalltalkHubJson collect:[:each | MccSmalltalkHubProjectStatistics from:each]
]

{ #category : #'accessing - data' }
MccSmalltalkHubStatistics >> smalltalkHubJson [

	^ NeoJSONReader fromString: self smalltalkhubFile.

]

{ #category : #'accessing - data' }
MccSmalltalkHubStatistics >> smalltalkhubDataExample [
	
	^ '[
  {
    "user": "OlesDobosevych",
    "project": "15Puzzle",
    "data": {
      "tagsString": "game,puzzle,logic",
      "website": "cs.ucu.edu.ua",
      "publicWrite": false,
      "owner": "fcb880d8-1363-464f-ae80-193d311574e5",
      "projectDescription": "The simple 15 Puzzle.",
      "path": "~OlesDobosevych/15Puzzle",
      "commitHookPassword": "",
      "name": "15Puzzle",
      "created": 3652545738,
      "sid": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
      "commitHookUsername": "",
      "contributors": [
        "c064af0d-4332-4a79-a76d-77238b906e62",
        "a4160e54-656b-4ed8-a9da-7242444c498d"
      ],
      "license": "MIT",
      "commitHookUrl": "",
      "public": true
    },
    "commits": [
      {
        "type": "commit",
        "projectId": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
        "versionName": "15 Puzzle-StephaneDucasse.4",
        "title": "committed to",
        "project": "OlesDobosevych/15Puzzle",
        "description": "hacking with oles and matvii\rmathieu",
        "email": "stephane.ducasse@inria.fr",
        "created": 3652691033,
        "sid": "4dcdd865-9a4c-46a3-96a4-9633017cf454",
        "username": "StephaneDucasse",
        "timestamp": 3652691033
      },
      {
        "type": "commit",
        "projectId": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
        "versionName": "15 Puzzle-MattKovtun.3",
        "title": "committed to",
        "project": "OlesDobosevych/15Puzzle",
        "description": "- added function which checks if the puzzle is solved.\r- added \"The End\" title to the game. \r\r\rFixes : \r \t- Change \"The End\" title to the center of the \tgame, add some animations to it.\r\t- Clean up the code.",
        "email": "kovtun_m@ucu.edu.ua",
        "created": 3652631346,
        "sid": "a9e1f221-a0fd-4ece-a3ce-7651caf4f20b",
        "username": "MattKovtun",
        "timestamp": 3652631346
      },
      {
        "type": "commit",
        "projectId": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
        "versionName": "15 Puzzle-MattKovtun.2",
        "title": "committed to",
        "project": "OlesDobosevych/15Puzzle",
        "description": " - added correct shuffle order\r",
        "email": "kovtun_m@ucu.edu.ua",
        "created": 3652628938,
        "sid": "9cd0dd98-3244-447b-970f-a7e57f47d23b",
        "username": "MattKovtun",
        "timestamp": 3652628938
      },
      {
        "type": "commit",
        "projectId": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
        "versionName": "15 Puzzle-OlesDobosevych.1",
        "title": "committed to",
        "project": "OlesDobosevych/15Puzzle",
        "description": "The project has been renamed.",
        "email": "dobosevych@ucu.edu.ua",
        "created": 3652545983,
        "sid": "ac5a12d0-dcd5-457e-8164-a3e70a722f15",
        "username": "OlesDobosevych",
        "timestamp": 3652545983
      },
      {
        "type": "commit",
        "projectId": "a3c70647-2b80-412f-8eef-8010e0cb9ad7",
        "versionName": "TheTile-OlesDobosevych.10",
        "title": "committed to",
        "project": "OlesDobosevych/15Puzzle",
        "description": "TileMorph, BoardMorph and moves are added.",
        "email": "dobosevych@ucu.edu.ua",
        "created": 3652545921,
        "sid": "95fe4fc4-1e45-43e1-b50f-652abbad824a",
        "username": "OlesDobosevych",
        "timestamp": 3652545921
      }
    ],
    "contributers": [
      {
        "location": "",
        "website": "",
        "watching": [

        ],
        "admin": false,
        "fullName": "MattKovtun",
        "path": "~MattKovtun",
        "email": "kovtun_m@ucu.edu.ua",
        "name": "MattKovtun",
        "created": 3652442752,
        "mcUsername": "",
        "username": "MattKovtun",
        "sid": "c064af0d-4332-4a79-a76d-77238b906e62"
      },
      {
        "location": "Inria Lille Nord Europe",
        "website": "stephane.ducasse.free.fr",
        "watching": [
          "22a3af86-96e8-4271-bda7-dd4eeade8f7d"
        ],
        "admin": false,
        "fullName": "Stephane Ducasse",
        "path": "~StephaneDucasse",
        "email": "stephane.ducasse@inria.fr",
        "name": "StephaneDucasse",
        "created": 3519316102,
        "mcUsername": "",
        "username": "StephaneDucasse",
        "sid": "a4160e54-656b-4ed8-a9da-7242444c498d"
      }
    ]
  }
]'.
]

{ #category : #'accessing - data' }
MccSmalltalkHubStatistics >> smalltalkhubFile [
	
		 ^ '/Users/poojarani/Downloads/smalltalk_hub_projects_20181121124234.json' asFileReference contents.
]

{ #category : #walking }
MccSmalltalkHubStatistics >> timestampsByTimeline [
	<return:#Timestamp>
	
	^ ((self projects collect:#timestamp)
			select:[:aTimestamp | aTimestamp ~=''])
			sort:[:a :b | a asDateAndTime   < b asDateAndTime ]
	
]
