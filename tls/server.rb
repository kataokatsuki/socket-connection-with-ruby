require "socket"
require 'openssl'

# read key
key = OpenSSL::PKey::RSA.new(File.open(__dir__ + "/keys/private_key.pem"))

# create stuff used for TLS
digest = OpenSSL::Digest::SHA1.new()
issuer = subject = OpenSSL::X509::Name.new()

# subject example
subject.add_entry('C', 'JP')
subject.add_entry('ST', 'Tokyo')
subject.add_entry('CN', 'kataokatsuki')

# sign 
certification = OpenSSL::X509::Certificate.new()
certification.not_before = Time.at(0)
certification.not_after = Time.at(0)
certification.public_key = key 
certification.serial = 1
certification.issuer = issuer
certification.subject = subject
certification.sign(key, digest)

# specify a cipher which use RSA for Kx(Key Exchange) and Au(Authentication)
# you may not decrypt in Wireshark easily if you use ECDHE for Kx
ssl_context = OpenSSL::SSL::SSLContext.new()
ssl_context.cert = certification
ssl_context.key = key
ssl_context.ssl_version = :TLSv1_2
ssl_context.ciphers = ["AES256-GCM-SHA384"]

# open 4433
tcp_server = TCPServer.new('127.0.0.1', 4433)
ssl_server = OpenSSL::SSL::SSLServer.new(tcp_server, ssl_context)

# show strings send by client
socket = ssl_server.accept
text = socket.gets
puts text

# send strings
socket.puts("Server receives a message: " + text)

# close socket
socket.close

# close server
ssl_server.close