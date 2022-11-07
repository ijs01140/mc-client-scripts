#!/bin/bash

# 処理対象のフォルダ
MinecraftDir="/home/$SUDO_USER/.minecraft"
newProfileDir="/home/$SUDO_USER/.minecraft/profile_dir/$1"

mkdir -p $newProfileDir 
# $MinecraftDir内のファイル・フォルダのリストを取得する。
while read -r item; do
        ln -sf $item "$newProfileDir/$(basename ${item})"
done < <(find $MinecraftDir -mindepth 1 -maxdepth 1)

unlinkDirList=(
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
for unlinkDir in "${unlinkDirList[@]}"; do
    unlink "$newProfileDir/${unlinkDir}"
done
