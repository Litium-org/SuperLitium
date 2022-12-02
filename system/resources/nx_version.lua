version = {}

stringx = require 'pl.stringx'
local isConnectedToNetwork

function version.compare()
    -- do network request and get version from server --
    serverVersion, cd = network.newRequest("https://raw.githubusercontent.com/Litium-org/SuperLitium/master/.litversion")
        -- get native version file
    nativeFile = io.open(".litversion", "r")
    NativeVersion = nativeFile:read("*all")

    if cd == 0 then
        isConnectedToNetwork = false
    else
        isConnectedToNetwork = true
    end
            
    if isConnectedToNetwork then
        print("---------------------------------")
        print("Currently running Litium")
        print("Most recent version : " .. serverVersion)
        print("Current version : " .. NativeVersion)
        print("---------------------------------")


        -- split tokens --
        nv = stringx.split(NativeVersion, ".")
        sv = stringx.split(serverVersion, ".")

        nv_MAJOR = tonumber(nv[1])    
        nv_MINOR = tonumber(nv[2])
        nv_PATCH = tonumber(nv[3])
        ---------------------------------
        sv_MAJOR = tonumber(sv[1])
        sv_MINOR = tonumber(sv[2])
        sv_PATCH = tonumber(sv[3])

        --- lower
        if sv_MAJOR < nv_MAJOR 
        or sv_MINOR < nv_MINOR 
        or sv_PATCH < nv_PATCH 
        then
            return true
        else
            return false
        end

        --- greater
        -- disabled XD --
        --[[
        if sv_MAJOR > nv_MAJOR 
        or sv_MINOR > nv_MINOR 
        or sv_PATCH > nv_PATCH 
        then
            return true
        else
            return false
        end
        ]]--
    else
        print("---------------------------------")
        print("Litium.Error - Can't fetch server version data")
        print("NO_INTERNET_CONNECTION_STABLISHED | FAILED_TO_REQUEST")
        print("---------------------------------")
    end
end

return version