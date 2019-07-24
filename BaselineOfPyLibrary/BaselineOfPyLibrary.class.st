Class {
	#name : #BaselineOfPyLibrary,
	#superclass : #BaselineOf,
	#category : #BaselineOfPyLibrary
}

{ #category : #baselines }
BaselineOfPyLibrary >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'PyLibrary' ]
]
