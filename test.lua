function create()
    litiumapi.litgraphics.newText("boot from test cart", 90, 90, 5, 3, 1)

    heart = {
        {1,6,1,6,1},
        {6,6,6,6,6},
        {6,6,6,6,6},
        {1,6,6,6,1},
        {1,1,6,1,1},
    }

    x = 100

    litiumapi.litgraphics.newSprite(heart, x, 230, 9, "hrt")
end

function update(elapsed)
    x = x + 16 * elapsed
    litiumapi.litentity.transform("hrt", x, 230, 9)
end