import { MongoClient } from 'mongodb';
import { loadConfig } from './config.js';

const config = (await loadConfig('./config.json'))['db'];

const conn = `mongodb://` +
             `${config['username']}:` +
             `${config['password']}@` +
             `${config['host']}:` +
             `${config['port']}/?` +
             `authSource=${config['authSource']}&` +
             `tls=true&` +
             `tlsCAFile=/etc/ssl/certs/flags/root.crt`;

const client = new MongoClient(conn);

function shuffleArray(array) {
    for (let i = array.length - 1; i >= 1; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

export async function getCountries(shuffle = true) {
  const db = client.db('flags');
  const countries = db.collection('countries');
  let countries_ = await countries.find().toArray();
  if (shuffle) countries_ = shuffleArray(countries_);
  return countries_;
}