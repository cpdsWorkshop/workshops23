function love.load()
    --Escreve o cÃ³digo para carregar a imagem na linha baixo
    imagem = love.graphics.newImage("nave1.png")
    posicaoX = 0
  posicaoY = 0
end


function love.draw()
    --Escreve o cÃ³digo para desenhar a imagem na linha baixo
    love.graphics.draw(imagem, posicaoX, posicaoY, 0, 1, 1)
end

function love.update(dt)
    if posicaoX < (love.graphics.getWidth() - imagem:getWidth()) then
        if love.keyboard.isDown("right") then
            posicaoX = posicaoX + 15
        end
    end
    if posicaoX > 0 then
        if love.keyboard.isDown("left") then
            posicaoX = posicaoX - 15
        end
    end
    if posicaoY <(love.graphics.getHeight() - imagem:getHeight()) then
        if love.keyboard.isDown("down") then
            posicaoY = posicaoY + 15
        end
    end
    if posicaoY > 0 then
        if love.keyboard.isDown("up") then
            posicaoY = posicaoY - 15
        end
    end
end