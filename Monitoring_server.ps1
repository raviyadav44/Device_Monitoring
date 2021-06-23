while ($true)
{

 $Date = Get-Date -DisplayHint Date -Format MM/dd/yyyy
 $Time = Get-date -DisplayHint Time -Format HH:MM:ss

 $SystemMemory= Get-WmiObject -Class win32_operatingsystem 


 $TotalMemory_GB=[math]::Round(((($SystemMemory.TotalvisibleMemorySize)/1024)/1024),2)

  
 $FreeMemory_GB=[math]::Round(((($SystemMemory.freephysicalmemory)/1024)/1024),2)

 $MemUsedPercent= [math]::Round(((($TotalMemory_GB-$FreeMemory_GB)/$TotalMemory_GB)*100),2)

 $computerCPU =(Get-WmiObject -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage  -Average | Select-Object Average).Average
 $averageCPU=(Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average).Average


#$Date
#$Time
#$computerCPU
#$averageCPU
#$TotalMemory_GB
#$FreeMemory_GB
#$MemUsedPercent

$endpoint = "https://api.powerbi.com/beta/b8b32acb-f158-413f-90bd-ad4479a28acd/datasets/eb90668d-a549-427e-94c8-1efd4df282ae/rows?key=JX89R4QhC%2BdRPpHJjujfzStbq3IvLpwiYZR1cWRZU96xVvPw1%2BL%2BXEwK5Jx2gHPfWWphH5Ai88pc%2FPkpX29Aig%3D%3D"
$payload = @{
"Date" =$Date
"Time" =$Time
"CPU" =$computerCPU
"AverageCPU" =$averageCPU
"Total_Memory" =$TotalMemory_GB
"Free_Memory" =$FreeMemory_GB
"Memory_usage_percent" =$MemUsedPercent
}
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))

}
