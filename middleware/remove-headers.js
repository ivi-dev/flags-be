export default function removeHeaders(opts) {
  return (req, res, next) => {
    opts.headers.forEach(header => res.removeHeader(header));
    next();
  }
}