require 'socket'
require 'openssl'

# open 4433
tcp_socket = TCPSocket.new('127.0.0.1', 4433)
ssl_socket = OpenSSL::SSL::SSLSocket.new(tcp_socket)
ssl_socket.connect

# send strings
ssl_socket.puts("Hello from client")

# show strings send by server
puts ssl_socket.gets

# close socket
ssl_socket.close