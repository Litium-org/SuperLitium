network = {}

utils = require 'src.engine.resources.nx_utils'

function network.downloadFile(url, filename)
    -- retrieve the content of a URL
    reqData = {
        url = url,
        method = "GET"
    }
    local code, body = https.request(reqData)
    --print(body)
    if not body then 
        print(code)
        love.event.quit()
    end

    -- save the content to a file
    print(utils.saveDirectory() .. "/" .. filename)
    file = io.open(utils.saveDirectory() .. "/" .. filename, "wb")
    file:write(body)
    file:close()
end


return network