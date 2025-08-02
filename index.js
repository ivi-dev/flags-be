import express from 'express';
import { getCountries } from './services/countries.js';
const app = express();
const port = 3000;

app.get('/countries/all', async (req, res) => {
  res.json(await getCountries());
})

app.listen(port, () => {
  console.log(`Flags backend listening on port ${port}`);
})
