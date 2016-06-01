display.setStatusBar(display.HiddenStatusBar)

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
system.activate( "multitouch" )
-- Variables to Determine Center of Screen
_W = display.contentWidth / 2;
_H = display.contentHeight / 2;
local mydata = require( "mydata" )
local mylevel = require( "mylevel" )
-- background

function restartGame(event)
     if event.phase == "ended" then
		storyboard.gotoScene("start")
     end
end


function dat()

  dat1= transition.to(levelText,{time=200, alpha=1})
  dat2=transition.to(scoreText,{time=200, alpha=1})
end

function showStart()
	startTransition = transition.to(restart,{time=200, alpha=1})
end


function showGameOver()
	fadeTransition = transition.to(gameOver,{time=600, alpha=1,onComplete=showScore})
end

function scene:createScene(event)

	local screenGroup = self.view

	local background = display.newImage ("images/background.png"); -- Place background image	
    background.x = _W;
    background.y = 150;
    background.speed = 1;
    screenGroup:insert(background);
	
	gameOver = display.newImageRect("gameOver.png",500,100)
	gameOver.x = _W
	gameOver.y = _H-100
	gameOver.alpha = 0
	screenGroup:insert(gameOver)


	restart = display.newImageRect("re3.png",200,110)
	restart.x =  _W+20;
	restart.y =_H
	restart.alpha = 0
	screenGroup:insert(restart)


	if mydata.score == nil then
        mydata.score=0
    end
    scoreText = display.newText("Your Score:"..mydata.score,_W+20,
    _H+70, native.systemFont, 36)
    --scoreText:setFillColor(0,0,)
    scoreText.alpha = 0 
    screenGroup:insert(scoreText)

	if mylevel.level == nil then
       mylevel.level=0
    end
    levelText = display.newText("Your Level:"..mylevel.level,_W+20,
    _H+110, native.systemFont, 36)
    --scoreText:setFillColor(0,0,)
     levelText.alpha = 0 
    screenGroup:insert(levelText)
	
end

function scene:enterScene(event)
local screenGroup = self.view
local previous = storyboard.getPrevious()
 
    if previous ~= "main" and previous then
        storyboard.removeScene(previous)
    end

	restart:addEventListener("touch", restartGame)
	showGameOver()
	dat()
	showStart()

end

function scene:exitScene(event)
local screenGroup = self.view
	
	restart:removeEventListener("touch", restartGame)
end

function scene:destroyScene(event)
local screenGroup = self.view
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene

