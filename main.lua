-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )


local storyboard = require ("storyboard")
storyboard.purgeOnSceneChange=true
storyboard.gotoScene( "start" ,{effect ="fade",time = 1500})
