const express = require('express');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

let connectedClient = null;

wss.on('connection', (ws) => {
  console.log('Client connected');

  if (connectedClient) {
    ws.close(1000, 'Only one connection allowed');
    return;
  }

  ws.on('message', (message) => {
    const receivedMessage = message.toString();

    console.log('Received message from client:', receivedMessage);

    if (receivedMessage === '123456789') {
      connectedClient = ws;
      ws.send('Authenticated');
    } else {
      ws.close(1000, 'Closing');
    }
  });

  ws.on('close', () => {
    connectedClient = null;
  });
});

app.get('/api', async (req, res) => {
  if (!connectedClient) {
    res.status(500).send('No client connected');
    return;
  }

  try {
    connectedClient.send('energy');

    const responsePromise = new Promise((resolve, reject) => {
      connectedClient.once('message', (message) => {
        resolve(message.toString());
      });
    });

    const response = await responsePromise;

    res.send('Response from client: ' + response);
  } catch (error) {
    res.status(500).send('Error communicating with client');
  }
});

server.listen(5000, () => {
  console.log('Server running on port 5000');
});
