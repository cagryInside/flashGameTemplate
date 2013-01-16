package net.oyunYazar.CagryInside.gameStates.gamePlay
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import net.oyunYazar.CagryInside.CagryInside;
	import net.oyunYazar.CagryInside.assistans.HUDLayer;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.enemy.Bicirik;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.enemy.Bomber;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.enemy.HammerHead;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.gamePhysics.GamePhysics;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.player.Tower;

	public class GamePlay extends Sprite
	{
		private var main:CagryInside;
	

		
		///////Game play images////////
		//Background image
		[Embed(source="../Resources/gamePlayImages/backGround.png")]
		private var backgroundImageClass:Class ;
		private var backgroundImage:Bitmap = new backgroundImageClass();
		
		[Embed(source="../Resources/gamePlayImages/ground.png")]
		private var groundClass:Class ;
		private var ground:Bitmap = new groundClass();
		
		[Embed(source="../Resources/gamePlayImages/roof.png")]
		private var roofClass:Class ;
		private var roof:Bitmap = new roofClass();
		
		//Cloud images
		[Embed(source="../Resources/gamePlayImages/cloud1.png")]
		private var cloud1Class:Class ;
		private var cloud1:Bitmap = new cloud1Class();
		
		[Embed(source="../Resources/gamePlayImages/cloud2.png")]
		private var cloud2Class:Class ;
		private var cloud2:Bitmap = new cloud2Class();
		
		[Embed(source="../Resources/gamePlayImages/cloud3.png")]
		private var cloud3Class:Class ;
		private var cloud3:Bitmap = new cloud3Class();
		
		//Time based game loop items 
		private var currentTime:Number;
		private var timePassed:Number = 0 ;
		
		//Physic objects 
	//	private var physicEngine:GamePhysics;
		
		public var player:b2Body;
		public var towerDefender:Tower;
		
		// ENEMY OBJECTS 
		//Bicirik	
		public var bicirikArray:Array = new Array();
		public var bicirikCounter:Array = new Array();

		//Hummer Head 
		public var hammerHeadArray:Array = new Array();
		public var hammerHeadCounter:Array = new Array();

		//Bomber 
		public var bomber:Bomber;
		public var bomberCounter:Boolean = false;
		
		public function GamePlay(getMain:CagryInside){ 
		
				this.main = getMain;

				//Getting images via load manager 
			/*	backgroundImage = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/backGround.png");
				cloud1 = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/cloud1.png");
				cloud2 = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/cloud2.png");
				cloud3 = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/cloud3.png");
				ground = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/ground.png");
				roof = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/roof.png");
				*/
				//GamePlaySoundLoop
				main.gameSoundManager.playSound(1);
				
				//Sync clouds position 
				cloud1.x = 115;
				cloud1.y = 55;
				
				cloud2.x = 375;
				cloud2.y = 50;
				
				cloud3.x = 615;
				cloud3.y = 80;
				
				ground.y = 270;
				ground.x = -50;
				
				roof.y = 164;
				
				//////////////Game objects //////////////////

				currentTime = getTimer();
				towerDefender = new Tower(main);
				loadGamePlayItems();
				// hudlayer init
				main.hudLayer = new HUDLayer(main);
				
				//Roof ground area with bump 
				draw_roof_ground();
				
				// Enemies in game 
				
				for(var i:Number = 0 ; i <4 ; i++){
					bicirikCounter[i] = new Boolean(false);
					hammerHeadCounter[i] = new Boolean(false);
				}
				
		}
		
		//////////////////////////////////////////////
		///////////Main Game Loop/////////////////////
		public function mainGameLoop(e:Event):void{
			
			//Run physic engine and update all textures 
			main.gamePhysics.runPhysicEngine();
			main.hudLayer.syncGameCountDownTimer();			
			this.spawnEnemyAuto();
			this.enemyController();
			this.enemyCollisionController();

			//Time based calculation items 
			timePassed = getTimer() - currentTime ;
			currentTime += timePassed ;
			towerDefender.syncBazookaAndAnimation();
			
			//Game Over Controller 
			if(main.hudLayer.towerHealthBar.width == 0 || (main.hudLayer.min + main.hudLayer.sec-1 == 0)){
				// Game Over
				main.gameStateManager.selectGameStates(4);
			}
			
		}
		
		private function spawnEnemyAuto():void{
					
			var spawnController:uint = main.hudLayer.sec % ((main.hudLayer.min * 5) + 5);
			//trace(spawnController);
			//Bicirik spawn 
				switch (spawnController)
				{
					case 0:
						
						if(!bicirikCounter[0]){
						bicirikArray[0] = new Bicirik(main, -25, 480);
						bicirikCounter[0] = true;
						
						}
						break;
					case 4:
						
						if(!bicirikCounter[1]){
							bicirikArray[1] = new Bicirik(main, -25, 480);
							bicirikCounter[1] = true;
							
						}
						break;
					case 8:
						
						if(!bicirikCounter[2]){
							bicirikArray[2] = new Bicirik(main, -25, 480);
							bicirikCounter[2] = true;
							
						}
						break;
					case 12:
						
						if(!bicirikCounter[3]){
							bicirikArray[3] = new Bicirik(main, -25, 480);
							bicirikCounter[3] = true;
							
						}
						break;
					default : 
						break;
				}
				
				//HammerHead spawn
				switch (spawnController)
				{
					case 2:
						
						if(!hammerHeadCounter[0]){
							hammerHeadArray[0] = new HammerHead(main,-25,540);
							hammerHeadCounter[0] = true;
							
						}
						break;
					case 6:
						
						if(!hammerHeadCounter[1]){
							hammerHeadArray[1] =  new HammerHead(main,-25,20);
							hammerHeadCounter[1] = true;
							
						}
						break;
					case 10:
						
						if(!hammerHeadCounter[2]){
							hammerHeadArray[2] =  new HammerHead(main,-25,540);
							hammerHeadCounter[2] = true;
							
						}
						break;
					case 14:
						
						if(!hammerHeadCounter[3]){
							hammerHeadArray[3] =  new HammerHead(main,-25,20);
							hammerHeadCounter[3] = true;
							
						}
						break;
					default : 
						break;
				}	
				
				if(main.hudLayer.min == 1 && !bomberCounter && spawnController == 5){
					
					bomber = new Bomber(main,-25,540);
					bomberCounter = true;
				}
				main.addChild(roof);

		}
		
		private function enemyController():void{
			
			for(var i:Number = 0 ; i <4 ; i++){
				
				if(bicirikCounter[i] == true && bicirikArray[i].getPositionY() > 599){
					bicirikCounter[i] = false ;
					main.hudLayer.gameScore +=100;
					
				}
				
				if(hammerHeadCounter[i] == true && hammerHeadArray[i].getPositionY() > 599){
					hammerHeadCounter[i] = false ;
					main.hudLayer.gameScore += 200;
					
				}
				
			}
			
			if(bomberCounter && bomber.getPositionY() > 599){
				bomberCounter = false;
				main.hudLayer.gameScore += 400;
			}

		}
		
		private function enemyCollisionController():void{
			
			for(var i:Number = 0 ; i <4 ; i++){
				if(bicirikCounter[i]){
					var tempBicirik:Bicirik = bicirikArray[i].valueOf();
					
					if(tempBicirik.handleCollision()){
						//collision detected
						bicirikCounter[i] = false;	
					
					}
				}
				
				if(hammerHeadCounter[i]){
					var tempHammerHead:HammerHead = hammerHeadArray[i].valueOf();
					
					if(tempHammerHead.handleCollision()){
						//collision detected
						hammerHeadCounter[i] = false;	
					
					}
				}
				
			}
			
			if(bomberCounter){
				if(bomber.handleCollision()){
					//collision detected
					bomberCounter = false;	
				
				}
			}
			
		}

		private function loadGamePlayItems():void{
	/*		main.addChild(backgroundImage);
			main.addChild(cloud1);
			main.addChild(cloud2);
			main.addChild(cloud3);
			main.addChild(ground);
			main.addChild(roof);
			
			towerDefender.loadTowerItems();
		 */	addEventListener(Event.ENTER_FRAME, mainGameLoop);
		}
		
		public function removeGamePlayItems():void{
			main.removeChild(backgroundImage);
			main.removeChild(cloud1);
			main.removeChild(cloud2);
			main.removeChild(cloud3);
			main.removeChild(roof);
			main.removeChild(ground);
			towerDefender.removeTowerItems();
			main = null;
			
			removeEventListener(Event.ENTER_FRAME, mainGameLoop);
		}
		
		//Setting rectangle shapes for bound area 
		public function draw_box(px:Number,py:Number,w:Number,h:Number,d:Boolean,ud:String):void {
			var my_body:b2BodyDef= new b2BodyDef();
			my_body.position.Set(px/main.world_scale, py/main.world_scale);
			if (d) {
				my_body.type=b2Body.b2_dynamicBody;
			}
			var my_box:b2PolygonShape = new b2PolygonShape();
			my_box.SetAsBox(w/2/main.world_scale, h/2/main.world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.shape=my_box;
			my_fixture.friction = 0.8;  //friction of the ground
			var world_body:b2Body;
			world_body = main.gamePhysics.addPhysicObject(my_body);
			
			//world_body.SetUserData(ud);
			world_body.CreateFixture(my_fixture);
		}
		
		public function draw_roof_ground():void{
			
			var bodyGround:b2Body ;
			var body:b2Body ;
			
			var bodyDef:b2BodyDef = new b2BodyDef() ;
			var bodyGroundDef:b2BodyDef = new b2BodyDef() ;
			
			var bodyGroundShape:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape1:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape2:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape3:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape4:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape5:b2PolygonShape = new b2PolygonShape() ;
			var bodyShape6:b2PolygonShape = new b2PolygonShape() ;
			
			var bodyGroundFixtureDef:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef1:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef2:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef3:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef4:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef5:b2FixtureDef = new b2FixtureDef() ;
			var bodyFixtureDef6:b2FixtureDef = new b2FixtureDef() ;
			
			//draw roof
			var vec1:b2Vec2 = new b2Vec2(241/main.world_scale , 0/main.world_scale) ;
			var vec2:b2Vec2 = new b2Vec2(238/main.world_scale , 59/main.world_scale) ;
			var vec3:b2Vec2 = new b2Vec2(211/main.world_scale , 63/main.world_scale) ;
			var vec4:b2Vec2 = new b2Vec2(182/main.world_scale , 55/main.world_scale) ;
			var vec5:b2Vec2 = new b2Vec2(156/main.world_scale , 75/main.world_scale) ;
			var vec6:b2Vec2 = new b2Vec2(140/main.world_scale , 59/main.world_scale) ;
			var vec7:b2Vec2 = new b2Vec2(118/main.world_scale , 60/main.world_scale) ;
			var vec8:b2Vec2 = new b2Vec2(92/main.world_scale , 77/main.world_scale) ;
			var vec9:b2Vec2 = new b2Vec2(64/main.world_scale , 81/main.world_scale) ;
			var vec10:b2Vec2 = new b2Vec2(18/main.world_scale , 159/main.world_scale) ;
			var vec11:b2Vec2 = new b2Vec2(13/main.world_scale , 187/main.world_scale) ;
			var vec12:b2Vec2 = new b2Vec2(0/main.world_scale , 201/main.world_scale) ;
			var vec13:b2Vec2 = new b2Vec2(0/main.world_scale, 0/main.world_scale) ;
			var vec14:b2Vec2 = new b2Vec2(99/main.world_scale , 0/main.world_scale) ;
			var vec15:b2Vec2 = new b2Vec2(150/main.world_scale , 0/main.world_scale) ;
			var vec16:b2Vec2 = new b2Vec2(185/main.world_scale , 0/main.world_scale) ;
			var vec17:b2Vec2 = new b2Vec2(0/main.world_scale , 150/main.world_scale) ;
			
			var shape1:Array = [vec1, vec2, vec3, vec4, vec16] ;
			var shape2:Array = [vec4, vec5, vec6, vec15, vec16] ;
			var shape3:Array = [vec6, vec7, vec14, vec15] ;
			var shape4:Array = [vec7, vec8, vec9, vec13, vec14] ;
			var shape5:Array = [vec9, vec10, vec17, vec13] ;
			var shape6:Array = [vec10, vec11, vec12, vec17] ;
			
			bodyDef.position.Set(0/main.world_scale , 180/main.world_scale) ;
			bodyDef.type = b2Body.b2_staticBody ;
			
			bodyShape1.SetAsArray(shape1) ;
			bodyShape2.SetAsArray(shape2) ;
			bodyShape3.SetAsArray(shape3) ;
			bodyShape4.SetAsArray(shape4) ;
			bodyShape5.SetAsArray(shape5) ;
			bodyShape6.SetAsArray(shape6) ;
			
			bodyFixtureDef1.shape = bodyShape1 ;
			bodyFixtureDef2.shape = bodyShape2 ;
			bodyFixtureDef3.shape = bodyShape3 ;
			bodyFixtureDef4.shape = bodyShape4 ;
			bodyFixtureDef5.shape = bodyShape5 ;
			bodyFixtureDef6.shape = bodyShape6 ;
			
			bodyFixtureDef1.density = 0.0 ;
			bodyFixtureDef2.density = 0.0 ;
			bodyFixtureDef3.density = 0.0 ;
			bodyFixtureDef4.density = 0.0 ;
			bodyFixtureDef5.density = 0.0 ;
			bodyFixtureDef6.density = 0.0 ;
					
			body = main.gamePhysics.addPhysicObject(bodyDef) ;
			
			body.CreateFixture(bodyFixtureDef1) ;
			body.CreateFixture(bodyFixtureDef2) ;
			body.CreateFixture(bodyFixtureDef3) ;
			body.CreateFixture(bodyFixtureDef4) ;
			body.CreateFixture(bodyFixtureDef5) ;
			body.CreateFixture(bodyFixtureDef6) ;
			
			draw_box(-60,185,520,10,false,"roof");
					
			//draw ground
			
			bodyGroundShape.SetAsBox(430/main.world_scale, 14/main.world_scale) ;
			bodyGroundDef.position.Set(370/main.world_scale, 554/main.world_scale) ;
			bodyGroundDef.type = b2Body.b2_staticBody ; 
		//	bodyGroundDef.angle = 0.03;
			bodyGroundFixtureDef.shape = bodyGroundShape ;
			bodyGroundFixtureDef.density = 0.0 ;
			bodyGround = main.gamePhysics.addPhysicObject(bodyGroundDef) ;
			bodyGround.CreateFixture(bodyGroundFixtureDef) ;

			
			
		}

		
	}
}