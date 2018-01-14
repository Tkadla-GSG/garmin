using Toybox.WatchUi as Ui;
using Toybox.System;

class ConfirmationDelegate extends Ui.ConfirmationDelegate {

	var mController;

    function initialize() {
        ConfirmationDelegate.initialize();
        mController = Application.getApp();
    }

    function onResponse(response) {
        if (response == Ui.CONFIRM_NO) {
            mController.onNewGame();
        } else {
        	$.mPlayForever = true;
        }
        
        return true;
    }
}