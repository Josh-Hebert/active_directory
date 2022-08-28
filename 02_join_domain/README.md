# 02 Joining Workstation to Domain.
	1. Open up Termianl and input:
	---shell---
	Add-Computer -DomainName xyz.com -Credential xyz\Administrator -Force -Restart
	2. After reboot, a Domain user will need to be created in order to login to the workstation