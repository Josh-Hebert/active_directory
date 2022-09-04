param
    ([Parameter(Mandatory=$true)] $JSONFile)
    

function CreateADGroup() {
    param (
        [Parameter(Mandatory=$true)] $groupObject
    )
    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}


function CreateADUser {
    param ( [Parameter(Mandatory=$true)] $userObject)
    
    #Pull out the name from the JSON object
    $name = $userObject.name
    $firstName,$lastName = $name.Split(" ")
    $password = $userObject.password
    
    #Generate a firstname.lastname structure for a username
    $userName = ($firstName + "." + $lastName).ToLower()
    $samAccountName = $userName
    $principalname = $userName

    # Actually create the AD user object
    New-ADUser -Name "$name" -GivenName $firstName -Surname $lastName -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount


    # Add users to appropriate groups
    foreach($group_name in $userObject.groups){
        

        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        {
            Write-Warning "User $name Not added to group $group_name becuase it does not exist"
        }
        
    }

    
}

$json = ( Get-Content $JSONFile | ConvertFrom-JSON)
$Global:Domain = $json.domain

foreach ( $group in $json.groups){
    CreateADGroup $group
}

foreach ( $user in $json.users){
    CreateADUser $user
}