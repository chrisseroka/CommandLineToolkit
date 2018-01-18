param(
   $phrase
)

if ($phrase -ne $null)
{
   Import-Module ps-menu

   $dirs = @(Get-ChildItem C:\ | ?{ $_.PSIsContainer } | %{$_.FullName})
   $dirs += @(Get-ChildItem C:\my\Tools | ?{ $_.PSIsContainer } | %{$_.FullName}) 
   $dirs += @(Get-ChildItem C:\Projects | ?{ $_.PSIsContainer } | %{$_.FullName}) 

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
