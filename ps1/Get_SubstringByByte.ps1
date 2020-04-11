function Get-SubStringBytes($f_text, $f_start, $f_Len) {
    $enc = [System.Text.Encoding]::Default
    $bytes = $enc.GetBytes($f_text)
    return $enc.GetString($bytes, $f_start, $f_Len)
}
 
function main_proc()
{
    if ($script:args.length -ne 1) {
        Write-Host "��P�����ɓ��̓t�@�C�������w�肵�Ă��������B"
        return -1
    }
 
    $input = $script:args[0]
     
    $i = 0
    Get-Content $input | foreach {
        $i++
        Write-Host ([string]$i + "�s��: " + $_)
        Write-Host (" --> 1�`4�o�C�g�𒊏o: " + (Get-SubStringBytes $_ 0 4))
        Write-Host (" --> 3�`8�o�C�g�𒊏o: " + (Get-SubStringBytes $_ 2 6))
    }
     
    return 0
 
}
 
# �����J�n
$ret = main_proc
 
if ($ret -eq 0) {
    exit 0
} else {
    exit 1
}
