import { buildWindows } from "./windows.js";

async function main() {
    await buildWindows();
}

main().catch(console.error);
