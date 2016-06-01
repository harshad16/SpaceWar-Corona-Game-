-- requires 
display.setStatusBar( display.HiddenStatusBar )

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
system.activate( "multitouch" )
local physics = require "physics"
physics.start()
-------------------------------------------------------------------------------------

local backgroundsnd = audio.loadStream ( "m1.mp3")

-- Variables to Determine Center of Screen
_W = display.contentWidth / 2;
_H = display.contentHeight / 2;

-- play background music
function backgroundMusic()
	back=audio.play (backgroundsnd, { loops = -1})
	audio.setVolume(0.8, {backgroundsnd} ) 	
end

local function muteMusic(event)
	if ( "began" == event.phase ) then
	if(mute1.alpha<=0.5) then
	    audio.rewind( backgroundsnd )
     	audio.play(backgroundsnd, { loops = -1})
     	print("inside 1")
      	mute1.alpha=1
	else
		audio.stop()
		mute1.alpha=0.5
		print("inside 0.5"..mute1.alpha)
    end     
end
end


function startGame(event)
     if event.phase == "ended" then
		storyboard.gotoScene("game", {effect = "fade", time = 800})
     end
end

function titleTransitionDown()
	downTransition = transition.to(titleGroup,{time=400, y=titleGroup.y+20,onComplete=titleTransitionUp})
	
end

function titleTransitionUp()
	upTransition = transition.to(titleGroup,{time=400, y=titleGroup.y-20, onComplete=titleTransitionDown})
	
end

function titleAnimation()
	titleTransitionDown()
end


function goto1(event)
     if event.phase == "ended" then
        storyboard.gotoScene("menupage", {effect = "fade", time = 800})
     end
end


function startGame2(event)
     if event.phase == "ended" then
        storyboard.gotoScene("HighScore", {effect = "fade", time = 800})
     end
end

-------------------------------------------------------------------------------------

function scene:createScene(event)

	local screenGroup = self.view
    
	background = display.newImage ("images/background.png"); -- Place background image	
    background.x = _W;
    background.y = 150;
    background.speed = 1;
    screenGroup:insert(background);

	background1 = display.newImage ("images/background.png");	
	background1.x = _W+480;
	background1.y = 150;
	background1.speed = 1;
	screenGroup:insert(background1);

    mute1 = display.newImageRect("mute1.png",45,45);	
	mute1.x = display.contentWidth;
	mute1.y =_H-120;
	screenGroup:insert(mute1);

    title =display.newImage("t1.png")
    title.x=_W
    title.y=_H-100
    screenGroup:insert(title)

	-- Place ship image
	ship = display.newImage ("images/spaceship.png");
	ship.x = _W-250;
	ship.y = _H+50;
	physics.setGravity(0,0);
	ship.myName="ship"
	physics.addBody(ship, "static");
	screenGroup:insert(ship);

	start = display.newImageRect("s1.png",200,65)
	start.x = _W+10;
	start.y = _H+70
	screenGroup:insert(start)

	go=display.newImage("bac.png")
    go.x=10
    go.y=display.contentHeight-10
    screenGroup:insert(go)

	
	titleGroup = display.newGroup()
	titleGroup.x = _W
	titleGroup.y = _H- 250
	titleGroup:insert(ship)
	screenGroup:insert(titleGroup)
	titleAnimation()

	t4 =display.newImageRect("s2.png",200,65)
    t4.x=_W
    t4.y=_H+120
    screenGroup:insert(t4)
    --transition.to( t4, { time=1500, x=_W, onComplete=listener } )

end


function scene:enterScene(event)
	

	local previous = storyboard.getPrevious()
 
    if previous ~= "main" and previous then
        storyboard.removeScene(previous)
    end

	local screenGroup = self.view
	backgroundMusic()
	mute1:addEventListener( "touch", muteMusic)
	start:addEventListener("touch", startGame)
    go:addEventListener( "touch", goto1 )
    t4:addEventListener("touch", startGame2)

end

function scene:exitScene(event)
	local screenGroup = self.view
    mute1:removeEventListener( "touch", muteMusic)
	start:removeEventListener("touch", startGame)
	transition.cancel(downTransition)
	transition.cancel(upTransition)
    go:removeEventListener( "touch", goto1 )
    t4:removeEventListener("touch", startGame2)
	
end

function scene:destroyScene(event)
   local screenGroup = self.view
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene