-- Main API stack
litiumapi = {}

---Litium main graphic control module
litiumapi.litgraphics = require 'src.API.nx_litgraphics'
---Litium System provide basic window control
litiumapi.litsystem = require 'src.API.nx_litsystem'
---Litium game control module
litiumapi.litgame = require 'src.API.nx_litgame'
---Litium input control
litiumapi.litinput = require 'src.API.nx_litinput'
---Litium save module
litiumapi.litsave = require 'src.API.nx_litsave'
---Litium audio module
litiumapi.litaudio = require 'src.API.nx_litaudio'

return litiumapi