#!/usr/bin/env bash
[[ -d 'build' ]] || mkdir 'build';

echo '';
echo '--[[ Download Linux Distributions ]]--';
echo '';
curl -o 'build/love.AppImage' -L "https://github.com/love2d/love/releases/download/${LOVE_VERSION}/love-${LOVE_VERSION}-x86_64.AppImage";
chmod +x 'build/love.AppImage';

echo '';
echo '--[[ Extract ]]--';
echo '';

'build/love.AppImage' --appimage-extract;
mv -v squashfs-root build/love_linux;
