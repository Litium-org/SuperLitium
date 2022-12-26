litnetwork = {}

local network = require 'src.core.virtualization.drivers.nx_network-dvr'

function litnetwork.request(url)
    local code, body = https.request(url)
    if not body then
        return "Status code" .. code
    else
        return body
    end
end

return litnetwork