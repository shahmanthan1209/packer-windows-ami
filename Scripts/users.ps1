#Below route commands will create route to the internet gateway in remote machine where internet access is restricted
$a = Get-NetRoute | WHERE {$_.DestinationPrefix -eq '0.0.0.0/0'} | SELECT { $_.Nexthop } | Format-Table -AutoSize -HideTableHeaders

$a = Get-NetRoute | WHERE {$_.DestinationPrefix -eq '0.0.0.0/0'} | SELECT { $_.Nexthop } | Format-Table -AutoSize -HideTableHeaders

route delete 169.254.169.254
route delete 169.254.169.250
route delete 169.254.169.251
route delete 169.254.169.249
route delete 169.254.169.123
route delete 169.254.169.253

route -p ADD 169.254.169.254 MASK  255.255.255.255 $a METRIC 25
route -p ADD 169.254.169.250 MASK  255.255.255.255 $a METRIC 25
route -p ADD 169.254.169.251 MASK  255.255.255.255 $a METRIC 25
route -p ADD 169.254.169.249 MASK  255.255.255.255 $a METRIC 25
route -p ADD 169.254.169.123 MASK  255.255.255.255 $a METRIC 25
route -p ADD 169.254.169.253 MASK  255.255.255.255 $a METRIC 25

# Install-WindowsFeature RDS-Licensing –IncludeAllSubFeature -IncludeManagementTools
# moved it to provisioning template

# This script will create multiple local user accounts using the content of a
# csv file and then add them to the local Administrators group and or second user group
# copy code below save it users.ps1

<# example CSV layout to be saved as C:\Users.csv
UserName,FullName,Description,Password
FirstName.Lastname,FirstNameLastname,Test Account,Password1
#>
$strComputer = $env:computername

# Import CSV to $AllUsers
$AllUsers = Import-CSV "C:\temp\S3Downloads\Users.csv"

foreach ($User in $AllUsers) {
    write-host Creating user account $user.Username

    $objOU = [adsi]"WinNT://."

    # Create user account
    $objUser = $objOU.Create("User", $User.Username)

    # Set password
    $objuser.setPassword($User.Password)

    # Set FullName
    $objUser.put("FullName", $User.FullName)

    # Set Description
    $objUser.put("Description", $User.Description)

    # User must change password on next log on
    $objuser.PasswordExpired = 0

    # User cannot change password and never expire
    $objUser.UserFlags = 64 + 65536

    # Save the info
    $objuser.SetInfo()

    #Add each user account to local Administrators group
    $computer = [ADSI]("WinNT://" + $strComputer + ",computer")
    $group = $computer.psbase.children.find("Administrators")
    $group.Add("WinNT://" + $strComputer + "/" + "$user.Username")

    #Option add each user account to Second users group
    $computer = [ADSI]("WinNT://" + $strComputer + ",computer")
    $group = $computer.psbase.children.find("Remote Desktop Users")
    $group.Add("WinNT://" + $strComputer + "/" + $user.Username)
}
