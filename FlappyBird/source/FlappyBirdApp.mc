using Toybox.Application as App;
using Util;

var mPlayerSpeed = 0;
var mBest = 0;

class FlappyBirdApp extends App.AppBase {

	const BEST_SCORE_SCORE = "best";

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    	var best = Util.getProperty(BEST_SCORE_SCORE);
    	$.mBest = best == null ? 0 : best; 
    }

    function onStop(state) {
    	Util.setProperty(BEST_SCORE_SCORE, $.mBest);
    }

    function getInitialView() {
        return [ new FlappyBirdView(), new BehaviorDelegate() ];
    }

}