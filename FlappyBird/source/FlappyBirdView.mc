using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Attention;
using Engine;

class FlappyBirdView extends Ui.View {

	var myTimer;
    var lastFrame;
    var thisFrame;
    var width;
    var width_2;
    var width_max;
    var height;
    var height_2;
       
    const PI_2 = Math.PI/2;
    const FRAME_RATE_16 = 1000/16;
    
    var pipes;
    
    var groundHeight;
    var pipeX;
    var pipeXMax;
    var pipeVariant;
    var pipeVariantMax;
	var dt;
	var playerY;
	var playerX;
	var playerXMax;
	var playerXMin;
	var playerSprite;
	var cloudX = 0;
	
	var speedMultiplier = 1;
	var hit = false;
	var scoreCounted = false;
	var score = 0;
	
	var vibeProfile;
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        
        width = dc.getWidth();
        width_2 = width / 2;
        width_max = width * 2;
        height = dc.getHeight();
        height_2 = height / 2;    
        groundHeight = height - height/3;
        
        playerY = height_2;        
        playerSprite = Ui.loadResource(Rez.Drawables.Bird);
        playerX = width < 210 ? Engine.PLAYER_X_NARROW : Engine.PLAYER_X_NORMAL;
        playerXMax = playerX + Engine.PLAYER_SPRITE_X_2;
        playerXMin = playerX - Engine.PLAYER_SPRITE_X_2;
        
        pipes = height < 240 ? Engine.PIPES_NARROW : Engine.PIPES_NORMAL;
        
        newPipe();
        
        if (Attention has :vibrate) {
        	vibeProfile = [new Attention.VibeProfile(100, 50)];
        }
              
        lastFrame = Sys.getTimer();
        
        myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), FRAME_RATE_16, true);
    }
    
    function timerCallback() {
	    Ui.requestUpdate();
	}
	
	function newPipe(){
		scoreCounted = false;
        hit = false;
		pipeX = 2 * width;
		pipeXMax = pipeX + Engine.PIPE_WIDTH;
        pipeVariant = Engine.getPipeVariant(pipes);
        pipeVariantMax = pipeVariant + Engine.PIPE_HOLE;
	}
    
    function onUpdate(dc) {
    	thisFrame = Sys.getTimer();
        dt = thisFrame - lastFrame;
        lastFrame = thisFrame;

        // sky
        dc.setColor(Engine.COLOR_CLOUD, Engine.COLOR_SKY);
        dc.clear();
        cloudX += Engine.CLOUD_SPEED * dt * speedMultiplier;
        if (cloudX > Engine.CLOUD_SIZE) {
        	cloudX = 0;
        }
        dc.fillCircle(-cloudX, groundHeight, Engine.CLOUD_SIZE_2);
        dc.fillCircle(Engine.CLOUD_SIZE - cloudX, groundHeight, Engine.CLOUD_SIZE_2);
        dc.fillCircle(Engine.CLOUD_2_SIZE - cloudX, groundHeight, Engine.CLOUD_SIZE_2);
        dc.fillCircle(Engine.CLOUD_3_SIZE - cloudX, groundHeight, Engine.CLOUD_SIZE_2);
        dc.fillCircle(Engine.CLOUD_4_SIZE - cloudX, groundHeight, Engine.CLOUD_SIZE_2);
        
        // ground
        dc.setColor(Engine.COLOR_GROUND, Engine.COLOR_SKY);
        dc.fillRectangle(0, groundHeight, width, height - groundHeight);
        dc.setColor(Engine.COLOR_GRASS, Engine.COLOR_SKY);
        dc.setPenWidth(Engine.GROUND_THICKNESS);
        dc.drawLine(0, groundHeight + Engine.GROUND_THICKNESS_2, width, groundHeight + Engine.GROUND_THICKNESS_2);
        
        // move pipe
        pipeX -= Engine.PIPE_SPEED * dt * speedMultiplier;
        pipeXMax = pipeX + Engine.PIPE_WIDTH;
        if (pipeXMax < 0) {
        	newPipe();
        }
        
        // draw pipe
        dc.setColor(Engine.COLOR_PIPE, Engine.COLOR_SKY);
		dc.fillRectangle(pipeX, 0, Engine.PIPE_WIDTH, pipeVariant);
		dc.fillRectangle(pipeX, pipeVariantMax, Engine.PIPE_WIDTH, groundHeight - pipeVariantMax);
		dc.setColor(Engine.COLOR_PIPE_HIGHLIGHT, Engine.COLOR_SKY);
		dc.fillRectangle(pipeX + 5, 0, Engine.PIPE_HIGHLIGHT_WIDTH, pipeVariant);
		dc.fillRectangle(pipeX + 5, pipeVariantMax, Engine.PIPE_HIGHLIGHT_WIDTH, groundHeight - pipeVariantMax);
		
		// move player
		$.mPlayerSpeed += Engine.GRAVITY * dt;
		playerY += $.mPlayerSpeed * dt;
		if (playerY + Engine.PLAYER_SPRITE_Y_2 > groundHeight) {
			$.mPlayerSpeed -= Engine.PLAYER_JUMP_SPEED / 2 *dt;
		} else if (playerY < 0) {
			$.mPlayerSpeed = Engine.GRAVITY * dt;
			playerY = 0;
		}
		
		// collision detection
		if (!hit && pipeX < playerX && pipeXMax > playerX) {
			if ((playerY - Engine.PLAYER_SPRITE_Y_2) < pipeVariant || (playerY + Engine.PLAYER_SPRITE_Y_2) > pipeVariantMax) {
				score = 0;
				hit = true;
				speedMultiplier = 1;
				if (Attention has :vibrate) {
				    Attention.vibrate(vibeProfile);
				}
			}
		}
		
		if (!scoreCounted && !hit && pipeXMax <= playerXMax) {
			score += 1;
			scoreCounted = true;
			if (score % 5 == 0) {
				speedMultiplier *= Engine.SPEED_MULTIPLIER;
			}
			if (score > $.mBest) {
				$.mBest = score;
			}
		}
		
		// draw player
		dc.drawBitmap(playerXMin, playerY - Engine.PLAYER_SPRITE_Y_2, playerSprite);

        // draw score count
        dc.setColor(hit ? Graphics.COLOR_RED : Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width_2, 20, Graphics.FONT_SYSTEM_NUMBER_MILD, score, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // draw frame length
        // dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        // dc.drawText(width_2, height - 40, Graphics.FONT_SYSTEM_NUMBER_MILD, Sys.getTimer() - thisFrame, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
