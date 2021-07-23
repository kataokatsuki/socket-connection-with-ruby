require 'openssl'

key = OpenSSL::PKey::RSA.new(2048)

# output private key
File.open(__dir__ + "/keys/private_key.pem", "w+") do |f|
  f.write(key.export)
end

# output public key
public_key = key.public_key
File.open(__dir__ + "/keys/public_key.pem", "w+") do |f|
  f.write(public_key.export)
end