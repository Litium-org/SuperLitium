debugcomponent = {}

vrampallete = require 'src.core.virtualization.nx_vramPallete'
render = require 'src.core.render.nx_render'

isActive = false

function debugcomponent.showTableContent(tbl, indent)
    if not indent then 
        indent = 0 
    end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 1 
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  "= "   
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. debugcomponent.showTableContent(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    return toprint
end

function debugcomponent.showCurrentColorPallete()
    x = 0
    for c = 1, #vrampallete.pallete, 1 do
        render.rectangle("fill", x, 0, 10, 10, c)
        x = x + 10
    end
end

function debugcomponent.list()
    data = nxhardapi.vram.ListTags("spr")
    for d = 1, #data, 1 do
        print(data[d])
    end
end

return debugcomponent