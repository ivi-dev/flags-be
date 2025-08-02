import { readFile } from 'node:fs/promises';

export async function loadConfig(path) {
    return JSON.parse(await readFile(path, { encoding: 'utf8' }));
}