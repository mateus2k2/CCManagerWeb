// server.js

const app = require('./app');
const routes = require('./routes');

app.use(routes);

const PORT = 5015;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
