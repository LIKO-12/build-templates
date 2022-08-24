#!/usr/bin/env bash
[[ -d 'build' ]] || mkdir 'build';

echo '';
echo '--[[ Download Windows Distributions ]]--';
echo '';

for arch in 'win32' 'win64'; do
    echo "Download love-${LOVE_VERSION}-${arch}.zip";
    echo "";
    
    curl -o "build/love_${arch}.zip" -L "https://github.com/love2d/love/releases/download/${LOVE_VERSION}/love-${LOVE_VERSION}-${arch}.zip" --fail-with-body;
done

echo '';
echo '--[[ Extract ]]--';
echo '';

for arch in 'win32' 'win64'; do
    unzip -j "build/love_${arch}.zip" -d "build/love_${arch}";
done
