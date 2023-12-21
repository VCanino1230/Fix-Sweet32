#updates the registry key to enable the Authenticode signature verification improvements

$regpath_1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'
$name = "Enabled"


# if(!(Test-Path $regpath_1)){
#     New-Item -Path $regpath_1 -Force | Out-Null
#     New-ItemProperty -Path $regpath_1 -name $name -value $value -PropertyType DWord -Force | Out-Null

# }
# else {
#     Write-Verbose "Triple DES 168 Key already exists. Adding in the value" -Verbose
#     New-ItemProperty -Path $regpath_1 -name $name -value $value -PropertyType DWord -Force | Out-Null

# }

#tests for registry key exists currently. the values are from variables top of code. If it already exists, a verbose message declares it.
function Create_Key{
    Write-Host -f Yellow "Checking if Registry Key Exists...."
    if(!(Test-Path $regpath_1)){
        Write-Host -f Yellow "Triple DES 168 Key isn't there and will be added"
        New-Item -Path $regpath_1 -Force | Out-Null
        Write-Host -f Green "Triple DES 168 Key has been added"
    }
    else{
        Write-Host -f Green  "Triple DES 168 Key already exists!" 
    }

}

#tests for the value of specified Key Name you provide. I use the same variables top of code. If it already exists, a verbose message declares it.
function Create_Value{

    if($null -ne (Get-ItemProperty -Path $regpath_1 -Name $name -ErrorAction SilentlyContinue)){
        Write-Host -f Yellow "Value exists. Checking if the correct values are added in Triple DES 168 Key...."
        if((Get-ItemPropertyValue -Path $regpath_1 -Name $name -ErrorAction SilentlyContinue) -ne 0){
            Set-ItemPropertyValue -Path $regpath_1 -Name $name -Value 0 -PropertyType DWord -Force | Out-Null
            Write-Host -f Green "Registry Key Value have been updated!"
        }else{
            Write-Host -f Green "What currently exists is good to go!"
        }
    }else{
        Write-Host -f Red "Need to add this registry key"
        New-ItemProperty -Path $regpath_1 -Name $name -Value 0 -PropertyType DWord -Force | Out-Null
        Write-Host -f Green "Registry Key Value has been added!"
    }

}

Create_Key
Create_Value
