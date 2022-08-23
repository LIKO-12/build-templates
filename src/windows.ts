import { fetchIfNotExists } from './utils.js';

let loveVersion = '11.4';

async function fetchDependencies() {
    await fetchIfNotExists('tools/7zr.exe', 'https://www.7-zip.org/a/7zr.exe');
    await fetchIfNotExists('tools/resource_hacker.zip', 'http://angusj.com/resourcehacker/resource_hacker.zip');
    
    await fetchIfNotExists(`tools/love-${loveVersion}-win32.zip`, `https://github.com/love2d/love/releases/download/${loveVersion}/love-${loveVersion}-win32.zip`);
    await fetchIfNotExists(`tools/love-${loveVersion}-win64.zip`, `https://github.com/love2d/love/releases/download/${loveVersion}/love-${loveVersion}-win64.zip`);
}

export async function buildWindows() {
    console.log('Fetching dependencies...');
    await fetchDependencies();

    console.log('Extracting...');

    console.log('Patching executables...');
}