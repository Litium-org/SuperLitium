vramPallete = {}

vramPallete.pallete = {
    {0,0,0,0},	                -- [1]  transparent
    {0,0,0},	                -- [2]  
    {255,255,255},	            -- [3]  
    {192,192,192},	            -- [4]  
    {128,128,128},	            -- [5]  
    {255,0,0},	                -- [6]  
    {128,0,0},	                -- [7]  
    {255,0,255},	            -- [8]  
    {128,0,128},	            -- [9]  
    {0,0,255},	                -- [10]  
    {0,0,128},	                -- [11]  
    {0,255,255},	            -- [12]  
    {0,128,128},	            -- [13]  
    {0,255,0},	                -- [14]  
    {0,128,0},	                -- [15]  
    {255,255,0},	            -- [16]  
    {128,128,0}	                -- [17]  
}

function vramPallete.changePallete(plttTable)
    if #plttTable > 17 then
        return "the color pallete can't be higher than 17 colors"
    else
        vramPallete.pallete = plttTable
    end
end

return vramPallete