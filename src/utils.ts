import got from "got";
import cliProgress from "cli-progress";

import * as fs from 'fs';
import * as path from 'path';

export function humanDataSize(size: number): string {
    if (size == 0) return '0';
    const i = Math.floor(Math.log(size) / Math.log(1024));
    return `${(size / Math.pow(1024, i)).toFixed(2)} ${['B', 'kB', 'MB', 'GB', 'TB'][i]}`;
};

export async function download(url: string, file: string) {
    const request = got(url);
    const filename = path.basename(file);

    const directory = path.dirname(file);
    if (!fs.existsSync(directory)) await fs.promises.mkdir(directory);

    const progressBar = new cliProgress.SingleBar({
        format: `${filename} [{bar}] {percentage}% | ETA: {eta}s | {size}`,
        clearOnComplete: true,
        autopadding: true,
        etaBuffer: 100,
    });

    progressBar.start(1, 0, {
        size: 'Starting...',
    });

    request.on('downloadProgress', ({ percent, total, transferred }) => {
        const humanTransferred = humanDataSize(transferred);
        progressBar.update(percent, {
            size: total ? `${humanTransferred}/${humanDataSize(total)}` : humanTransferred
        });
    });

    await fs.promises.writeFile(file, await request.buffer());

    progressBar.stop();
}

export async function fetchIfNotExists(file: string, url: string) {
    const filename = path.basename(file);

    if (fs.existsSync(file)) {
        console.log(`• Using previously downloaded ${filename}`);
        return;
    };

    await download(url, file);

    console.log(`• Downloaded ${filename}`);
}