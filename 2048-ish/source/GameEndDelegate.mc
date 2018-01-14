using Toybox.WatchUi as Ui;

class GameEndDelegate extends Ui.BehaviorDelegate {
	
	var mMessage;
	var mController;

    function initialize() {
        BehaviorDelegate.initialize();
        
        mController = Application.getApp();
        
        mMessage = Ui.loadResource(Rez.Strings.Continue);
    }

    function onBack() {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    
	    if ($.mWon) {
	        var dialog = new Ui.Confirmation(mMessage);
			Ui.pushView(
			    dialog,
			    new ConfirmationDelegate(),
			    Ui.SLIDE_IMMEDIATE
			);
		} else {
			mController.onNewGame();
		}

        return true;
    }

}