require "socket"

# open 8081
socket = TCPSocket.open("127.0.0.1", 8081)

# send strings
socket.write("Hello from client")

# close socket
socket.close