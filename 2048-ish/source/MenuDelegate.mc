using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MenuDelegate extends Ui.MenuInputDelegate {

	var mController;

    function initialize() {
        MenuInputDelegate.initialize();
        mController = Application.getApp();
    }

    function onMenuItem(item) {
        if (item == :Item1) {
            mController.onNewGame();
        }
    }
}
