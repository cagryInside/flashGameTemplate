package net.oyunYazar.CagryInside.assistans.soundManager
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	
	public class GameOverSound
	{
		[Embed(source="../Resources/Sounds/flameLoopSound.mp3")]
		private var flameLoopSoundClass:Class ;
		private var flameLoopSound:Sound = new flameLoopSoundClass();
		private var flameLoopSoundChanel:SoundChannel = new SoundChannel();
		private var gameAmbianceSoundControl:SoundTransform = new SoundTransform(1.0, 1.0);
		
		[Embed(source="../Resources/Sounds/evil-laf.mp3")]
		private var evilLafClass:Class ;
		private var evilLaf:Sound = new evilLafClass ();
		private var evilLafController :SoundChannel = new SoundChannel () ;
		
		[Embed(source="../Resources/Sounds/cheering.mp3")]
		private var cheeringClass:Class ;
		private var cheering:Sound = new cheeringClass ();
		
		public function GameOverSound()
		{
		}
		
		public function playFlameLoopSound():void{
			
			flameLoopSoundChanel.soundTransform = gameAmbianceSoundControl;
			flameLoopSoundChanel = flameLoopSound.play(1,100);
		}
		
		public function playFailSound():void{
			evilLafController = evilLaf.play(1,1);
		}
		
		public function playWinSound():void{
			evilLafController = cheering.play(1,1);
		}
		
	}
}