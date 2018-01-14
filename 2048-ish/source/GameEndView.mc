using Toybox.WatchUi as Ui;

class GameEndView extends Ui.View {

	const IMAGE_SIZE_2 = 25;
	
	var mWinMessage;
	var mLostMessage;
	var mWinImage;
	var mLostImage;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.GameEnd(dc));
       
		mWinMessage = Ui.loadResource(Rez.Strings.Win);
		mLostMessage = Ui.loadResource(Rez.Strings.Lost);
		
		mLostImage = Ui.loadResource(Rez.Drawables.LostIcon);
		mWinImage = Ui.loadResource(Rez.Drawables.WinIcon);
    }
    
    function onUpdate(dc) {
       	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
       	dc.clear();
       	
    	var text = $.mWon ? mWinMessage : mLostMessage;
    	var image = $.mWon ? mWinImage : mLostImage;
    	
    	dc.drawBitmap(dc.getWidth()/2 - IMAGE_SIZE_2, dc.getHeight()/2 - 2 * IMAGE_SIZE_2, image);
		dc.drawText(dc.getWidth()/2, dc.getHeight()/2 + IMAGE_SIZE_2, dc.FONT_SYSTEM_LARGE, text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
