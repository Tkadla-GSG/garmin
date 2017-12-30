using Util;
using Engine;

module Test {
	(:test)
	function copyArray(logger) {
		var arr = [1, 2, 3];
		var copy = Util.copyArray(arr);
		arr[1] = 8;
		logger.debug("modified original = " + arr);
		logger.debug("copy of original  = " + copy);
		return copy[0] == 1 && copy[1] == 2 && copy[2] == 3;
	}
	
	(:test)
	function copyGame(logger) {
		var game = [
			[0, 0, 0, 2],
			[0, 0, 2, 2],
			[0, 2, 2, 2],
			[2, 2, 2, 2],
		];
		var copy = Engine.copyGame(game);
		game[1][3] = 8;
		logger.debug("modified original = " + game);
		logger.debug("copy of original  = " + copy);
		return !Engine.isSame(game, copy);
	}
	
	(:test)
	function isSame(logger) {
		var game = [
			[0, 0, 0, 2],
			[0, 0, 2, 2],
			[0, 2, 2, 2],
			[2, 2, 2, 2],
		];
		var copy = Engine.copyGame(game);
		logger.debug("original = " + game);
		logger.debug("copy  = " + copy);
		return Engine.isSame(game, copy);
	}
	
	(:test)
	function getRandom(logger) {
		var rand = Util.getRandom(0, 2);
		logger.debug("random = " + rand);
		return rand == 0 || rand == 1 || rand == 2;
	}
	
	(:test)
	function getEmptyCoords(logger) {
		var game = [
			[2, 2, 2, 2],
			[2, 2, 0, 2],
			[2, 2, 2, 2],
			[2, 2, 2, 2],
		];
		
		var coords = Engine.getEmptyCoords(game);
		logger.debug("available = " + coords);
		return coords.size() == 1 && coords[0][0] == 1 && coords[0][1] == 2;
	}
	
	(:test)
	function rotateRight(logger) {
		var game = [
			[16, 0, 0, 0],
			[0, 8, 0, 0],
			[0, 32, 4, 0],
			[0, 0, 0, 2],
		];
		var result = [
			[2, 0, 0, 0],
			[0, 4, 32, 0],
			[0, 0, 8, 0],
			[0, 0, 0, 16],
		];
		var rotated = Engine.rotateRight(Engine.rotateRight(game));
		logger.debug("rotated = " + rotated);
		return Engine.isSame(result, rotated);
	}
	
	(:test)
	function add(logger) {
		var game = [
			[16, 0, 0, 0],
			[0, 8, 0, 0],
			[0, 32, 4, 0],
			[0, 0, 0, 2],
		];
		var available = Engine.getEmptyCoords(game);
		var added = Engine.add(game);
		var newAvailable = Engine.getEmptyCoords(added);
		logger.debug("added = " + added);
		return available.size() - 1 == newAvailable.size();
	}
	
	(:test)
	function consolidateRow(logger) {
		var row = [0, 2, 0, 4];
		var consolidated = Engine.consolidateRow(row);
		logger.debug("consolidated = " + consolidated);
		return consolidated.size() == 2 && consolidated[0] == 2 && consolidated[1] == 4;
	}
	
	(:test)
	function padRow(logger) {
		var row = [2, 4];
		var padded = Engine.padRow(row);
		logger.debug("padded = " + padded);
		return padded.size() == 4 && padded[2] == Engine.EMPTY && padded[3] == Engine.EMPTY;
	}
	
	(:test)
	function mergeRow(logger) {
		var row = [2, 2, 4, 4];
		var merged = Engine.mergeRow(row);
		logger.debug("merged = " + merged);
		return merged.size() == 4 && merged[0] == 4 && merged[1] == Engine.EMPTY;
	}
	
	(:test)
	function merge(logger) {
		var game = [
			[2, 2, 2, 0],
			[0, 0, 2, 2],
			[8, 4, 4, 0],
			[0, 4, 4, 0],
		];
		var result = [
			[4, 2, 0, 0],
			[4, 0, 0, 0],
			[8, 8, 0, 0],
			[8, 0, 0, 0],
		];
		var merged = Engine.merge(game);
		logger.debug("merged = " + merged);
		return Engine.isSame(result, merged);
	}
	
	(:test)
	function canMerge(logger) {
		var game = [
			[32, 16, 8, 0],
			[64, 8, 2, 4],
			[1024, 16, 4, 0],
			[32, 32, 4, 2],
		];
		var canMerge = Engine.canMerge(game);
		logger.debug("canMerge = " + canMerge);
		return canMerge == true;
	}
}
