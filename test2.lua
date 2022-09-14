binser = require 'libraries.binser'

input = io.read("*l")

ser = binser.serialize(input)
print(ser)