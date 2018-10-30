instance creation
all
	"Create a package enviroment with all packages in the system"
	<return: #MccPackageEnvironment>

	^ self withAll: RPackageOrganizer default packages