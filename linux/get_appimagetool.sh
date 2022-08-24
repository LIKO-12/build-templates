#!/usr/bin/env bash
[[ -d 'build' ]] || mkdir 'build';

appimagetool='build/appimagetool.AppImage';

echo '';
echo '--[[ Download appimagetool.AppImage ]]--';
echo '';
curl -o $appimagetool -L 'https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage';

echo '';
echo '--[[ Fix permissions ]]--';
echo '';
chmod +x $appimagetool;

echo '';
echo '--[[ Test AppImageTool ]]--';
echo '';
$appimagetool --version;
