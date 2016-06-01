display.setStatusBar(display.HiddenStatusBar);

local physics = require "physics"
physics.start()
physics.setGravity(0,0);

system.activate( "multitouch" )

local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local widget = require( "widget" )
local shot = audio.loadSound ("laserbeam.mp3")
local ex = audio.loadStream("explosion-02.mp3")
-- groups
local enemies = display.newGroup()
local Coins = display.newGroup()
local mydata = require( "mydata" )
local mylevel= require( "mylevel" )
-- Variables to Determine Center of Screen
_W = display.contentWidth / 2;
_H = display.contentHeight / 2;




function scene:createScene(event)
  


	local screenGroup = self.view	
	
    mylevel.level=1
    mylevel.showlevel=display.newText( "Level"..mylevel.level,10,10,"helvetica",26) 


	point=0
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

	-- Place ship image
	ship = display.newImage ("images/spaceship.png");
	ship.x = _W-200;
	ship.y = _H;
	ship.myName="ship"
	physics.addBody(ship, "dynamic",{ friction = 0, bounce = 0});
	screenGroup:insert(ship);

--create enemey
numEnemy=0
enemyArray={}
enemyCounter=1
sendEnemyFrequency = 25000
tmrToSend=0
count=0
    numEnemy = numEnemy +1 

	print(numEnemy)
			enemies:toFront()
			enemyArray[numEnemy]  = display.newImageRect("img/v2.png",45,45)
			physics.bodyType="static"
			physics.addBody ( enemyArray[numEnemy] , "static")
			enemyArray[numEnemy] .myName = "enemy" 
			startlocationX = display.contentWidth
			enemyArray[numEnemy] .x = startlocationX
			startlocationY = math.random (90,_H+20)
			enemyArray[numEnemy] .y = startlocationY
		
			transition.to ( enemyArray[numEnemy] , { time = math.random (5000, 8000), x=-100 } )
			enemies:insert(enemyArray[numEnemy] )

--create coin
numCoin=0
CoinArray={}
CoinCounter=1
sendCoinFrequency = 25000
tmrToSend=0

	-- create shootbutton

	shootbtn = display.newImageRect("shootbutton.png",50,50)
	shootbtn.x = display.contentWidth-20
	shootbtn.y = display.contentHeight-60
	screenGroup:insert(shootbtn); 

p_options = 
	{
		-- Required params
		width = 24,
		height = 23,
		numFrames = 8,
		-- content scaling
		--sheetContentWidth = 160,
		--sheetContentHeight = 42,
	}

	explosionSheet = graphics.newImageSheet( "img/explosion.png", p_options )
	explosion = display.newSprite( explosionSheet, { name="explosions", start=1, count=8, time=1000 } )
	explosion.anchorX = 0.5
	explosion.anchorY = 0.5
	explosion.x = display.contentCenterX
	explosion.y = display.contentCenterY
	--explosion:prepare("explosions") 
	--player:play()
   explosion.isVisible= false
	screenGroup:insert(explosion)


--score
        
	mydata.score = 0 -- start the player score at 0
    -- an object to hold the score text object
		mydata.scoreText = display.newText("Score: "..mydata.score, 0, 0, "helvetica", 26) -- Create a text object that will display the player score
        mydata.scoreText.x =450
        mydata.scoreText.y = 10
        --screenGroup:insert(mydata.score)
        screenGroup:insert(mydata.scoreText)	


-- Set up speed
 shipMoveX = 0;
 shipMoveY = 0;
 speed = 5;
-- Place arrows on screen
upArrow = display.newImage ("images/upArrow.png");
upArrow.x = 70;
upArrow.y = 230;


downArrow = display.newImage ("images/downArrow.png");
downArrow.x = 70;
downArrow.y = 290;

leftArrow = display.newImage ("images/leftArrow.png");
leftArrow.x = 30;
leftArrow.y = 260;

rightArrow = display.newImage ("images/rightArrow.png");
rightArrow.x = 110;
rightArrow.y = 260;

function upArrow:touch()
	shipMoveX = 0;
	shipMoveY = -speed;
end

function downArrow:touch()
	shipMoveX = 0;
	shipMoveY = speed;
end

function leftArrow:touch()
	shipMoveX = -speed;
	shipMoveY = 0;
end

function rightArrow:touch()
	shipMoveX = speed;
	shipMoveY = 0;
end


