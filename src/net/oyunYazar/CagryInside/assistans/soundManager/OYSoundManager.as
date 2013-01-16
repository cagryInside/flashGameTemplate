package net.oyunYazar.CagryInside.assistans.soundManager
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import net.oyunYazar.CagryInside.CagryInside;
	
	public class OYSoundManager
	{
		//private var main:CagryInside;
		private var menuSound:MenuSound;
		private var gamePlaySound:GamePlaySound;
		private var gameOverSound:GameOverSound;
		
		private var currentGameState:Number = 0 ;
		private static const GAME_MENU:Number = 1; 
		private static const GAME_PLAY:Number = 2;
		private static const GAME_CREDITS:Number = 3;
		private static const GAME_OVER:Number = 4;
		
		public function OYSoundManager(){
		//	main = getMain;
			
		}
		
		public function syncSoundManager(nextState:Number):void {
			
			//Sync game state elements 
			this.removeSoundElements();
			this.currentGameState = nextState;
			
			if ((currentGameState == GAME_MENU) || (currentGameState == GAME_CREDITS)){	
				menuSound = new MenuSound();
			}
			if (currentGameState == GAME_PLAY){
				gamePlaySound = new GamePlaySound();
			}
			if (currentGameState == GAME_OVER){
				gameOverSound = new GameOverSound();
			}

		} 
		
		private function removeSoundElements():void{
			
			switch (currentGameState) {
				case 0:
				//	main.gameLoadManager.removeLoadManagerMenu();
					break;
				case 1:
					menuSound.releaseMenuSound();
					menuSound = null;
					break;
				case 2:
					gamePlaySound.releaseGameSound();
					gamePlaySound = null;
					break;
				case 3:
					menuSound.releaseMenuSound();
					menuSound = null;
					break;
				default :
					break;
			}
		}
		
		public function playSound(soundID:uint):void{
			
			switch (currentGameState) {
				case 1:
					//Menu
					switch(soundID){
						case 1:
							menuSound.playButtonMusic();
							break;
						case 2: 
							menuSound.playMenuLoop();
							break;
						
						default:
							break;
					}
					
					break;
				case 2:
					//GAME
					switch(soundID){
						case 1:
							gamePlaySound.playGameLoop();
							break;
						case 2: 
							gamePlaySound.playBombSound();
							break;
						case 3:
							gamePlaySound.playEnemyExplosionSound();
							break;
						case 4:
							gamePlaySound.playRemoveBombSound();
							break;
						case 5:
							gamePlaySound.playFlameLoopSound();
							break;
						
						default:
							break;
					}
					
					break;
				case 3:
					switch(soundID){
						case 1: 
							menuSound.playButtonMusic();
							break;
						case 2:
							menuSound.creditsMenuLoop();
							break;
						default:
							break;
					}
					
					break;
				case 4:
					switch(soundID){
						case 1: 
							gameOverSound.playFlameLoopSound();
							gameOverSound.playFailSound();
							break;
						case 2:
							gameOverSound.playWinSound();
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}
		}
		
		
	}
}