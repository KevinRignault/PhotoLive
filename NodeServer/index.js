//-- Modules
var app = require('express')(),
	http = require('http').Server(app),
	io = require('socket.io')(http),
	fs = require('fs');

//-- Client route
app.get('/', function(req, res){
  res.sendFile(__dirname+'/screen.html');
});

//-- Socket
io.on('connection', function(socket){

	//-- Recevice message
	socket.on('image_to_server', function(base64){
		//-- Send message to client
		io.sockets.emit('display_image_b64', base64);
	});

});

//-- Listen 3000 port
http.listen(3001, function(){
  console.log(':3001');
});