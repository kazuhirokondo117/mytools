function Get-SubStringBytes($f_text, $f_start, $f_Len) {
    $enc = [System.Text.Encoding]::Default
    $bytes = $enc.GetBytes($f_text)
    return $enc.GetString($bytes, $f_start, $f_Len)
}
 
function main_proc()
{
    if ($script:args.length -ne 1) {
        Write-Host "第１引数に入力ファイル名を指定してください。"
        return -1
    }
 
    $input = $script:args[0]
     
    $i = 0
    Get-Content $input | foreach {
        $i++
        Write-Host ([string]$i + "行目: " + $_)
        Write-Host (" --> 1～4バイトを抽出: " + (Get-SubStringBytes $_ 0 4))
        Write-Host (" --> 3～8バイトを抽出: " + (Get-SubStringBytes $_ 2 6))
    }
     
    return 0
 
}
 
# 処理開始
$ret = main_proc
 
if ($ret -eq 0) {
    exit 0
} else {
    exit 1
}
