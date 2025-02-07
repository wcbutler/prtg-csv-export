$prtgServer = "https://yourserver.com"
$apiToken = "yourapitoken"

$outputCsv = "C:\Users\wcbutler\Downloads\devices.csv"

$devicesUrl = "$prtgServer/api/table.json?content=devices&count=50000&output=json&columns=objid,device,host,tags,group&apitoken=$apiToken"
try {
    $devices = Invoke-RestMethod -Uri $devicesUrl -Method Get
    if ($devices.devices) {
        $devices.devices | Select-Object objid, device, host, tags, group | Export-Csv -Path $outputCsv -NoTypeInformation
        Write-Host "Devices exported to $outputCsv"
    } else {
        Write-Host "No devices found."
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}