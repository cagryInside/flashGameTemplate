package net.oyunYazar.CagryInside.gameStates
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import net.oyunYazar.CagryInside.CagryInside;
	import net.oyunYazar.CagryInside.assistans.OYLoadManager;
	import net.oyunYazar.CagryInside.assistans.soundManager.OYSoundManager;

	public class GameMenu extends Sprite
	{
		private var main:CagryInside;
		
		//Menu Bacground 
		[Embed(source="../Resources/menuImages/menuImage.png")]
		private var menuBackgroundClass:Class;
		private var menuBackground:Bitmap = new menuBackgroundClass();
		
		//Start Button 
		[Embed(source="../Resources/menuImages/start.png")]
		private var startButtonClass:Class;
		private var startButton:Bitmap = new startButtonClass();
		
		[Embed(source="../Resources/menuImages/startHover.png")]
		private var startHoverButtonClass:Class;
		private var startHoverButton:Bitmap = new startHoverButtonClass();
		private var startSprite:Sprite = new Sprite();
		
		//Credits Button
		[Embed(source="../Resources/menuImages/credits.png")]
		private var creditsButtonClass:Class;
		private var creditsButton:Bitmap = new creditsButtonClass();
		
		[Embed(source="../Resources/menuImages/creditsHover.png")]
		private var creditsHoverButtonClass:Class;
		private var creditsHoverButton:Bitmap = new creditsHoverButtonClass();
		private var creditsSprite:Sprite = new Sprite();
		
		//Oyunyazar Logo Button
		[Embed(source="../Resources/menuImages/OYLogo.png")]
		private var OYButtonClass:Class;
		private var OYButton:Bitmap = new OYButtonClass();
		
		[Embed(source="../Resources/menuImages/OYLogoHover.png")]
		private var OYHoverButtonClass:Class;
		private var OYHoverButton:Bitmap = new OYHoverButtonClass();
		private var OYSprite:Sprite = new Sprite();
		
		public function GameMenu(getMain:CagryInside)
		{
			this.main = getMain;
	/*		//Getting loaded menu items via sound manager 
		//	menuBackground = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/menuImage.png");
			//startButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/start.png");
			//startHoverButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/startHover.png");
			creditsButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/credits.png");
			creditsHoverButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/creditsHover.png");
			OYButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/OYLogo.png");
			OYHoverButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/OYLogoHover.png");
		*/	//Initializing Sound manager
			
			//Sync start button
			startButton.x = 287;
			startButton.y = 280;
			startHoverButton.x = 287;
			startHoverButton.y = 280;
			startHoverButton.alpha = 0;
			startSprite.addChild(startButton);
			startSprite.addChild(startHoverButton);
			
			//Sync credits Button
			creditsButton.x = 323.5;
			creditsButton.y = 330;
			creditsHoverButton.x = 323.5;
			creditsHoverButton.y = 330;
			creditsHoverButton.alpha = 0;
			creditsSprite.addChild(creditsButton);
			creditsSprite.addChild(creditsHoverButton);	
			
			//Sync OY Logo items 
			OYButton.x = 251;
			OYButton.y = 550;
			OYHoverButton.x = 251;
			OYHoverButton.y = 550;
			OYHoverButton.alpha = 0;
			OYSprite.addChild(OYButton);
			OYSprite.addChild(OYHoverButton);
			
			loadMenuItems();
			
			//Menu Loop Sound 
			main.gameSoundManager.playSound(2);
			
		}
		
		public function startChangerOver(e:MouseEvent):void  {
			main.gameSoundManager.playSound(1);
			startHoverButton.alpha = 1;
			
		}
		
		public function startChangerOut(e:MouseEvent) :void {
			startHoverButton.alpha = 0;
			
		}
		public function startExecute (e:MouseEvent):void  {
			//main.gameStateManager.currentGameState = 1;
			main.gameStateManager.selectGameStates(2);
		}
		
		public function creditsChangerOver(e:MouseEvent):void  {
			main.gameSoundManager.playSound(1);
			creditsHoverButton.alpha = 1;
		}
		
		public function creditsChangerOut(e:MouseEvent) :void {
			creditsHoverButton.alpha = 0
		}
		public function creditsExecute (e:MouseEvent):void  {
			//TODO: Create credits session 
			main.gameStateManager.selectGameStates(3);
		}
		
		public function OYChangerOver(e:MouseEvent):void  {
			main.gameSoundManager.playSound(1);
			OYHoverButton.alpha = 1;
		}
		
		public function OYChangerOut(e:MouseEvent) :void {
			OYHoverButton.alpha = 0
		}
		public function OYExecute (e:MouseEvent):void  {

			var url:String = "http://oyunyazar.net";
			var request:URLRequest = new URLRequest(url);
			try {
				navigateToURL(request, '_blank');
			} catch (e:Error) {
				trace("Error occurred!");
			}
		}
		
		public function loadMenuItems():void {
			main.addChild(menuBackground);
			main.addChild(startSprite);
			main.addChild(creditsSprite);
			main.addChild(OYSprite);
			//Start Buttons Event listeners 
			startSprite.addEventListener(MouseEvent.MOUSE_OVER, startChangerOver);
			startSprite.addEventListener(MouseEvent.MOUSE_OUT, startChangerOut);
			startSprite.addEventListener(MouseEvent.MOUSE_UP, startExecute);
			
			//Credits Button event Listener
			creditsSprite.addEventListener(MouseEvent.MOUSE_OVER, creditsChangerOver);
			creditsSprite.addEventListener(MouseEvent.MOUSE_OUT, creditsChangerOut);
			creditsSprite.addEventListener(MouseEvent.MOUSE_UP, creditsExecute);
			
			//OY Button event Listener
			OYSprite.addEventListener(MouseEvent.MOUSE_OVER, OYChangerOver);
			OYSprite.addEventListener(MouseEvent.MOUSE_OUT, OYChangerOut);
			OYSprite.addEventListener(MouseEvent.MOUSE_UP, OYExecute);
			
		}
		
		public function removeMenuItems():void {
			main.removeChild(menuBackground);
			main.removeChild(startSprite);
			main.removeChild(creditsSprite);
			main.removeChild(OYSprite);
			//Removing start button event listener 
			startSprite.removeEventListener(MouseEvent.MOUSE_OVER, startChangerOver);
			startSprite.removeEventListener(MouseEvent.MOUSE_OUT, startChangerOut);
			startSprite.removeEventListener(MouseEvent.CLICK, startExecute);
			
			//Removing credits button event listener 
			creditsSprite.removeEventListener(MouseEvent.MOUSE_OVER, creditsChangerOver);
			creditsSprite.removeEventListener(MouseEvent.MOUSE_OUT, creditsChangerOut);
			creditsSprite.removeEventListener(MouseEvent.CLICK, creditsExecute);
			
			//Removing OY Button event Listener
			OYSprite.removeEventListener(MouseEvent.MOUSE_OVER, OYChangerOver);
			OYSprite.removeEventListener(MouseEvent.MOUSE_OUT, OYChangerOut);
			OYSprite.removeEventListener(MouseEvent.MOUSE_UP, OYExecute);
			
			menuBackground = null;
			startButton = null;
			startHoverButton = null;
			startSprite = null;
			creditsButton = null;
			creditsHoverButton = null;
			creditsSprite = null;
			OYButton = null;
			OYHoverButton = null;
			OYSprite = null;
			main = null;
		}
	}
}