import cors from 'cors';
import express from 'express';
import cache from './middleware/cache.js';
import removeHeaders from './middleware/remove-headers.js';
import { getCountries } from './services/countries.js';

const app = express();
const port = 3000;

app.use(cors());

app.use(removeHeaders({ headers: ['X-Powered-By'] }));
 
function boolean(val) {
  if (val?.toLowerCase() === 'true') return true;
  if (val?.toLowerCase() === 'false') return false;
  return undefined;
}

app.get(
  '/countries/all', 
  cache({ 
    maxAge: [ 
      {
        cond: req => !boolean(req.query.shuffle), 
        maxAge: '1 month' 
      },
      {
        cond: req => boolean(req.query.shuffle) ?? true, 
        maxAge: '0 second' 
      },
    ] 
  }), 
  async (req, res) => {
    res.json(await getCountries(boolean(req.query.shuffle) ?? true));
  }
);

app.listen(port, () => {
  console.log(`Flags backend listening on port ${port}`);
});
