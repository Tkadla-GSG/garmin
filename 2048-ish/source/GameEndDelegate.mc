using Toybox.WatchUi as Ui;

class GameEndDelegate extends Ui.BehaviorDelegate {
	
	var mMessage;

    function initialize() {
        BehaviorDelegate.initialize();
               
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
		    var mController = Application.getApp();
		    
		    if (mController != null) {
				mController.onNewGame();
			}
		}

        return true;
    }

}