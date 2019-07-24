Class {
	#name : #PyLibrary,
	#superclass : #Object,
	#instVars : [
		'libName',
		'libPath',
		'stdout',
		'stderr',
		'arguments'
	],
	#classInstVars : [
		'lib'
	],
	#category : #PyLibrary
}

{ #category : #'instance creation' }
PyLibrary class >> uniqueInstance [
	| tmp2 |
	tmp2 := lib.
	^ tmp2 ifNil: [ lib := self new ] ifNotNil: [ tmp2 ]
]

{ #category : #accessing }
PyLibrary >> arguments [
	^ arguments
]

{ #category : #accessing }
PyLibrary >> arguments: arg1 [
	arguments := arg1
]

{ #category : #process }
PyLibrary >> buildArguments [
	| tmp2 |
	tmp2 := OrderedCollection with: libName.
	tmp2 addAll: arguments.
	^ tmp2 yourself
]

{ #category : #accessing }
PyLibrary >> initLib: arg1 name: arg2 [
	libPath := arg1.
	libName := arg2
]

{ #category : #accessing }
PyLibrary >> libName: arg1 [
	libName := arg1
]

{ #category : #accessing }
PyLibrary >> libPath: arg1 [
	libPath := arg1
]

{ #category : #process }
PyLibrary >> pyCall [
	| tmp2 |
	tmp2 := OSSUnixSubprocess new.
	tmp2
		command: 'python';
		arguments: self buildArguments;
		defaultWriteStreamCreationBlock: [ OSSVMProcess vmProcess systemAccessor makeNonBlockingPipe ];
		redirectStdout;
		createMissingStandardStreams: false;
		workingDirectory: libPath;
		environmentAt: 'HOME' put: libPath;
		addAllEnvVariablesFromParentWithoutOverride;
		runAndWaitOnExitDo: [ :arg1 :arg2 :arg3 | 
			stdout := arg2.
			stderr := arg3 ]
]

{ #category : #process }
PyLibrary >> pyCall: arg1 [
	| tmp2 |
	arguments := arg1.
	tmp2 := OSSUnixSubprocess new.
	tmp2
		command: 'python';
		arguments: self buildArguments;
		defaultWriteStreamCreationBlock: [ OSSVMProcess vmProcess systemAccessor makeNonBlockingPipe ];
		redirectStdout;
		createMissingStandardStreams: false;
		workingDirectory: libPath;
		environmentAt: 'HOME' put: libPath;
		addAllEnvVariablesFromParentWithoutOverride;
		runAndWaitOnExitDo: [ :arg2 :arg3 :arg4 | 
			stdout := arg3.
			stderr := arg4 ]
]

{ #category : #accessing }
PyLibrary >> stdout [
	^ stdout
]
