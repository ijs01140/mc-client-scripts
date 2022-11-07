Param(
    [parameter(mandatory=$true)]$Arg1
)

# 処理対象のフォルダ
$MinecraftDir = "$env:APPDATA\.minecraft";
$newProfileDir = "$env:APPDATA\.minecraft\profile_dir\$Arg1";

New-Item $newProfileDir -ItemType Directory
# $MinecraftDir内のファイル・フォルダのリストを取得する。
$itemList = Get-ChildItem $MinecraftDir;
foreach($item in $itemList)
{
#    if(-not(($item.Name -cmatch 'configs') -or ($item.Name -cmatch 'defaultconfigs') -or ($item.Name -cmatch 'logs') -or ($item.Name -cmatch 'mods'))){
        New-Item -Path $newProfileDir -Name $item.Name -Value "$MinecraftDir\$($item.Name)" -ItemType SymbolicLink
#    }
} 
$unlinkDirList = @(
    'config'
    'defaultconfigs'
    'logs'
    'mods'
    'profile_dir'
    'profilekeys'
    'versions'
    "launcher_*"
    'realms_persistence.json'
    'treatment_tags.json'
    'updateLog.txt'
)
foreach($unlinkDir in $unlinkDirList)
{
    Remove-Item -Path "$newProfileDir\$unlinkDir"
} 
