import { MongoClient } from 'mongodb';
import { loadConfig } from './config.js';

const config = (await loadConfig('./config.json'))['db'];

const conn = `mongodb://` +
             `${config['username']}:` +
             `${config['password']}@` +
             `${config['host']}:` +
             `${config['port']}`;

const client = new MongoClient(conn);

export async function getCountries() {
  const db = client.db('flags');
  const countries = db.collection('countries');
  return await countries.find().toArray();
}