function create()
    a = 0
    colors = {
        {0,0,0,0},	                -- [1]  transparent
        {250,250,250},
        {212,212,212},
        {157,157,157},
        {75,75,75},
        {249,147,138},
        {231,89,82},
        {249,211,129},
        {234,175,77},
        {154,209,249},
        {8,174,238},
        {141,237,167},
        {68,197,91},
        {195,167,225},
        {149,105,200},
        {186,181,170},
        {148,142,130}
    }
    
    litlogo = {
        {1,1,3,3,3,3,3,1,1},
        {1,3,6,6,4,14,14,3,1},
        {3,6,6,3,5,14,14,14,3},
        {3,6,6,3,5,5,14,14,3},
        {3,4,5,3,5,5,5,4,3},
        {3,16,16,3,5,5,10,10,3},
        {3,16,16,3,3,3,10,10,3},
        {1,3,16,16,4,10,10,3,1},
        {1,1,3,3,3,3,3,1,1},
    }
    
    ms = 0
    state = "bootloader"
    --litiumapi.litgraphics.changePallete(colors)
    litiumapi.litgraphics.newSprite(litlogo, 90, 90, 10, "logo")
    litiumapi.litgraphics.newText(tostring(a), 190, 190, 5, 3, 1)
end

function update(elapsed)
    ms = ms + 1 * elapsed
    a = a + 1
    if ms > 4 then
        litiumapi.litentity.killSprite("logo")
    end
end