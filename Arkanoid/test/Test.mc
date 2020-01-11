using Util;
using Engine;

module Test {
	(:test)
	function getsRandomAngle(logger) {
		var angle = Util.getRandomAngle();
		logger.debug("random angle = " + angle);
		return true;
	}
}
