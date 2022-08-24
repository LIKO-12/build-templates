#!/usr/bin/env bash

appimagetool='build/appimagetool.AppImage';

echo '-- Remove unneeded files';
echo '';

cleanup=(
    'share/mime'
    'share/icons'
    'share/applications/love.desktop'
    'share/pixmaps/love.svg'
    'love.desktop'
    'love.svg'
);

for target in ${cleanup[@]}; do
    rm -rv "build/love_linux/${target}";
done

echo '';
echo '-- Add icon files';
echo '';

cp -v 'assets/icon.svg' 'build/love_linux/LIKO-12.svg';
cp -v 'assets/icon.svg' 'build/love_linux/share/pixmaps/LIKO-12.svg';

echo '';
echo '-- Add .desktop files';
echo '';

cp -v 'assets/LIKO-12.desktop' 'build/love_linux/LIKO-12.desktop';
cp -v 'assets/LIKO-12.desktop' 'build/love_linux/share/applications/LIKO-12.desktop';

echo '';
echo '-- Rename love executable';
echo '';

mv 'build/love_linux/bin/love' 'build/love_linux/bin/LIKO-12';

echo '';
echo '-- Pack the AppImage';
echo '';

$appimagetool 'build/love_linux' 'build/love_linux.AppImage';
