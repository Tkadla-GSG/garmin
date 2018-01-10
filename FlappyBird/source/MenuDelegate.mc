using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
		return true;
    }
}
