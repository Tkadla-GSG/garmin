using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Engine as E;
using Util;
using Toybox.Math as Math;

var mPlayerDelta;
var mPlayerPosMin;
var mPlayerPosMax;
// TODO all of the rest does not need to be in global scope
var mPlayerDirection;
var mMinPlayerPos;
var mMaxPlayerPos;

var mBallPosX;
var mBallPosY;
var mMinBallPosX;
var mMaxBallPosX;
var mMinBallPosY;
var mMaxBallPosY;
var mBallAngle;
var mBallHorizontalDirection;
var mBallVerticalDirection;

var mGameOver = true;

class ArkanoidView extends Ui.View {
	const FRAME_RATE = 1000/16;
	const CENTER = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;
	
	var width;
	var width_2;
	var height;
	var height_2;
	var fieldWidth;
	var playerY;
	var minBallHeight;
	var minBallCollisionHeight;
	var maxBallCollisionHeight;
	
	var lastFrame;
	var thisFrame;
	var dt;
	
	var myTimer;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        
        init(dc);
        
		lastFrame = Sys.getTimer();
        
        myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), FRAME_RATE, true);
    }
    
    function init(dc) {
    	width = dc.getWidth();
        width_2 = width / 2;
        height = dc.getHeight();
        height_2 = height / 2; 
        
        playerY = height_2 + 36;
        
    	$.mPlayerPosMin = width_2 - E.HERO_SIZE_2_NORMAL;
    	$.mPlayerPosMax = width_2 +  E.HERO_SIZE_2_NORMAL;
    	$.mPlayerDirection = E.DIRECTION_NONE;
    	
    	minBallHeight = playerY - E.BALL_RADIUS_NORMAL;
    	$.mBallPosX = width_2;
    	$.mBallPosY = minBallHeight - 1;
    	$.mBallAngle = Util.getRandomAngle();
		$.mBallHorizontalDirection = $.mBallAngle > E.PI_2 ? E.DIRECTION_LEFT : E.DIRECTION_RIGHT;
		$.mBallVerticalDirection = E.DIRECTION_TOP;
    	
        var isRound = Util.isRound();
        var screenPadding = isRound ? width/10 : 0;
        
    	$.mMinPlayerPos = 0 + screenPadding;
		$.mMaxPlayerPos = width - screenPadding;
		$.mMinBallPosX = 0 + E.BALL_RADIUS_NORMAL + screenPadding;
		$.mMaxBallPosX = width - E.BALL_RADIUS_NORMAL - screenPadding;
		$.mMinBallPosY = 0;
		$.mMaxBallPosY = height;
		fieldWidth = $.mMaxBallPosX - $.mMinBallPosX;
		minBallCollisionHeight = minBallHeight;
		maxBallCollisionHeight = minBallHeight + E.HERO_HEIGHT;
    }
    
    function timerCallback() {
	    Ui.requestUpdate();
	}

    // Update the view
    function onUpdate(dc) {
    	thisFrame = Sys.getTimer();
        dt = thisFrame - lastFrame;
        lastFrame = thisFrame;
        
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.clear();
		
		// draw field
		dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_WHITE);
		dc.fillRectangle($.mMinBallPosX, $.mMinBallPosY, fieldWidth, height);
		
		// move ball
		if (!$.mGameOver) {
			$.mBallPosX += Math.cos($.mBallAngle) * E.BALL_SPEED_NORMAL * dt;
			$.mBallPosY -= Math.sin($.mBallAngle) * E.BALL_SPEED_NORMAL * dt;
			
			// game over
			if ($.mBallPosY > height) {
				$.mGameOver = true;
				init(dc);
			}
			
			// bounce ball from celling
			if ($.mBallPosY < $.mMinBallPosY) {
				$.mBallAngle = ($.mBallHorizontalDirection == E.DIRECTION_LEFT ? ($.mBallAngle - E.PI_4) : (-$.mBallAngle));
				$.mBallVerticalDirection = -$.mBallVerticalDirection;
			}
			
			// bounce ball from wall
			if ($.mBallPosX < $.mMinBallPosX || $.mBallPosX > $.mMaxBallPosX) {
				$.mBallAngle = ($.mBallVerticalDirection == E.DIRECTION_TOP ? (E.PI - $.mBallAngle) : (E.PI3 - $.mBallAngle));
				$.mBallHorizontalDirection = -$.mBallHorizontalDirection;
			}
		}
		
		// draw ball
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
		dc.fillCircle($.mBallPosX, $.mBallPosY, E.BALL_RADIUS_NORMAL);

		// move player
		if (!$.mGameOver) {		
			mPlayerDelta = $.mPlayerDirection * dt * E.HERO_SPEED_NORMAL;
			$.mPlayerPosMin += mPlayerDelta;
			$.mPlayerPosMax += mPlayerDelta;
			
			// limit player
			if ($.mPlayerPosMin < $.mMinPlayerPos) {
				$.mPlayerPosMin = $.mMinPlayerPos;
				$.mPlayerPosMax = $.mPlayerPosMin + E.HERO_SIZE_NORMAL;
			}
			
			if ($.mPlayerPosMax > $.mMaxPlayerPos) {
				$.mPlayerPosMax = $.mMaxPlayerPos;
				$.mPlayerPosMin = $.mPlayerPosMax - E.HERO_SIZE_NORMAL;
			}
			
			// bounce ball from player
			// TODO skew exit angle based on direction
			if ($.mBallPosY >= minBallCollisionHeight && $.mBallPosY <= maxBallCollisionHeight && $.mBallPosX > $.mPlayerPosMin && $.mBallPosX < $.mPlayerPosMax) {
				$.mBallAngle += E.PI;
				$.mBallHorizontalDirection = -$.mBallHorizontalDirection;
			}
			
		}
		
		// draw player
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
		dc.fillRoundedRectangle($.mPlayerPosMin, playerY, E.HERO_SIZE_NORMAL, E.HERO_HEIGHT, E.HERO_HEIGHT_2);
		
		// draw TODO draw score
		
		// draw frame length
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width_2, height - 40, Graphics.FONT_SYSTEM_NUMBER_MILD, Sys.getTimer() - thisFrame, CENTER);
    }
}
