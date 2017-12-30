using Toybox.Application;
using Toybox.WatchUi as Ui;
using Engine;

var mGame;
var mFirstMove;
var mWon;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {   	
    	mGame = Engine.loadGame();
    	mFirstMove = Engine.isSame(mGame, Engine.EMPTY_GAME);
    	
    	checkGameWon(mGame);
    	checkGameLost(mGame);
    }

    function onStop(state) {
    	Engine.saveGame(mGame);
    }

    function getInitialView() {
        return [ new View(), new BehaviorDelegate() ];
    }
    
    function checkGameWon(board) {
    	if (Engine.isWon(board)) {
    		mWon = true;
			Ui.pushView(new GameEndView(), new GameEndDelegate(), Ui.SLIDE_UP);
		}
    }
    
    function checkGameLost(board) {
    	if (!Engine.canMove(board) && !Engine.canMerge(board)) {
    		mWon = false;
    		Ui.pushView(new GameEndView(), new GameEndDelegate(), Ui.SLIDE_UP);
    	}
    }
    
    function checkGame(board, copy) {
    	var gameChanged = !Engine.isSame(board, copy);
    	
    	if (gameChanged || mFirstMove) {
    		mGame = Engine.add(mGame);
    		checkGameWon(mGame);
    	} else {
    		checkGameLost(mGame);
    	}
    	
    	mFirstMove = false;
    	Ui.requestUpdate();
    }
    
    function onNewGame() {
    	mFirstMove = true;
    	mGame = Engine.copyGame(Engine.EMPTY_GAME);
    	Ui.requestUpdate();
    }
    
    function onUp() {
    	var copy = Engine.copyGame(mGame);
    	
    	var upBoard = Engine.rotateRight(Engine.rotateRight(Engine.rotateRight(mGame)));
    	var mergedBoard = Engine.merge(upBoard);
    	mGame = Engine.rotateRight(mergedBoard);
    	
    	checkGame(mGame, copy);
    }
    
    function onDown() {
    	var copy = Engine.copyGame(mGame);
    	
    	var downBoard = Engine.rotateRight(mGame);
    	var mergedBoard = Engine.merge(downBoard);
    	mGame = Engine.rotateRight(Engine.rotateRight(Engine.rotateRight(mergedBoard)));
    	
    	checkGame(mGame, copy);
    }
    
    function onLeft() {
    	var copy = Engine.copyGame(mGame);
    	
    	mGame = Engine.merge(mGame);
    	
    	checkGame(mGame, copy);
    }
    
    function onRight() {
    	var copy = Engine.copyGame(mGame);
    	
    	var rightBoard = Engine.rotateRight(Engine.rotateRight(mGame));
    	var mergedBoard = Engine.merge(rightBoard);
    	mGame = Engine.rotateRight(Engine.rotateRight(mergedBoard));
    	
    	checkGame(mGame, copy);
    }
}