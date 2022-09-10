litnetwork = {}

https = require 'https'
network = require 'src.core.virtualization.drivers.nx_network-dvr'

function litnetwork.request(url)
    code, body = https.request(url)
    if not body then
        return "Status code" .. code
    else
        return body
    end
end

function litnetwork.downloadRequest(url, filename)
    network.downloadFile(url, file) -- need fix later 
end

return litnetwork