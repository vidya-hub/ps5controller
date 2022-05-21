const express = require("express");
const app = express();
const httpServer = require("http").Server(app);
const socketIO = require("socket.io")(httpServer);
const bodyParser = require("body-parser");
var robot = require("robotjs");
var linear = require("everpolate").linear;
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
    var mousePosition = getInterPolateValues(joyStickData);
    console.log(mousePosition);
    robot.moveMouse(mousePosition.x, mousePosition.y);
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

var getInterPolateValues = function (joyStickData) {
  var x_interp = linear(
    joyStickData["x"],
    [-150, 150],
    [0, screenDimension.width]
  );
  var y_interp = linear(
    joyStickData["y"],
    [100, -100],
    [0, screenDimension.height]
  );
  return {
    x: x_interp,
    y: y_interp,
  };
};

function getMousePosition() {
  var mouse = robot.getMousePos();
  return {
    x: mouse.x,
    y: mouse.y,
  };
}
