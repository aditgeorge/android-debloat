# Reading contents of the bloatware list and slecting the package column.
$headers = @("Name","Package")
$file_lines =(Import-Csv './bloat_list.csv' -Header $headers).Package
foreach($line in $file_lines)
{
    # If package name doesn't begin with com. or org. then display a warning
    If ($line -notmatch "(^com\..*)|(^org\..*)")
    {
        Write-Output "Warning: Unconventional package name: $line"
    }
    $command = "shell pm uninstall -k --user 0 $line"
    #adb.exe shell pm uninstall -k --user 0 com.package.name
    Write-Output "./adb.exe $command"
    # Start adb.exe; with the uninstall command as argument; in the same window (not a new terminal instance); wait for the process to finish
    Start-Process -FilePath "./adb.exe" -ArgumentList $command -NoNewWindow -Wait
}