function createEnemy()
  if(point~=1)then
	numEnemy = numEnemy +1 
    --checkbullet()
	print(numEnemy)
			enemies:toFront()
			enemyArray[numEnemy]  = display.newImageRect("img/v"..math.random(1,3)..".png",45,45)
			physics.bodyType="static"
			physics.addBody ( enemyArray[numEnemy] , "static")
			enemyArray[numEnemy] .myName = "enemy" 
			startlocationX = display.contentWidth
			enemyArray[numEnemy] .x = startlocationX
			startlocationY =  math.random (50,_H+80)
			enemyArray[numEnemy] .y = startlocationY
             if(mydata.score<20) then
			transition.to ( enemyArray[numEnemy] , { time = math.random (7000, 8000), x=-100 } )
			end
			if(mydata.score>=20) then
          	transition.to ( enemyArray[numEnemy] , { time = math.random (6000, 7000), x=-100 } )	
    		end
    		if(mydata.score>=40) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (5000, 6000), x=-100 } )	
    		end
    		if(mydata.score>=60) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (5000, 5500), x=-100 } )
    		end
    		if(mydata.score>=200) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (4500, 5000), x=-100 } )
    		end
    		if(mydata.score>=250) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (4000, 4500), x=-100 } )
    		end
    		if(mydata.score>=300) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (3500, 4000), x=-100 } )
    		end
    		if(mydata.score>=350) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (3000, 3500), x=-100 } )
    		end
    		if(mydata.score>=400) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (2500, 3000), x=-100 } )
    		end
    		if(mydata.score>=450) then
    		transition.to ( enemyArray[numEnemy] , { time = math.random (2000, 2500), x=-100 } )
    		end
    		enemies:insert(enemyArray[numEnemy] )
	end	
end

function createmore()
        if (point~=1)then		
			enemyCounter = enemyCounter + 1 -- increase enemy counter by one for tracking
    		if(enemyCounter<15) then 
    		sendEnemyFrequency =math.random(4000,6000) --the frequency by 5000ms
    		tmrToSend = timer.performWithDelay(sendEnemyFrequency,createEnemy,0) 
         	 end
        end
			
end



function removeEnemies()
	for i =1, #enemyArray do
		if (enemyArray[i].myName ~= nil) then
		enemyArray[i]:removeSelf()
		enemyArray[i].myName = nil
		end
	end
end

function createCoin()
	if (point~=1) then
	 numCoin = numCoin +1 

	    print(numCoin)
			Coins:toFront()
			CoinArray[numCoin]  = display.newImageRect("images/coin.png",30,30)
			CoinArray[numCoin] .myName = "Coin" 
			physics.bodyType="static"
			physics.addBody ( CoinArray[numCoin] , "static")
			startlocationX = display.contentWidth
			CoinArray[numCoin] .x = startlocationX
			startlocationY =  math.random (50,_H+80)
			CoinArray[numCoin] .y = startlocationY
		    if(mydata.score<20) then
			transition.to ( CoinArray[numCoin] , { time = math.random (7000, 8000), x=-100 } )
			end
			if(mydata.score>=20) then
          	transition.to ( CoinArray[numCoin] , { time = math.random (6000, 7000), x=-100 } )	
    		end
    		if(mydata.score>=40) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (5000, 6000), x=-100 } )	
    		end
    		if(mydata.score>=60) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (5000, 5500), x=-100 } )
    		end
    		if(mydata.score>=100) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (4500, 5000), x=-100 } )
    		end
    		if(mydata.score>=120) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (4000, 4500), x=-100 } )
    		end
    		if(mydata.score>=140) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (3500, 4000), x=-100 } )
    		end
    		if(mydata.score>=160) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (3000, 3500), x=-100 } )
    		end
    		if(mydata.score>=180) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (2500, 3000), x=-100 } )
    		end
    		if(mydata.score>=200) then
    		transition.to ( CoinArray[numCoin] , { time = math.random (2000, 2500), x=-100 } )
    		end
		    Coins:insert(CoinArray[numCoin])
    end
end

function createCoinmore()
	if(point~=1) then
	    CoinCounter = CoinCounter + 1 -- increase Coin counter by one for tracking
    	if(CoinCounter<15) then 
    		sendCoinFrequency =math.random(7000,8000) --the frequency by 5000ms
    		tmrToSend = timer.performWithDelay(sendCoinFrequency,createCoin,0) 
        end
    end 
end

function removecoins()
	for i =1, #CoinArray do
		if (CoinArray[i].myName ~= nil) then
			print( "inside removecoin" )
		CoinArray[i]:removeSelf()
		CoinArray[i].myName = nil
		end
	end
end


end



function upScore()
    mydata.scoreText.text = "Score: "..mydata.score -- update the on screen text
    if(mydata.score>=20) then
       mylevel.level=2
       mylevel.showlevel.text="Level"..mylevel.level
    end
    if(mydata.score>=40) then
    	mylevel.level=3
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=60) then
    	mylevel.level=4
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=200) then
    	mylevel.level=5
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=250) then
    	mylevel.level=6
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=300) then
    	mylevel.level=7
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=350) then
    	mylevel.level=8
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=400) then
    	mylevel.level=9
       mylevel.showlevel.text="Level"..mylevel.level

    end
    if(mydata.score>=450) then
    	mylevel.level=10
       mylevel.showlevel.text="Level"..mylevel.level

    end
end



function explode()
    audio.play(ex)
	explosion.x = ship.x
	explosion.y = ship.y
	explosion.isVisible = true
	explosion:play()
	ship.isVisible = false
	timer.performWithDelay(3000, gameOver, 1)

end


