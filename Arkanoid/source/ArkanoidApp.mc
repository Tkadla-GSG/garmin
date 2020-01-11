using Toybox.Application as App;
using Engine as E;

class ArkanoidApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [ new ArkanoidView(), new BehaviorDelegate() ];
    }
}