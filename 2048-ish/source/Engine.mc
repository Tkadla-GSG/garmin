using Util;

module Engine {

	const FOREVER = "forever";

	const LINE_0 = "game_line_0";
	const LINE_1 = "game_line_1";
	const LINE_2 = "game_line_2";
	const LINE_3 = "game_line_3";

	const COLOR_START = 0x00AAFF;
	const COLOR_TEXT_DARK = 0x000000;
	const COLOR_BACKGROUND = 0x000000;
	const COLOR_EMPTY = 0x444444;
	const COLOR_2 = 0xAAAAAA;
	const COLOR_4 = 0xFFFFFF;
	const COLOR_8 = 0xFFFFAA;
	const COLOR_16 = 0xFFFF55;
	const COLOR_32 = 0xFFFF00;
	const COLOR_64 = 0xFFAAFF;
	const COLOR_128 = 0xFFAAAA;
	const COLOR_256 = 0xFFAA55;
	const COLOR_512 = 0xFFAA00;
	const COLOR_1024 = 0xFF5555;
	const COLOR_2048 = 0xFF5500;
	const COLOR_4096 = 0xAAFFFF;
	const COLOR_8192 = 0x55FF55;
	const COLOR_16384 = 0xFF55FF;
	const COLOR_32768 = 0xFF0000;
	
	const EMPTY = 0;
	const MIN = 2;
	const MIN_ALT = 4;
	const TARGET = 2048;
	
	const RAND_MIN_THRESHOLD = 20;	
	// Won game
	/*
	const EMPTY_GAME = [
		[1024, 1024, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
	];
	*/
		
	// Lost game
	/*
	const EMPTY_GAME = [
		[2, 4, 2, 4],
		[4, 2, 4, 2],
		[2, 4, 2, 4],
		[4, 2, 4, 2],
	];
	*/
	
	// Best game
	/*
	const EMPTY_GAME = [
		[32768, 16384, 8192, 4096],
		[2048, 1024, 512, 256],
		[128, 64, 32, 16],
		[8, 4, 2, 0],
	];
	*/
	
