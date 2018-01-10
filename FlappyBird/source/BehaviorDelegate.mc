using Toybox.WatchUi as Ui;
using Engine;

class BehaviorDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onKeyPressed(keyEvent) {
    	switch(keyEvent.getKey()) {
    		case Ui.KEY_LAP:
    		case Ui.KEY_ENTER:
    			jump();
    	}
    }
    
    function onTap(clickEvent) {
    	if (clickEvent.getType() == Ui.CLICK_TYPE_TAP) {
	   		jump();
    	}
    }
    
    function jump() {
    	$.mPlayerSpeed -= Engine.PLAYER_JUMP_SPEED * 60;
    }

    function onMenu() {
    	var menu = new Menu();
    	menu.setTitle(Ui.loadResource(Rez.Strings.AppName));
    	menu.addItem(Ui.loadResource(Rez.Strings.Best) + $.mBest, :Item1);
        Ui.pushView(menu, new MenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
}
