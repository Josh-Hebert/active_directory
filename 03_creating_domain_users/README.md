# Creating Domain Users with Powershell and JSON
	1. Create a file called ad_schema.json and write some quick code:
		---code
			{
		"groups": [
			{
				"name": "CyberSecurity"
			}
		],

		"users": [
			{
				"first_name": "Josh",
				"last_name": "Hebert",
				"password": "anything",
				"username": "Josh.hebert",
				"groups": [
					"CyberSecurity"
				]
			}
			
		]
	}
		---

	2. Created a variable called $dc1 in order to create and enter PSSessions quick and easy.
	----shell
		$dc = New-PSSession 192.168.127.135 -Credential (Get-Credential)
 	----
 	3. Using the variable we just created we can move the ad_schema.json file over to the dc using the following cmdlet:
 		---shell
 		Copy-Item .\ad_schema.json -ToSession $dc C:\Windows\Tasks
 		---
 		This will move it into the C:\Windows\Tasks directory on the domain controller.
 	4. This allows you to enter the PSsession connecting to the DC and verify the file has been copied over.
 		---shell
 		Enter-PSSession $dc
 		---