require "socket"

# open 8081
server = TCPServer.open(8081)

# connect to client
socket = server.accept

# show strings send by client
while line = socket.gets
  puts line
end

# close socket
socket.close

# close server
server.close