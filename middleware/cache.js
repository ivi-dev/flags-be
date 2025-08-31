export default function cache(opts) {
  return (req, res, next) => {
    if (typeof opts.maxAge === 'string') {
      const [amount, unit] = opts.maxAge.split(' '),
            secs = convert(parseInt(amount, 10), unit, 'second');
      res.set('Cache-Control', `max-age=${secs}`);
    } else {
      opts.maxAge.forEach(it => {
        if (it.cond(req)) {
          const [amount, unit] = it.maxAge.split(' '),
                secs = convert(parseInt(amount, 10), unit, 'second');
          res.set('Cache-Control', `max-age=${secs}`);
        }
      });
    }
    next();
  }
}

function convert(fromValue, fromUnit, toUnit) {
  const units = {
    second: 1,
    minute: 60,
    hour: 3600,
    day: 86400,
    week: 604800,
    month: 2592000,
    year: 31536000,
  };
  return (fromValue * units[fromUnit]) / units[toUnit];
}