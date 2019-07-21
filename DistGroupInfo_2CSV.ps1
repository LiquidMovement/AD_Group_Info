$states = import-csv -path "C:\temp\LO_ST\States.csv" -header ST

foreach($state in $states){
    $st = $state.ST
    $info = Get-ADGroup -Identity $st -Properties mail,displayname,members
    $mail = $info.mail
    $members = $info.Members
    $grpType = $info.GroupCategory

    $stateFull = Read-Host "Enter State for $st"

    "State : $stateFull" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
    "Name : $st" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
    "Email : $mail" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
    "Group Type : $grpType" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
    "Members :" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append

    foreach($user in $members){
        $user = Get-ADUser -Identity $user -Properties UserPrincipalName | Select-Object UserPrincipalName
        $upn = $user.UserPrincipalName
        $upn | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
    }
    "`n" | out-file "C:\temp\LO_ST\DistGroups.csv" -Append
}