function shoot(event)
     bullet = display.newImageRect("img/bullet.png",10,10)
       if(mydata.score>=10 and mydata.score<20) then
       	bullet = display.newImageRect("img/Missile_Weapon.png",20,20)
       end
       if(mydata.score>=20) then
       	bullet = display.newImageRect("img/Mis.png",30,30)
       end
			physics.addBody(bullet, "dyanmic", {density = 1, friction = 0, bounce = 0});
			bullet.x = ship.x+50
			bullet.y = ship.y 
			bullet.myName = "bullet"
			transition.to ( bullet, { time = 1000, x=1000, y =ship.y} )
			audio.play(shot)
end




local function onCollision( event )
 if (event.object1.myName=="ship" and event.object2.myName =="Coin") then
        print( "Coin");
        event.object2.isVisible=false
        event.object2:removeSelf()
		event.object2.myName=nil
        mydata.score = mydata.score + 1 -- add mydata.score by 1
        upScore()
  end
   if((event.object1.myName=="Coin" and event.object2.myName=="bullet") or 
		(event.object1.myName=="bullet" and event.object2.myName=="Coin")) then
			event.object1:removeSelf()
			event.object1.myName=nil
			event.object2:removeSelf()			
			event.object2.myName=nil
			count=count+1
			if(count>=3) then
				mydata.score=mydata.score-3
				if(mydata.score<0) then 
				removeEnemies()
	            removecoins()
	            explode()  
	            point=1	
	            Runtime:removeEventListener("enterFrame", fakeWalls);
	            Runtime:removeEventListener("enterFrame", moveShip);
                Runtime:removeEventListener("enterFrame", stopShip);
			    storyboard.gotoScene("restart", "fade",1000)
			    end
				upScore()
				count=0
			end
	end


	if((event.object1.myName=="enemy" and event.object2.myName=="bullet") or 
		(event.object1.myName=="bullet" and event.object2.myName=="enemy")) then
			event.object1:removeSelf()
			event.object1.myName=nil
			event.object2:removeSelf()			
			event.object2.myName=nil
			mydata.score = mydata.score + 5
			upScore()
			end
	
  if  (event.object1.myName=="ship" and event.object2.myName =="enemy") then
           ship.collided = true
	       ship.bodyType = "static"
	       explode()  
	       point=1
	       removeEnemies()
	       removecoins()
	       Runtime:removeEventListener("enterFrame", fakeWalls);
	       Runtime:removeEventListener("enterFrame", moveShip);
           Runtime:removeEventListener("enterFrame", stopShip);
	       storyboard.gotoScene("restart", "fade",1000)
  end
end



function scrollbg( self,event )
	if (self.x < -240 ) then
		self.x=240+480
	else 
		self.x=self.x-self.speed
	end
end

function stopShip (event)
if event.phase =="ended" then
	shipMoveX = 0;
	shipMoveY = 0;
	end
end


-- Move the spaceship
function moveShip (event)
	ship.x = ship.x + shipMoveX;
	ship.y = ship.y + shipMoveY;
end



-- Keep spaceship boxed in by fake walls
 function fakeWalls (event)

	if ship.x < 50 then
		ship.x = 50
	end

	if ship.x > 430 then
		ship.x = 430
	end

	if ship.y > 270 then
		ship.y = 270
	end

	if ship.y < 50 then
		ship.y = 50
	end

	if speed < 0 then
		speed = 0
	end
end





function scene:enterScene(event)
    local screenGroup = self.view

    local previous = storyboard.getPrevious()
 
    if previous ~= "main" and previous then
        storyboard.removeScene(previous)
    end
	
	Runtime:addEventListener( "collision", onCollision )

	background.enterFrame=scrollbg;
	Runtime:addEventListener("enterFrame", background);

	background1.enterFrame=scrollbg;
	Runtime:addEventListener("enterFrame", background1);
	
	createCoinmore()
    
    createmore()

	shootbtn:addEventListener( "touch",shoot )

	Runtime:addEventListener("enterFrame", fakeWalls);
    
	-- When no arrow is touched, stop movement
	Runtime:addEventListener("touch", stopShip);
	upArrow:addEventListener("touch", up);
	downArrow:addEventListener("touch", down);
	leftArrow:addEventListener("touch",left);
	rightArrow:addEventListener("touch",right);
  
	-- Start movement
	Runtime:addEventListener("enterFrame", moveShip);

end


function scene:exitScene(event)
    local screenGroup = self.view
	Runtime:removeEventListener("enterFrame", background)
	Runtime:removeEventListener("enterFrame", background1)
	Runtime:removeEventListener("collision", onCollision)	
	upArrow:removeSelf( )
	downArrow:removeSelf( )
	leftArrow:removeSelf( )
	rightArrow:removeSelf( )
	removeEnemies()
	removecoins()
	--Coins:removeSelf( )
	--enemies:removeSelf( )

	screenGroup:removeSelf( )
	mylevel.showlevel:removeSelf( )
end

function scene:destroyScene()
           local screenGroup = self.view
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene