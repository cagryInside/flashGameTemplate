package net.oyunYazar.CagryInside.assistans.soundManager
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class GamePlaySound
	{
		[Embed(source="../Resources/Sounds/gamePlayLoopSound.mp3")]
		private var gameLoopSoundClass:Class ;
		private var gameLoopSound:Sound = new gameLoopSoundClass();
		private var gameLoopSoundChanel:SoundChannel = new SoundChannel();
		private var gameAmbianceSoundControl:SoundTransform = new SoundTransform(1.0, 1.0);
		
		[Embed(source="../Resources/Sounds/flameLoopSound.mp3")]
		private var flameLoopSoundClass:Class ;
		private var flameLoopSound:Sound = new flameLoopSoundClass();
		private var flameLoopSoundChanel:SoundChannel = new SoundChannel();
		
		[Embed(source="../Resources/Sounds/bombSound.mp3")]
		private var bombSoundClass:Class ;
		private var bombSound:Sound = new bombSoundClass ();
		private var musicChannelController :SoundChannel = new SoundChannel () ;
		
		[Embed(source="../Resources/Sounds/enemyExplosionSound.mp3")]
		private var enemyExplosionSoundClass:Class ;
		private var enemyExplosionSound:Sound = new enemyExplosionSoundClass ();
		
		[Embed(source="../Resources/Sounds/bombRemoveExplosionSound.mp3")]
		private var bombRemoveExplosionSoundClass:Class ;
		private var bombRemoveExplosionSound:Sound = new bombRemoveExplosionSoundClass ();
		
		public function GamePlaySound(){
		}
		
		public function playGameLoop():void{
			
			gameLoopSoundChanel.soundTransform = gameAmbianceSoundControl;
			gameAmbianceSoundControl.volume = 4;
			gameLoopSoundChanel = gameLoopSound.play(1,100);
		}
		
		public function playBombSound():void{
			
			musicChannelController = bombSound.play(1,1);
		}
		
		public function playRemoveBombSound():void{
			musicChannelController = bombRemoveExplosionSound.play(1,1);
		}
		
		public function playEnemyExplosionSound():void{
			musicChannelController = enemyExplosionSound.play(1,1);
		}
		
		public function playFlameLoopSound():void{
			
			flameLoopSoundChanel.soundTransform = gameAmbianceSoundControl;
			flameLoopSoundChanel = flameLoopSound.play(1,100);
		}
		
		public function releaseGameSound():void{
			gameLoopSoundChanel.stop();
			flameLoopSoundChanel.stop();
			musicChannelController.stop();
		}
	}
}