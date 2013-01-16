package net.oyunYazar.CagryInside.gameStates
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.text.*;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class GameOver
	{
		private var main:CagryInside;
		
		[Embed(source="../Resources/gameOverImages/failedBG.png")]
		private var failedBGClass:Class;
		private var failedBG:Bitmap = new failedBGClass() ;
		
		[Embed(source="../Resources/gameOverImages/winBG.png")]
		private var winBGClass:Class;
		private var winBG:Bitmap = new winBGClass() ;
		
		private var gameScoreText:TextField = new TextField();
		private var myTextFormat:TextFormat = new TextFormat();
		
		private var fireEffect:MovieClip = new FireAnimation() as MovieClip;
		private var fireEffect2:MovieClip = new FireAnimation() as MovieClip;
		
		public function GameOver(getMain:CagryInside){
			
			main = getMain;
			
			myTextFormat.font = "ComicSans";
			myTextFormat.size = 30;
			myTextFormat.color = 0x764002;
			myTextFormat.bold = true;
			
			
			if(main.hudLayer.towerHealthBar.width == 0){
				//Mission Failed 
				this.initWithFailed();
				main.gameSoundManager.playSound(1);
			}else {
				//Win
				this.initWithWin();
				main.gameSoundManager.playSound(2);
			}
		}
		
		private function initWithFailed():void{
			
			fireEffect.x = 710;
			fireEffect.y = 300;
			fireEffect.scaleZ = 0.5;
			
			fireEffect2.x = 635;
			fireEffect2.y = 160;
			
			
			main.addChild(failedBG);
			main.addChild(fireEffect);
			main.addChild(fireEffect2);
		}
		
		private function initWithWin():void{
			gameScoreText.defaultTextFormat = myTextFormat;
			gameScoreText.width = 155;
			
			gameScoreText.x = 400;
			gameScoreText.y = 103;
			var finalScore:Number = main.hudLayer.gameScore - main.hudLayer.getBombCount();
			gameScoreText.text = finalScore.toString();
			
			main.addChild(winBG);
			main.addChild(gameScoreText);
		}
	}
}