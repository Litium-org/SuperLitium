--[[

        Font by ChocolateLoxtl
    
    OBS : This script require a special function to work, you can find this function on src/native/engine/textrender
    

        if You want use it on your projects, feel free to use, please just put the credits on the source or project ReadMe.md
        I got a lot of work on this <3
]]--


font = {
    -- Some info stuff ---

    FontName                =             "LunaCode-caps",            --  Font name (optional)
    Version                 =             "0.0.2",                    --  Font version (optional)    
    Author                  =             "ChocolateLoxtl_",          --  Font author (optional)
    FontLetterSize          =             6,                          --  Font character spacing (Required)
    FontLetterHeight        =             7,

    ["a"] = {   -- A --
        {0,0,0,0,0,0},
        {0,0,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["b"] = {   -- B --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["c"] = {   -- C --
        {0,0,0,0,0,0},
        {0,0,1,1,1,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,0,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["d"] = {   -- D --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["e"] = {   -- E --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["f"] = {   -- F --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["g"] = {   -- G --
        {0,0,0,0,0,0},
        {0,0,1,1,1,0},
        {0,1,0,0,0,0},
        {0,1,0,1,1,0},
        {0,1,0,0,1,0},
        {0,0,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["h"] = {   -- H --
        {0,0,0,0,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["i"] = {   -- I --
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["j"] = {   -- J --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["k"] = {   -- K --
        {0,0,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,1,0,0},
        {0,1,1,0,0,0},
        {0,1,1,0,0,0},
        {0,1,0,1,0,0},
        {0,0,0,0,0,0},
    },
    ["l"] = {   -- L --
        {0,0,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["m"] = {   -- M --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {1,1,0,1,1,0},
        {1,0,1,0,1,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["n"] = {   -- N --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {1,1,0,0,1,0},
        {1,0,1,0,1,0},
        {1,0,0,1,1,0},
        {1,0,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["o"] = {   -- O --
        {0,0,0,0,0,0},
        {0,0,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["p"] = {   -- P --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["q"] = {   -- Q --
        {0,0,0,0,0,0},
        {0,0,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,1,1,1,1},
        {0,0,0,0,0,0},
    },
    ["r"] = {   -- R --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,1,1,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["s"] = {   -- S --
        {0,0,0,0,0,0},
        {0,0,1,1,1,0},
        {0,1,0,0,0,0},
        {0,0,1,1,0,0},
        {0,0,0,0,1,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["t"] = {   -- T --
        {0,0,0,0,0,0},
        {0,1,1,1,1,1},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
    },
    ["u"] = {   -- U --
        {0,0,0,0,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,0,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["v"] = {   -- V --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["w"] = {   -- W --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {1,0,0,0,1,0},
        {1,0,1,0,1,0},
        {1,1,0,1,1,0},
        {1,0,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["x"] = {   -- X --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,1,0,0},
        {1,0,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["y"] = {   -- Y --
        {0,0,0,0,0,0},
        {1,0,0,0,1,0},
        {0,1,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,0,0,0},
        {1,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["z"] = {   -- Z --
        {0,0,0,0,0,0},
        {1,1,1,1,1,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,0,0,0},
        {1,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["0"] = {   -- 0 --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,1,0,0},
        {0,1,0,1,0,0},
        {0,1,0,1,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["1"] = {   -- 1 --
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,1,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["2"] = {   -- 2 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,1,1,1,1,0},
        {0,1,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["3"] = {   -- 3 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["4"] = {   -- 4 --
        {0,0,0,0,0,0},
        {0,1,0,0,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,0,0,0,1,0},
        {0,0,0,0,0,0},
    },
    ["5"] = {   -- 5 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,1,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["6"] = {   -- 6 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,1,0,0,0,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["7"] = {   -- 7 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["8"] = {   -- 8 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    ["9"] = {   -- 9 --
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,1,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,1,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
    },
    [" "] = {   -- SPACE --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["!"] = {   -- ! --
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["="] = {   -- = --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["$"] = {   -- $ --
        {0,0,0,1,0,0},
        {0,0,1,1,1,0},
        {0,1,0,1,0,0},
        {0,0,1,1,0,0},
        {0,0,0,1,1,0},
        {0,1,1,1,0,0},
        {0,0,0,1,0,0},
    },
    ["("] = {   -- ( --
        {0,0,0,0,0,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
    },
    [")"] = {   -- ) --
        {0,0,0,0,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,1,0},
        {0,0,0,0,1,0},
        {0,0,0,0,1,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
    },
    [","] = {   -- , --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["."] = {   -- . --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    [":"] = {   -- : --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    [";"] = {   -- ; --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["+"] = {   -- + --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,1,0,0},
        {0,0,1,1,1,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["-"] = {   -- - --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,1,1,1,1,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["_"] = {   -- - --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {1,1,1,1,1,1},
        {0,0,0,0,0,0},
    },
    ["/"] = {   -- / --
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,1,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,0,0,0},
        {0,0,0,0,0,0},
    },
    ["|"] = {   -- | --
        {0,0,0,0,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
    },
    ["<"] = {   -- < --
        {0,0,0,0,0,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,1,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,0,0},
    },
    [">"] = {   -- > --
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,1,0,0},
        {0,0,0,0,1,0},
        {0,0,0,1,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["?"] = {   -- ? --
        {0,0,0,0,0,0},
        {0,0,1,1,0,0},
        {0,0,0,1,1,0},
        {0,0,1,1,0,0},
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
    },
    ["["] = {   -- [ --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,0,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["]"] = {   -- ] --
        {0,0,0,0,0,0},
        {0,1,1,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,0,0,1,0,0},
        {0,1,1,1,0,0},
        {0,0,0,0,0,0},
    },
    ["'"] = {   -- ' --
        {0,0,0,0,0,0},
        {0,0,1,0,0,0},
        {0,0,1,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
        {0,0,0,0,0,0},
    },
}

return font