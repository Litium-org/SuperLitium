vramPallete = {}

vramPallete.pallete = {
    {0,0,0,0},	-- transparent
    {0,0,0},
    {255,255,255},
    {192,192,192},
    {128,128,128},
    {255,0,0},
    {128,0,0},
    {255,0,255},
    {128,0,128},
    {0,0,255},
    {0,0,128},
    {0,255,255},
    {0,128,128},
    {0,255,0},
    {0,128,0},
    {255,255,0},
    {128,128,0}
}

function vramPallete.changePallete(plttTable)
    if #plttTable > 17 then
        return "the color pallete can't be higher than 17 colors"
    else
        vramPallete.pallete = plttTable
    end
end

return vramPallete