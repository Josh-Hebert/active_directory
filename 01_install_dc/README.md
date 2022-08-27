# 01 Installing the Domain Controller

1. Use 'sconfig' to:
	-change the hostname
	-change the IP address and set static
	-change the DNS server to itself
2. We can look for what we want to install with command something like:
	---shell
	Get-Windowsfeature | ? {$_.Name -LIKE “AD*”}

	---shell


3. Then we can Install the Active Directory Windows Feature we find:
	---shell
	install-windowsfeature AD-Domain-Services -IncludemanagementTools
	---shell
4. Then we can import ADDS Module:
	---shell
	import-Module ADDSDeployment
	---shell
5. Install ADDS Forest
	---shell
	install-ADDSForest
	---shell
	Enter your values that you would like for DomainName/SafeModeAdministratorPassword and confirm.
	Then click Y.
