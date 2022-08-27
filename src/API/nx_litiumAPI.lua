-- Main API stack
litiumapi = {}

---Litium main graphic control module
litiumapi.litgraphics = require 'src.API.nx_litgraphics'
---Litium Debug
litiumapi.litdebug = require 'src.API.nx_litdebug'
---Litium System
litiumapi.litsystem = require 'src.API.nx_litsystem'
---Litium entity control module
litiumapi.litentity = require 'src.API.nx_entity'
--Litium game control module
litiumapi.litgame = require 'src.API.nx_litgame'

return litiumapi