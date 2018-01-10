using Toybox.Application;
using Toybox.System as Sys;
using Toybox.Math as Math;

module Util {
	function getRandom(min, max) {
		return Math.floor(Math.rand() % (max - min + 1)) + min;
	}
	
	function getProperty(name) {
		var property;
		if (isGreaterThan2_4()) {
			property = Application.Storage.getValue(name);
		} else {
			property = Application.getApp().getProperty(name);
		}
		
		return property;
	}
	
	function setProperty(name, property) {
		if (isGreaterThan2_4()) {
			Application.Storage.setValue(name, property);
		} else {
			Application.getApp().setProperty(name, property);
		}
	}
	
	function isGreaterThan2_4() {
		var device = Sys.getDeviceSettings();
		var version = device.monkeyVersion;
		if (version[0] >= 2 && version[1] >= 4) {
			return true;
		}
		return false;
	}
}
