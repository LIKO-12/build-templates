#!/usr/bin/env bash

echo '';
echo '--[[ Download Windows Binaries ]]--';
echo '';

for arch in 'win32' 'win64'; do
    echo "Download love-${LOVE_VERSION}-${arch}.zip";
    echo "";
    
    curl -o "build/love_${arch}.zip" "https://github.com/love2d/love/releases/download/${LOVE_VERSION}/love-${LOVE_VERSION}-${arch}.zip";
done

echo '';
echo '--[[ Extract and Cleanup ]]--';
echo '';

for arch in 'win32' 'win64'; do
    unzip "build/love_${arch}.zip" -d "build/love_${arch}";
    rm -v "build/love_${arch}.zip";
done
