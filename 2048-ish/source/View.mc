using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Engine;
using Util;

class View extends Ui.View {

	var mTileSize;
	var mTileSize_2;
	var mScreenWidthPadding;
	var mScreenHeightPadding;
	var mStartMessage;
	
	// rendering vars
	var val;
	var backgroundColor;
	var left;
	var top;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
               
        var device = Sys.getDeviceSettings();
        var shape = device.screenShape;
        var isRound = shape == Sys.SCREEN_SHAPE_ROUND;
        
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        if (isRound) {
       		mScreenWidthPadding = width/10;
			mScreenHeightPadding = height/10;
        } else {
        	if (width == height) {
        		mScreenWidthPadding = 0;
				mScreenHeightPadding = 0;
        	} else if (width > height) {
        		mScreenWidthPadding = (width - height) / 2;
        		mScreenHeightPadding = 0;
        	} else {
        		mScreenWidthPadding = 0;
        		mScreenHeightPadding = (height - width) / 2;
        	}
        }
        
        mTileSize = (Util.min(width, height) - (2 * Util.min(mScreenWidthPadding, mScreenHeightPadding)))/4;
        mTileSize_2 = mTileSize/2;
        
        mStartMessage = Ui.loadResource(Rez.Strings.Start);
    }
    
    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
       
		for(var i = 0; i < mGame.size(); i++) {
			top = i * mTileSize + mScreenHeightPadding;
			
			for(var j = 0; j < mGame[i].size(); j++) {
				val = mGame[i][j];
				backgroundColor = Engine.getTileColor(val);
				left = j * mTileSize + mScreenWidthPadding;
				
				dc.setColor(backgroundColor, backgroundColor);
				dc.fillRectangle(left, top, mTileSize, mTileSize);
				
				dc.setColor(val == 0 ? Engine.COLOR_EMPTY : Engine.COLOR_TEXT_DARK, backgroundColor);
				dc.drawText(left + mTileSize_2, top + mTileSize_2, dc.FONT_SYSTEM_XTINY, val, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
			}
			
			// draw horizontal lines
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
			dc.drawLine(0, top, dc.getWidth(), top);
		}
		
		//draw vertical lines
		for (var j = 0; j < mGame[0].size(); j++) {
			left = j * mTileSize + mScreenWidthPadding;
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
			dc.drawLine(left, 0, left, dc.getHeight());
		}		
		

		if (mFirstMove) {
			dc.setColor(Engine.COLOR_START, Engine.COLOR_START);
        	dc.fillPolygon([[0,0], [dc.getWidth()/2, dc.getHeight()/2], [dc.getWidth(), 0]]);
        	dc.setColor(Engine.COLOR_TEXT_DARK, Graphics.COLOR_TRANSPARENT);
        	dc.drawText(dc.getWidth()/2, dc.getHeight()/5, dc.FONT_SYSTEM_XTINY, mStartMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
}
