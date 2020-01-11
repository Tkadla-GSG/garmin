using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Engine as E;

class BehaviorDelegate extends Ui.BehaviorDelegate {
	var mController;
	
	var centerX;

    function initialize() {
        BehaviorDelegate.initialize();
        
        mController = Application.getApp();
        
        var device = Sys.getDeviceSettings();
        centerX = device.screenWidth/2;
    }
    
    /*function onSelect() {
    	Sys.println("SELECT");
		$.mGameOver = false;
    }*/
    
    function onHold(clickEvent) {
    	var coords = clickEvent.getCoordinates();
    	var deltaX = coords[0] - centerX;
    	
    	if (deltaX < 0) {
    		$.mPlayerDirection = E.DIRECTION_LEFT;
    	} else {
    		$.mPlayerDirection = E.DIRECTION_RIGHT;
    	}
    }
    
    function onTap(clickEvent) {
    	Sys.println("TAP");
    	Sys.println(clickEvent.getType());
    	$.mGameOver = false;
    }
    
    function onRelease(clickEvent) {
    	$.mPlayerDirection = E.DIRECTION_NONE;
    }
}
