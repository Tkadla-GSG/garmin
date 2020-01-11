using Toybox.Application;
using Toybox.System as Sys;
using Toybox.Math as Math;
using Engine as E;

module Util {	
	function getRandom(min, max) {
		return Math.floor(Math.rand() % (max - min + 1)) + min;
	}
	
	function getRandomAngle() {
		return getRandom(45, 135) * Math.PI / 180;
	}
	
	function isRound() {
		var device = Sys.getDeviceSettings();
        return device.screenShape == Sys.SCREEN_SHAPE_ROUND;
	}
}