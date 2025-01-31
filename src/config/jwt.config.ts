export default () => ({
  jwt: {
    secret: process.env.JWT_ACCESS_SECRET || 'default_secret',
    expiresIn: process.env.JWT_ACCESS_EXPIRE || '1h',
  },
});
