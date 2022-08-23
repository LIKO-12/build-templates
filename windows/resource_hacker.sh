[[ -d 'build' ]] || mkdir 'build';

echo '';
echo '--[[ Downloading resource_hacker.zip ]]--';
echo '';
curl -o 'build/resource_hacker.zip' 'http://angusj.com/resourcehacker/resource_hacker.zip';

echo '';
echo '--[[ Extracing resource_hacker.zip ]]--';
echo '';
unzip 'build/resource_hacker.zip' -d 'build/reshack';

echo '';
echo '--[[ Cleaning up ]]--';
echo '';
rm -v 'build/resource_hacker.zip';
