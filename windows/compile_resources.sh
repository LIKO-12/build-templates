#!/usr/bin/env bash
[[ -d 'build' ]] || mkdir 'build';
[[ -d 'build/res' ]] || mkdir 'build/res';
set -e;

reshack='build/reshack/ResourceHacker.exe';
logfile='build/reshack/reshack.log';

for file in windows/resources/*.rc; do
    filename=$(basename $file .rc);

    echo '';
    echo "========== Compile $filename ==========";

    source="windows/resources/${filename}.rc";
    destination="build/res/${filename}.res";

    $reshack -open $source -save $destination -action compile -log $logfile;
    iconv -f UTF-16LE -t UTF-8 $logfile;
done