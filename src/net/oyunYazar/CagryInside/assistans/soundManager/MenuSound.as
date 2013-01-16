package net.oyunYazar.CagryInside.assistans.soundManager
{
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class MenuSound
	{
		[Embed(source="../Resources/Sounds/menu1.mp3")]
		private var menuSoundClass:Class ;
		private var menuSound:Sound = new menuSoundClass ();
		private var musicChannelController :SoundChannel = new SoundChannel () ;
		
		[Embed(source="../Resources/Sounds/menuLoopSound.mp3")]
		private var menuLoopSoundClass:Class ;
		private var menuLoopSound:Sound = new menuLoopSoundClass();
		private var menuLoopSoundChanel:SoundChannel = new SoundChannel();
		private var menuAmbianceSoundControl:SoundTransform = new SoundTransform(1.0, 1.0);
		
		[Embed(source="../Resources/Sounds/creditsLoopSound.mp3")]
		private var creditsLoopSoundClass:Class ;
		private var creditsLoopSound:Sound = new creditsLoopSoundClass();
		
		public function MenuSound(){
			
		}
		
		public function playButtonMusic():void{
			musicChannelController = menuSound.play(1,1);
		}
		
		public function playMenuLoop():void{
			
			menuLoopSoundChanel.soundTransform = menuAmbianceSoundControl;
			menuAmbianceSoundControl.volume = 4;
			menuLoopSoundChanel = menuLoopSound.play(1,100);
		}
		
		public function creditsMenuLoop():void{
			
			menuLoopSoundChanel.soundTransform = menuAmbianceSoundControl;
			menuAmbianceSoundControl.volume = 4;
			menuLoopSoundChanel = creditsLoopSound.play(1,100);
		}
		
		public function releaseMenuSound():void{
			menuLoopSoundChanel.stop();
		}
	}
}