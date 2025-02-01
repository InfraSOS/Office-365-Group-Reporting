# Office 365 Group Membership Reporting

This Microsoft Graph SDK Powershell script runs a report on Entra ID group members and outputs into a CSV

Within the script update the following:
```powershell
# Define the Azure AD Group Object ID
$GroupId = "Add Your Entra ID Group ID"

# Define the output CSV file path
$CsvFilePath = "C:\AzureADGroupMembers.csv"

## Make sure your Powershell execution policy is set to:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
