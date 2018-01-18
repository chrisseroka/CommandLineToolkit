param(
   $phrase
)

if ($phrase -ne $null)
{
   Import-Module ps-menu
   
   $favourites = @("C:\", "C:\my\Tools", "C:\Projects")
   $dirs = @($favourites | foreach { gci $_ } | where {$_.PSIsContainer} | foreach {$_.FullName})
   $found = @($dirs | where { $_.ToLower().Contains($phrase.ToLower())})

   if ($found.Length -gt 1)
   {
      $selected = menu $found
   }
   else 
   {
      $selected = $found[0]	
   }

   if ($selected -ne $null)
   {
      [System.IO.File]::WriteAllLines("$PSScriptRoot\cdf_tmp.bat", "cd $selected")
   }
   else
   {
      [System.IO.File]::WriteAllLines("$PSScriptRoot\cdf_tmp.bat", "cd .")
   }
}
else 
{
   write-host "You must specify search phrase"
	[System.IO.File]::WriteAllLines("$PSScriptRoot\cdf_tmp.bat", "cd .")
}
