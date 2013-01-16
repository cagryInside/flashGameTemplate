package net.oyunYazar.CagryInside.gameStates
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class GameCredits extends Sprite
	{
		private var main:CagryInside;
		
		//Credits Images
		[Embed(source="../Resources/creditsImages/creditsBackground.png")]
		private var creditsBackgroundClass:Class;
		private var creditsBackground:Bitmap = new creditsBackgroundClass();
		
		[Embed(source="../Resources/creditsImages/cagriCetin.png")]
		private var cagriCetinClass:Class;
		private var cagriCetin:Bitmap = new cagriCetinClass();
		
		[Embed(source="../Resources/creditsImages/cagatayDokumaci.png")]
		private var cagatayDokumaciClass:Class;
		private var cagatayDokumaci:Bitmap = new cagatayDokumaciClass();
		
		[Embed(source="../Resources/creditsImages/eceOzmen.png")]
		private var eceOzmenClass:Class;
		private var eceOzmen:Bitmap = new eceOzmenClass();
		
		[Embed(source="../Resources/menuImages/OYLogoHover.png")]
		private var OYBannerClass:Class;
		private var OYBanner:Bitmap = new OYBannerClass();
		
		//Button images
		private var backButtonSprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/creditsImages/backButton.png")]
		private var backButtonClass:Class;
		private var backButton:Bitmap = new backButtonClass();
		
		[Embed(source="../Resources/creditsImages/backOverButton.png")]
		private var backOverButtonClass:Class;
		private var backOverButton:Bitmap = new backOverButtonClass();
		
		public function GameCredits(getMain:CagryInside){
			main = getMain; 
			/*
			creditsBackground = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/creditsImages/creditsBackground.png");
			cagriImage = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/creditsImages/cagriCetin.png");
			OYBanner = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/menuImages/OYLogo.png");
			backButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/creditsImages/backButton.png");
			backOverButton = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/creditsImages/backOverButton.png");
			*/
			main.gameSoundManager.playSound(2);
			
			backButton.x = 20;
			backButton.y = 500;
			backOverButton.x = 16;
			backOverButton.y = 498;
			backOverButton.alpha = 0;
			backButtonSprite.addChild(backButton);
			backButtonSprite.addChild(backOverButton);
			
			cagriCetin.x = 500;
			cagriCetin.y = 620;
			
			cagatayDokumaci.x = 445;
			cagatayDokumaci.y = 720;
			
			eceOzmen.x = 505;
			eceOzmen.y = 820;
			
			OYBanner.x = 420;
			OYBanner.y = 1000;
			
			this.loadCreditsItems();
			
		}
		
		public function backButtonChangerOver(e:MouseEvent):void  {
			//soundManager.playMenuMusic();
			backOverButton.alpha = 1;
			main.gameSoundManager.playSound(1);
		}
		
		public function backButtonChangerOut(e:MouseEvent) :void {
			backOverButton.alpha = 0;
		}
		public function backButtonExecute (e:MouseEvent):void  {
			
			main.gameStateManager.selectGameStates(1);
		}
		
		public function animationLoop(e:Event):void{
		
			if(cagriCetin.y > 100){
				cagriCetin.y -= 1;
				OYBanner.y -= 1;
				cagatayDokumaci.y -=1;
				eceOzmen.y -=1;
			}
			
				
		}
		
		private function loadCreditsItems():void {
			main.addChild(creditsBackground);
			main.addChild(cagriCetin);
			main.addChild(cagatayDokumaci);
			main.addChild(eceOzmen);
			main.addChild(OYBanner);
			main.addChild(backButtonSprite);
			//Start Buttons Event listeners 
			backButtonSprite.addEventListener(MouseEvent.MOUSE_OVER, backButtonChangerOver);
			backButtonSprite.addEventListener(MouseEvent.MOUSE_OUT, backButtonChangerOut);
			backButtonSprite.addEventListener(MouseEvent.MOUSE_UP, backButtonExecute);
			
			addEventListener(Event.ENTER_FRAME, animationLoop);
			
		}
		
		public function removeCreditsItems():void{
			main.removeChild(creditsBackground);
			main.removeChild(cagriCetin);
			main.removeChild(eceOzmen);
			main.removeChild(cagatayDokumaci);
			main.removeChild(OYBanner);
			main.removeChild(backButtonSprite);
			//Start Buttons Event listeners 
			backButtonSprite.removeEventListener(MouseEvent.MOUSE_OVER, backButtonChangerOver);
			backButtonSprite.removeEventListener(MouseEvent.MOUSE_OUT, backButtonChangerOut);
			backButtonSprite.removeEventListener(MouseEvent.MOUSE_UP, backButtonExecute);
			
			removeEventListener(Event.ENTER_FRAME, animationLoop);
			
		}
	}
}