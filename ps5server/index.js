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
var screenDimension = robot.getScreenSize();

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

  client.on("joyStickData", async (joyStickData) => {
    var mouseMap = getMousePosition();
    // console.log(mouseMap);
    // console.log(screenDimension.height, screenDimension.width);

    // console.log(joyStickData);
  });

  client.on("sendGyroData", async (data) => {
    console.log(data["y"]);
    socketIO.emit("getMessages", "New message Received");
  });
  client.on("sendButtonData", async (data) => {
    console.log(data);
    robot.keyTap(data);
    socketIO.emit("getMessages", "New message Received");
  });
  client.on("spacebuttonEvent", async (_) => {
    robot.keyTap("space");
    console.log("space");
  });
});

var port = process.env.PORT || 3000;
httpServer.listen(port, function (err) {
  if (err) console.log(err);
  console.log("Listening on port", port);
});

var lerp = (current, target, factor) => {
  let holder = current * (1 - factor) + target * factor;
  holder = parseFloat(holder).toFixed(3);
  return holder;
};

function getMousePosition() {
  var mouse = robot.getMousePos();
  return {
    x: mouse.x,
    y: mouse.y,
  };
}
