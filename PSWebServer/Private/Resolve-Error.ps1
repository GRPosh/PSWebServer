function Resolve-Error
{
   param(
    $ErrorRecord=$Error[0]
   )

   $ErrorRecord | Format-List * -Force | Out-String
   $ErrorRecord.InvocationInfo | Format-List * | Out-String
   $Exception = $ErrorRecord.Exception
   for ($i = 0; $Exception; $i++, ($Exception = $Exception.InnerException))
   {   "$i" * 80
       $Exception |Format-List * -Force | Out-String
   }
}
