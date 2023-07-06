function love.load()
    imagem = love.graphics.newImage("nave3.png");
--fregegrg
    posicaoX = 300;
    posicaoY = 300;

    velocidade = 5;

    missilImagem = love.graphics.newImage("missil2.png");
    misseis = {};

    missilVelocidade = 250;
    podeDisparar = true;

    missilTempoMax = 0.2;
    missilTempo = missilTempoMax;

    ImagemInimigo = love.graphics.newImage("inimigo2.png");
    inimigos = {};
    geraInimigoTempo = 0;
    geraInimigoTempoMax = 1;

    ImagemInimigo1 = love.graphics.newImage("inimigo3.png");
    inimigos1 = {};
    geraInimigoTempo1 = 0;
    geraInimigoTempoMax1 = 1;

end


function love.draw()
    love.graphics.draw(imagem, posicaoX, posicaoY, 0, 1, 1);

    for index, missil in ipairs(misseis) do
        love.graphics.draw(missil.imagem, missil.posicaoX, missil.posicaoY)
    end

    for index, inimigo in ipairs(inimigos) do
        love.graphics.draw(inimigo.img, inimigo.posicaoX, inimigo.posicaoY)
    end

end

function love.update(dt)
    if love.keyboard.isDown("right") then
        if posicaoX < (love.graphics.getWidth() - imagem:getWidth()) then 
            posicaoX = posicaoX + velocidade
        end
    end

    if love.keyboard.isDown("left") then
        if posicaoX > 0 then 
            posicaoX = posicaoX - velocidade
        end
    end

    if love.keyboard.isDown("down") then
        if posicaoY < (love.graphics.getHeight() - imagem:getHeight()) then
        posicaoY = posicaoY + velocidade
        end
    end

    if love.keyboard.isDown("up") then
        if posicaoY > 0 then 
            posicaoY = posicaoY - velocidade
        end
    end

    if love.keyboard.isDown("space") then
        if(left) then
          missilVelocidade = missilVelocidade - velocidade/2
        elseif(right) then
          missilVelocidade = missilVelocidade + velocidade/2
        end
        if podeDisparar then
            podeDisparar = false
            missilTempo = missilTempoMax
            missil = {
                posicaoX = posicaoX + 64,
                posicaoY = posicaoY + 32,
                width = 16, height=16,
                velocidade = missilVelocidade,
                imagem = missilImagem}
            table.insert(misseis, missil)
        end
    end
    if missilTempo > 0 then
        missilTempo = missilTempo - dt
      else
        podeDisparar = true
    end
    atualizarMisseis(dt)
    atualizarInimigos(dt)
    verificaJogadorInimigoColisao()
    verificaMissilInimigoColisao()
end

function atualizarMisseis(dt)
    for i=table.getn(misseis), 1, -1 do
      missil = misseis[i]
      missil.posicaoX = missil.posicaoX + dt * missil.velocidade
    end
end

function atualizarInimigos(dt)
    geraInimigoTempo = geraInimigoTempo - dt
    if geraInimigoTempo <= 0 then
        geraInimigoTempo = geraInimigoTempoMax
        y = love.math.random(0, love.graphics.getHeight() - 64)
        inimigo = {posicaoX = love.graphics.getWidth(), posicaoY = y, width = 64, height = 64, velocidade = 100, img = ImagemInimigo}
        table.insert(inimigos, inimigo)
    end
    for i = #inimigos, 1, -1 do
        inimigo = inimigos[i]
        inimigo.posicaoX = inimigo.posicaoX - inimigo.velocidade * dt
    end
end

function verificaJogadorInpimigoColisao()
    for index, inimigo in ipairs(inimigos) do
        if intercepta(posicaoX, posicaoY, 47, 50, inimigo.posicaoX, inimigo.posicaoY, inimigo.width, inimigo.height) then
            posicaoX = 0
            posicaoY = 0
            misseis = {}
            inimigos = {}
            podeDisparar = true
            missilTempo = missilTempoMax
            geraInimigoTempo = 0
        end
    end
end

function intercepta(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
    x1 + w1 > x2 and
    y1 < y2 + h2 and
    y1 + h1 > y2
end

function verificaMissilInimigoColisao()
    for index, inimigo in ipairs(inimigos) do
        for index2, missil in ipairs(misseis) do
            if intercepta(missil.posicaoX, missil.posicaoY, missil.width, missil.height, inimigo.posicaoX, inimigo.posicaoY, inimigo.width, inimigo.height) then
                table.remove(inimigos, index)
                table.remove(misseis, index2)
                break
            end
        end
    end
end
