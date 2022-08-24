#!/usr/bin/env bash

reshack='build/reshack/ResourceHacker.exe';
logfile='build/reshack/reshack.log';

icopath="assets/icon.ico";

for arch in 'win32' 'win64'; do
    echo '';
    echo "==[[ Patch ${arch} ]]==";
    echo '';

    echo '-- Add license files --';
    echo '';
    cp -v 'assets/LIKO-12-LICENSE.txt' "build/love_${arch}/";
    mv -v "build/love_${arch}/license.txt" "build/love_${arch}/LOVE-LICENSE.txt";

    echo '';
    echo '-- Patch executables --';
    
    for file in 'love' 'lovec'; do
        filepath="build/love_${arch}/${file}.exe";
        respath="build/res/VersionInfo_${file}.res";

        echo '';
        echo "- replace icon for ${file}.exe";
        $reshack -open $filepath -save $filepath -action addoverwrite -res $icopath -mask ICONGROUP,1,1033 -log $logfile;
        iconv -f UTF-16LE -t UTF-8 $logfile;

        echo '';
        echo "- replace version info for ${file}.exe";
        $reshack -open $filepath -save $filepath -action addoverwrite -res $respath -mask VERSIONINFO,1,1033 -log $logfile;
        iconv -f UTF-16LE -t UTF-8 $logfile;
    done

    echo '';
    echo '-- Remove unnecessary files --';
    echo '';

    for file in 'readme.txt' 'changes.txt' 'love.ico' 'game.ico'; do
        rm -v "build/love_${arch}/${file}";
    done
done
