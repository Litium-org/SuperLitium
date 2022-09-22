-- Main API stack
litiumapi = {}

---Litium main graphic control module
litiumapi.litgraphics = require 'src.API.nx_litgraphics'
---Litium Debug
    --litiumapi.litdebug = require 'src.API.nx_litdebug'
---Litium System
litiumapi.litsystem = require 'src.API.nx_litsystem'
---Litium entity control module
    --litiumapi.litentity = require 'src.API.nx_litentity'
--Litium game control module
litiumapi.litgame = require 'src.API.nx_litgame'
---Litium network module
litiumapi.litnetwork = require 'src.API.nx_litnetwork'
---Litium input control
litiumapi.litinput = require 'src.API.nx_litinput'
---Litium save module
litiumapi.litsave = require 'src.API.nx_litsave'

return litiumapi