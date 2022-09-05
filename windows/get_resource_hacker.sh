#!/usr/bin/env bash
[[ -d 'build' ]] || mkdir 'build';
set -e;

echo '';
echo '--[[ Download resource_hacker.zip ]]--';
echo '';
curl -o 'build/resource_hacker.zip' 'http://angusj.com/resourcehacker/resource_hacker.zip';

echo '';
echo '--[[ Extract resource_hacker.zip ]]--';
echo '';
unzip 'build/resource_hacker.zip' -d 'build/reshack';

echo '';
echo '--[[ Clean up ]]--';
echo '';
rm -v 'build/resource_hacker.zip';
