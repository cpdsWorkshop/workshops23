function love.load()
    --Escreve o cÃ³digo para carregar a imagem na linha baixo
    imagem = love.graphics.newImage("missil1.png")

end


function love.draw()
    love.graphics.print("Abel", 200, 200);
    --Escreve o cÃ³digo para desenhar a imagem na linha baixo
    love.graphics.draw(imagem, 100, 100, 0, 1, 1)
end

function love.update(dt)

end