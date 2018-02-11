using Toybox.WatchUi as Ui;
using Toybox.System;

class ConfirmationDelegate extends Ui.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == Ui.CONFIRM_NO) {
            var mController = Application.getApp();
            
            if (mController != null) {
            	mController.onNewGame();
            }
        } else {
        	$.mPlayForever = true;
        }
        
        return true;
    }
}