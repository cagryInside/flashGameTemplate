package net.oyunYazar.CagryInside.gameStates
{
	import flash.events.Event;
	
	import net.oyunYazar.CagryInside.CagryInside;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.GamePlay;

	public class OYGameStateManager
	{
		private var main:CagryInside;
		
		// Game State Classes
		public var gameMenu:GameMenu;
		public var gamePlay:GamePlay;
		public var gameCredits:GameCredits;
		public var gameOver:GameOver;
		
		//Game States
		private var currentGameState:Number = 0 ;
		private static const GAME_MENU:Number = 1; 
		private static const GAME_PLAY:Number = 2;
		private static const GAME_CREDITS:Number = 3;
		private static const GAME_OVER:Number = 4;
		
		public function OYGameStateManager(getMain:CagryInside){
			
			main = getMain;
						
		}
		
		public function selectGameStates(nextState:Number):void {
			
			//Sync game sound manager
			main.gameSoundManager.syncSoundManager(nextState);
			//Sync game state elements 
			this.removeStateElements();
			this.currentGameState = nextState;
			
			if (currentGameState == GAME_MENU){	
				gameMenu = new GameMenu(main);
			} else 	if (currentGameState == GAME_PLAY){
				gamePlay = new GamePlay(main);
			} else 	if (currentGameState == GAME_CREDITS){	
				gameCredits = new GameCredits(main);
			} else 	if(currentGameState == GAME_OVER){
				gameOver = new GameOver(main);
			}
		} 
		
		private function removeStateElements():void{
			
			switch (currentGameState){
				case 0:
					main.gameLoadManager.removeLoadManagerMenu();
					break;
				case 1:
					gameMenu.removeMenuItems();
					gameMenu = null;
					break;
				case 2:
					gamePlay.removeGamePlayItems();
					gamePlay = null;
					break;
				case 3:
					gameCredits.removeCreditsItems();
					gameCredits = null;
					break;
				case 4:
					gamePlay.removeGamePlayItems();
					gamePlay = null;
					break;
				default :
					break;
			}
		}
	}
}