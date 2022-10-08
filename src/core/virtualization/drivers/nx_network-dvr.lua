network = {}

utils = require 'src.engine.resources.nx_utils'

function network.downloadFile(url, filename)
    -- retrieve the content of a URL
    local code, body = https.request(url, "GET")
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

function network.newRequest(url)
    code, content = https.request(url, "GET")
    return content, code
end


return network