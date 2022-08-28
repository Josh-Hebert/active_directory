param([Parameter(Mandatory=$true)] $JSONFile)


function CreateADUser {
    param ( [Parameter(Mandatory=$true)] $userObject)

    echo $userObject
        
    
    
}

$json = ( Get-Content $JSONFile | ConvertFrom-Json)
foreach ( $user in $json.users){
    CreateADUser $user
}

echo $json.users