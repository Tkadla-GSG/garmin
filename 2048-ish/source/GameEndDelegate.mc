using Toybox.WatchUi as Ui;

class GameEndDelegate extends Ui.BehaviorDelegate
{
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;
    }

}