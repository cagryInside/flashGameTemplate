package net.oyunYazar.CagryInside.assistans
{

	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import net.oyunYazar.CagryInside.CagryInside;
	
	
	public class OYLoadManager extends Sprite
	{
		private var main:CagryInside;
		//////////////////Load Manager Items///////////////////////////// 
		[Embed(source="../Resources/loadImages/loadBackground.png")]
		private var loadBackgroundClass:Class;
		private var loadBackground:Bitmap = new loadBackgroundClass() ;
		
		[Embed(source="../Resources/loadImages/loadBar.png")]
		private var loadBarClass:Class ;
		private var loadBar : Bitmap = new loadBarClass() ;
		
		private static const loadBarWidth:Number = 612;
		
		private var loadManager:Loader = new Loader();
		
		public function OYLoadManager(getMain:CagryInside)
		{
			main = getMain;
			// Initializing Load Manager 
			loadBar.x = 226; 
			loadBar.y = 396; 
			loadBar.width = 0 ;
			
			//Load Screen images
			main.addChild(loadBackground);
			main.addChild(loadBar);
			//main.gameStateManager.selectGameStates(1);
			
			
			loadManager.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loadScreen);
			loadManager.contentLoaderInfo.addEventListener(Event.COMPLETE, finishProcess);
			loadManager.load(new URLRequest("playerProductInstall.swf"));
			
			
		}
		
		public function finishProcess(event:Event):void{
		//	removeLoadManagerMenu();
			main.gameStateManager.selectGameStates(1);
		}
		
		public function loadScreen(event:ProgressEvent):void{
			var ratio:Number = event.bytesLoaded / event.bytesTotal;
			//loadBar.width += loadBarWidth/loadedObjectNumber ;	
			loadBar.scaleX = ratio;
		}
		
		public function removeLoadManagerMenu():void{
			main.removeChild(loadBackground);
			main.removeChild(loadBar);
		}
	}
}