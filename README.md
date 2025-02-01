# Office 365 Group Membership Reporting

This Microsoft Graph SDK Powershell script runs a report on Entra ID group members and outputs into a CSV

Within the script update the following:
```powershell
# Define the Azure AD Group Object ID
$GroupId = "Add Your Entra ID Group ID"

# Define the output CSV file path
$CsvFilePath = "C:\AzureADGroupMembers.csv"
```

## Make sure your Powershell execution policy is set to:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
```

## Save the script and run
```powershell
.\Get-AzureGroupMembers.ps1
```

## Make sure your Powershell execution policy is set to:

For complete Office 365 / Entra ID Reporting & Auditing check out our platform:

[Office 365 Reporting Using InfraSOS](https://infrasos.com/office-365-reporting/)


