const express = require("express");
const app = express();
const httpServer = require("http").Server(app);
const socketIO = require("socket.io")(httpServer);
const bodyParser = require("body-parser");
var robot = require("robotjs");
app.use(bodyParser.json());
app.get("/", (req, res) => {
  console.log("Hereee");
});

socketIO.on("connection", async (client) => {
  console.log("Connected...", client.id);

  /* 
  Disconnect
  */

  client.on("forceDisconnect", () => {
    console.log("Disconnected   ", client.id);
    client.disconnect(true);
  });

  /* 
  Starting Chat
  */

  client.on("sendGyroData", async (data) => {
    console.log(data["y"]);
    socketIO.emit("getMessages", "New message Received");
  });
  client.on("sendButtonData", async (data) => {
    socketIO.emit("getMessages", "New message Received");
  });
});

var port = process.env.PORT || 3000;
httpServer.listen(port, function (err) {
  if (err) console.log(err);
  console.log("Listening on port", port);
});

/*

1. one socket continously listening to the CLIENT

// create 

2 . based on the client event it has to turn on left and right moves



















*/
