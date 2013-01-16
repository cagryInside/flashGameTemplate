package net.oyunYazar.CagryInside.assistans
{
	import flash.display.Bitmap;
	import flash.text.*;
	import flash.utils.getTimer;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class HUDLayer
	{
		private var main:CagryInside;
		
		//number of bombs 
		private var bombCount:Number = 0;
		private var bombCountText:TextField = new TextField();
		private var timeText:TextField = new TextField();
		

		private var scoreText:TextField = new TextField();
		private var scoreValueText:TextField = new TextField();
		private var gameCountDown:TextField = new TextField();
		private var myTextFormat:TextFormat = new TextFormat();
		private var numberFormat:TextFormat = new TextFormat();
		
		//Time countdown attributes
		private var startTime:uint = getTimer();
		private var currentTimer:uint;		
		public var min:uint;
		public var sec:uint;
		
		// Game score 
		public var gameScore:uint = 0;
		private var gameScoreText:TextField = new TextField();
		
		//Bomb charger 
		[Embed(source="../Resources/hudLayerImages/bombCharger.png")]
		private var bombChargerImageClass:Class ;
		public var bombChargerImage:Bitmap = new bombChargerImageClass();
		public var chargerController:Boolean = true;
		
		//Tower Health Bar
		[Embed(source="../Resources/hudLayerImages/towerHealthBar.png")]
		private var towerHealthBarClass:Class ;
		public var towerHealthBar:Bitmap = new towerHealthBarClass();
		
		//Left Panel
		[Embed(source="../Resources/hudLayerImages/leftPanel.png")]
		private var leftPanelClass:Class ;
		public var leftPanel:Bitmap = new leftPanelClass();
		
		//Right Panel
		[Embed(source="../Resources/hudLayerImages/rightPanel.png")]
		private var rightPanelClass:Class ;
		public var rightPanel:Bitmap = new rightPanelClass();
		
		//Bomb Panel
		[Embed(source="../Resources/hudLayerImages/bombPanel.png")]
		private var bombPanelClass:Class ;
		public var bombPanel:Bitmap = new bombPanelClass();
		
		
		public function HUDLayer(getMain:CagryInside){
			
			main= getMain;
			
			/*
			bombChargerImage = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/hudLayerImages/bombCharger.png");
			towerHealthBar = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/hudLayerImages/towerHealthBar.png");
			*/
			
			
			myTextFormat.font = "ComicSans";
			myTextFormat.size = 15;
			myTextFormat.color = 0x124f6f;
			myTextFormat.bold = true;
			
			numberFormat.font = "ComicSans";
			numberFormat.size = 17;
			numberFormat.color = 0xfc7423;
			numberFormat.bold = true;
			
			//bomb count 
			bombCountText.defaultTextFormat = numberFormat;
			bombCountText.width = 155;
			
			bombCountText.x = 200;
			bombCountText.y = 5;
			
			bombCountText.text = "0";
			
			// Timer text
			gameCountDown.defaultTextFormat = myTextFormat;
			gameCountDown.width = 155;
			
			gameCountDown.x = 740;
			gameCountDown.y = 12;
			
			gameCountDown.text = "";
			
			timeText.defaultTextFormat = myTextFormat;
			timeText.width = 155;
			
			timeText.x = 735;
			timeText.y = -1;
			
			timeText.text = "TIME";
			
			//Score 
			gameScoreText.defaultTextFormat = myTextFormat;
			
			gameScoreText.x = 750;
			gameScoreText.y = 44;
			
			scoreText.defaultTextFormat = myTextFormat;
			scoreText.width = 155;
			
			scoreText.x = 730;
			scoreText.y = 31;
			
			scoreText.text = "SCORE";
			
			//bomb charger 
			bombChargerImage.x = 16;
			bombChargerImage.y = 9;
			bombChargerImage.width = 0;
			
			// tower health bar 
			towerHealthBar.x = 16;
			towerHealthBar.y = 32;
			
			// Left Panel
			leftPanel.x = -6;
			leftPanel.y = -5;
			
			// Rigth Panel
			rightPanel.x = 701;
			rightPanel.y = -5;
			
			// Bomb Panel
			bombPanel.x = 175;
			bombPanel.y = -1;
			
			
			main.addChild(towerHealthBar);
			main.addChild(bombChargerImage);
			main.addChild(bombPanel);
			main.addChild(gameCountDown);
			main.addChild(bombCountText);
			main.addChild(gameScoreText);
			main.addChild(scoreText);
			main.addChild(timeText);
			main.addChild(rightPanel);
			main.addChild(leftPanel);
			
		}
		
		public function updateBombCount():void{
			
			bombCount++;
			bombCountText.text = bombCount.toString();
		}
		
		public function syncGameCountDownTimer():void{
			
			currentTimer = (getTimer() - startTime)/1000;
			min = 2 - Math.floor(currentTimer/60);
			sec = 60 - Math.floor(currentTimer%60);
			gameCountDown.text = min.toString()+":"+sec.toString();
			
			//Score 
			gameScoreText.text = gameScore.toString();
			this.syncPanel();
		}
		
		public function getBombCount():Number{
			
			return bombCount;
		}
		
		private function syncPanel():void{
			
			if(chargerController && bombChargerImage.width == 140)
				chargerController = false;
			
			if(!chargerController && bombChargerImage.width < 70){
				chargerController = true;
			}
			
		}
	}
}