	const EMPTY_GAME = [
		[EMPTY, EMPTY, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
		[EMPTY, EMPTY, EMPTY, EMPTY],
	];

	function getTileColor(value) {
		switch(value) {
			case 0: {return COLOR_EMPTY;}
			case 2: {return COLOR_2;}
			case 4: {return COLOR_4;}
			case 8: {return COLOR_8;}
			case 16: {return COLOR_16;}
			case 32: {return COLOR_32;}
			case 64: {return COLOR_64;}
			case 128: {return COLOR_128;}
			case 256: {return COLOR_256;}
			case 512: {return COLOR_512;}
			case 1024: {return COLOR_1024;}
			case 2048: {return COLOR_2048;}
			case 4096: {return COLOR_4096;}
			case 8192: {return COLOR_8192;}
			case 16384: {return COLOR_16384;}
			case 32768: {return COLOR_32768;}
		}
	}
	
	function copyGame(game) {
		var copy = new [game.size()];
		for (var i = 0; i < game.size(); i++) {
			copy[i] = Util.copyArray(game[i]); 
		}
		return copy;
	}
	
	function isSame(a, b) {
		for (var i = 0; i < a.size(); i++) {
			for (var j = 0; j < a[i].size(); j++) {
				if (a[i][j] != b[i][j]) {
					return false;
				}
			}
		}
		return true;
	}
	
	function rotateRight(board) {
		var newBoard = [
			[board[3][0], board[2][0], board[1][0], board[0][0]],
            [board[3][1], board[2][1], board[1][1], board[0][1]],
            [board[3][2], board[2][2], board[1][2], board[0][2]],
            [board[3][3], board[2][3], board[1][3], board[0][3]]
		];
		return newBoard;
	}
	
	function getEmptyCoords(board) {
		var avail = new [0];
		for (var i = 0; i < board.size(); i++) {
			for (var j = 0; j < board[i].size(); j++) {
				if (board[i][j] == EMPTY) {
					var coord = new [2];
					coord[0] = i;
					coord[1] = j;
					avail.add(coord);
				}
			}
		}
		return avail;
	}
	
	function canMergePoint(board, rowIndex, valIndex) {
	    var val = board[rowIndex][valIndex];
	    var canMergeUp = rowIndex - 1 >= 0 && (val == board[rowIndex - 1][valIndex]);
	    var canMergeDown = rowIndex + 1 < board.size() && (val == board[rowIndex + 1][valIndex]);
	    var canMergeLeft = valIndex - 1 >= 0 && (val == board[rowIndex][valIndex - 1]);
	    var canMergeRight = valIndex + 1 < board[rowIndex].size() && (val == board[rowIndex][valIndex + 1]);
	    return canMergeUp || canMergeDown || canMergeLeft || canMergeRight;
	}
	
	function canMerge(board) {
	    return canMergePoint(board, 0, 0)
	    ||  canMergePoint(board, 0, 2)
	    ||  canMergePoint(board, 1, 1)
	    ||  canMergePoint(board, 1, 3)
	    ||  canMergePoint(board, 2, 0)
	    ||  canMergePoint(board, 2, 2)
	    ||  canMergePoint(board, 3, 1)
	    ||  canMergePoint(board, 3, 3);
	}
	
	function canMove(board) {
        return getEmptyCoords(board).size() != 0;
    }
	
	function isWon(board) {
		for (var i = 0; i < board.size(); i++) {
			for (var j = 0; j < board[i].size(); j++) {
				if (board[i][j] >= TARGET) {
					return true;
				}
			}
		}
		return false;
	}
	
	function mergeRow(row) {
        var newRow = new [row.size()];
        for (var i = 0; i < row.size(); i++) {
            if ((i + 1) < (row.size())) {
                if (row[i] != EMPTY && row[i] == row[i + 1]) {
                    newRow[i] = row[i] + row[i + 1];
                    newRow[i + 1] = EMPTY;
                    i++;
                } else {
                    newRow[i] = row[i];
                }
            } else {
                newRow[i] = row[i];
            }                    
        }
        return newRow;
    }
	
	function padRow(row) {
		var pad = new [4 - row.size()];
		for (var i = 0; i < pad.size(); i++) {
			pad[i] = EMPTY;
		}
        return row.addAll(pad);
    }

    function consolidateRow(row) {
    	var newRow = new [0];
    	for (var i = 0; i < row.size(); i++) {
    		if (row[i] != EMPTY) {
    			newRow.add(row[i]);
    		}
    	}
        return newRow;
    }
	
	function add(board) {
		var coords = getEmptyCoords(board);
		if (coords.size() == 0) {
			return board;
		}
		
		var coord = coords[Util.getRandom(0, coords.size() - 1)];
		var tileValue = Util.getRandom(0, 100) < RAND_MIN_THRESHOLD ? MIN_ALT : MIN;
		board[coord[0]][coord[1]] = tileValue;
		return board;
	}
	
	function merge(board) {
        var mergedBoard = new [board.size()];
        for(var i = 0; i < board.size(); i++) {
        	var row = board[i];
            var collapsedRow = consolidateRow(row);
            var mergedRow = mergeRow(collapsedRow); 
            var mergedCollapsedRow = consolidateRow(mergedRow);         
            mergedBoard[i] = padRow(mergedCollapsedRow);
        }
        return mergedBoard;
    }
    
    function saveGame(game, playForever) {
    	Util.setProperty(LINE_0, game[0]);
    	Util.setProperty(LINE_1, game[1]);
    	Util.setProperty(LINE_2, game[2]);
    	Util.setProperty(LINE_3, game[3]);
    	Util.setProperty(FOREVER, playForever);
    }
    
    function loadGame() {
    	var line0 = Util.getProperty(LINE_0);
    	var line1 = Util.getProperty(LINE_1);
    	var line2 = Util.getProperty(LINE_2);
    	var line3 = Util.getProperty(LINE_3);
    	
    	if (line0 == null || line1 == null || line2 == null || line3 == null) {
    		return copyGame(EMPTY_GAME);
    	}
    	
    	var forever = Util.getProperty(FOREVER);
    	$.mPlayForever = forever == null ? false : forever;
    	
    	return [
    		line0,
    		line1,
    		line2,
    		line3
    	];
    }
}
