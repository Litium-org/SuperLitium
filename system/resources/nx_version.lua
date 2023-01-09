version = {}

local stringx = require 'pl.stringx'
version.isConnectedToNetwork = nil

function version.compare()
    -- do network request and get version from server --
    local serverVersion, cd = network.newRequest("https://raw.githubusercontent.com/Litium-org/SuperLitium/master-new/.litversion")
        -- get native version file
    local NativeVersion = love.filesystem.read(".litversion")

    if cd == 0 then
        version.isConnectedToNetwork = false
    else
        version.isConnectedToNetwork = true
    end
            
    if version.isConnectedToNetwork then
        print("---------------------------------")
        print("Currently running Litium")
        print("Most recent version : " .. serverVersion)
        print("Current version : " .. NativeVersion)
        print("---------------------------------")


        -- split tokens --
        local nv = stringx.split(NativeVersion, ".")
        local sv = stringx.split(serverVersion, ".")

        local nv_MAJOR = tonumber(nv[1])    
        local nv_MINOR = tonumber(nv[2])
        local nv_PATCH = tonumber(nv[3])
        ---------------------------------
        local sv_MAJOR = tonumber(sv[1])
        local sv_MINOR = tonumber(sv[2])
        local sv_PATCH = tonumber(sv[3])

        --- lower
        if sv_MAJOR ~= nv_MAJOR 
        or sv_MINOR ~= nv_MINOR 
        or sv_PATCH ~= nv_PATCH 
        then
            return true
        else
            return false
        end

        --- greater
        --[[
        if sv_MAJOR < nv_MAJOR 
        or sv_MINOR < nv_MINOR 
        or sv_PATCH < nv_PATCH 
        then
            return false
        end]]--
    else
        print("---------------------------------")
        print("Litium.Error - Can't fetch server version data")
        print("NO_INTERNET_CONNECTION_STABLISHED | FAILED_TO_REQUEST")
        print("---------------------------------")
    end
end

return version