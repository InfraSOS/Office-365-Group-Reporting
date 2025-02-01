#
# Author: Andrew Fitzgerald
# Company: Infrasos.com
#
# Define the Azure AD Group Object ID
$GroupId = "3f19203d-0f67-4f6c-b710-939613c35c13"

# Define the output CSV file path
$CsvFilePath = "C:\Users\andyf\Documents\AzureADGroupMembers.csv"

# Function to check and install module if missing
function Ensure-ModuleInstalled {
    param ($ModuleName)
    if (!(Get-Module -ListAvailable -Name $ModuleName)) {
        Write-Host "🔍 Microsoft Graph module not found. Installing..." -ForegroundColor Yellow
        try {
            Install-Module $ModuleName -Scope CurrentUser -Force -ErrorAction Stop
            Write-Host "✅ Microsoft Graph module installed successfully!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to install $ModuleName module. Error: $_" -ForegroundColor Red
            exit
        }
    }
    Import-Module $ModuleName
}

# Ensure Microsoft Graph module is installed and imported
Ensure-ModuleInstalled -ModuleName "Microsoft.Graph"

# Connect to Microsoft Graph (Ensure you have the required permissions)
try {
    Connect-MgGraph -Scopes "GroupMember.Read.All"
} catch {
    Write-Host "❌ Error: Failed to connect to Microsoft Graph" -ForegroundColor Red
    exit
}

# Get members of the Azure AD Group
try {
    $GroupMembers = Get-MgGroupMember -GroupId $GroupId -All

    if ($GroupMembers.Count -eq 0) {
        Write-Host "⚠️ No members found in the group." -ForegroundColor Yellow
    } else {
        # Format output
        $FormattedMembers = $GroupMembers | ForEach-Object {
            [PSCustomObject]@{
                DisplayName       = $_.AdditionalProperties.displayName
                UserPrincipalName = $_.AdditionalProperties.userPrincipalName
                Id               = $_.Id
            }
        }

        # Display output in the terminal
        Write-Host "`n🔍 Azure AD Group Members:" -ForegroundColor Cyan
        $FormattedMembers | Format-Table -AutoSize

        # Export to CSV
        $FormattedMembers | Export-Csv -Path $CsvFilePath -NoTypeInformation -Encoding UTF8
        Write-Host "`n✅ Export successful! File saved at: $CsvFilePath" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Error: Unable to retrieve group members. $_" -ForegroundColor Red
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph
