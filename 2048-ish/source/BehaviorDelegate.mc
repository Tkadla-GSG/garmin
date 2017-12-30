using Toybox.System as Sys;
using Toybox.Math as Math;
using Toybox.WatchUi as Ui;

class BehaviorDelegate extends Ui.BehaviorDelegate {

	const PI_4 = Math.PI/4;
	const PI_3_4 = Math.PI/2 + PI_4;
	
	var centerX;
	var centerY;
	
	var mController;

    function initialize() {
        BehaviorDelegate.initialize();
        
        mController = Application.getApp();
        
        var device = Sys.getDeviceSettings();
        centerX = device.screenWidth/2;
        centerY = device.screenHeight/2;
    }
    
    function onTap(clickEvent) {
    	if (clickEvent.getType() == Ui.CLICK_TYPE_TAP) {
    		var coords = clickEvent.getCoordinates();
    		var eventAngle = Math.atan2(coords[1] - centerY, coords[0] - centerX);

    		if (eventAngle > -PI_3_4 && eventAngle <= -PI_4) {
    			mController.onUp();
    		} else if (eventAngle > -PI_4 && eventAngle <= PI_4) {
    			mController.onRight();
    		} else if (eventAngle > PI_4 && eventAngle <= PI_3_4) {
    			mController.onDown();
    		} else {
    			mController.onLeft();
    		}
    	}
    }

    function onMenu() {
    	var menu = new Rez.Menus.MainMenu();
    	menu.setTitle(Ui.loadResource(Rez.Strings.AppName));
        Ui.pushView(menu, new MenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
}
