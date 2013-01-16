package net.oyunYazar.CagryInside.gameStates.gamePlay.player
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class Tower extends Sprite
	{
		private var main:CagryInside;
		
		[Embed(source="../Resources/gamePlayImages/Tower/towerBody.png")]
		private var towerClass:Class ;
		private var tower:Bitmap = new towerClass();
		
		[Embed(source="../Resources/gamePlayImages/Tower/towerCap.png")]
		private var towerCapClass:Class ;
		private var towerCap:Bitmap = new towerCapClass();
		
		[Embed(source="../Resources/gamePlayImages/Tower/towerBazooka.png")]
		private var towerBazookaClass:Class ;
		private var towerBazooka:Bitmap = new towerBazookaClass();
		private var towerBazookaSprite:Sprite = new Sprite();
		

		private var towerBody:b2Body;		
		private var towerBazookaBody:b2Body;
		private var towerBazookaFixture:b2FixtureDef;
		private var towerBazookaBodyDef:b2BodyDef;
		private var bazooka_angle:Number;
		
		//Bombs 
		public var bombArray:Array = new Array();
		public var bombCountArray:Array = new Array();
		private static const BOMB_COUNT:Number = 7; 

		private var smokeEffect:MovieClip = new Smoke() as MovieClip;
		private var smokeEffectEnabled:Boolean = true;
		
		public function Tower(getMain:CagryInside){
			
			main = getMain;
		
			for(var i:Number=0;i<BOMB_COUNT;i++){
				bombCountArray[i] = new Boolean(false);
			}
			/*
			tower = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/Tower/towerBody.png");
			towerCap = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/Tower/towerCap.png");
			towerBazooka = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/Tower/towerBazooka.png");
			*/
			towerBazooka.x = -27;
			towerBazooka.y = -8;
			towerBazookaSprite.addChild(towerBazooka);
		
			//Tower s position 
			tower.x = 597;
			tower.y = 255;
			
			towerCap.x = 672;
			towerCap.y = 278;
			
		//	towerBazooka.x = 635;
		//	towerBazooka.y = 280;
			//towerBazooka.rotation = 180;
			
			this.towerPhysicObject();
			this.bazookaPhysicObject();
			
			//Smoke effects positions 
			smokeEffect.x = 630;
			smokeEffect.y = 160;
			smokeEffect.stop();
			
			main.stage.addEventListener(MouseEvent.CLICK,shoot);
		}
		
		public function shoot(event:MouseEvent):void{
			
			if (MouseEvent.CLICK && main.hudLayer.chargerController){
			
				for(var i:Number=0;i<BOMB_COUNT;i++){
					
					if(!bombCountArray[i]){
						bombArray[i] = new Bomb(main,towerBazookaBody.GetPosition().x, towerBazookaBody.GetPosition().y, 3.0, bazooka_angle);
						bombCountArray[i] = true;
						//Update bomb count
						main.hudLayer.updateBombCount();
						//Charcher sync
						main.hudLayer.bombChargerImage.width +=20;

						//Bomb Sound 
						main.gameSoundManager.playSound(2);
						break;
					}
				}				
			}
		}
		
		private function towerPhysicObject():void{
			
			var tower_body:b2BodyDef= new b2BodyDef();
			
			
			tower_body.position.Set(715/main.world_scale, 540/main.world_scale);
			tower_body.type=b2Body.b2_staticBody;
			
			var head:b2CircleShape=new b2CircleShape(33/main.world_scale);
			var stair1:b2PolygonShape = new b2PolygonShape();
			var stair2:b2PolygonShape = new b2PolygonShape();
			var stair3:b2PolygonShape = new b2PolygonShape();
			
			//Set head's position 
			head.SetLocalPosition(new b2Vec2(-7.5/main.world_scale,-236/main.world_scale));
			////create vectors
			
			var vec1:b2Vec2 = new b2Vec2 (-65/main.world_scale , 0/main.world_scale);
			var vec2:b2Vec2 = new b2Vec2 (-65/main.world_scale , -25/main.world_scale);
			var vec3:b2Vec2 = new b2Vec2 (-50/main.world_scale , -73/main.world_scale);
			var vec4:b2Vec2 = new b2Vec2 (0/main.world_scale , -75/main.world_scale);
			var vec5:b2Vec2 = new b2Vec2 (0/main.world_scale , 0/main.world_scale);
			var vec6:b2Vec2 = new b2Vec2 (-35/main.world_scale , -75/main.world_scale);
			var vec7:b2Vec2 = new b2Vec2 (-32/main.world_scale , -111/main.world_scale);
			var vec8:b2Vec2 = new b2Vec2 (-29/main.world_scale , -111/main.world_scale);
			var vec9:b2Vec2 = new b2Vec2 (0/main.world_scale , -111/main.world_scale);
			var vec10:b2Vec2 = new b2Vec2 (-25/main.world_scale , -214/main.world_scale);
			var vec11:b2Vec2 = new b2Vec2 (0/main.world_scale , -214/main.world_scale);
			
			////make stairs' arrays
			
			var stair1_Vertices:Array = [vec1,vec2,vec3,vec6,vec4,vec5];
			stair1.SetAsArray(stair1_Vertices);
			
			var stair2_Vertices:Array = [vec6, vec7, vec9, vec4];
			stair2.SetAsArray(stair2_Vertices);
			
			var stair3_Vertices:Array =[vec8, vec10, vec11, vec9];
			stair3.SetAsArray(stair3_Vertices);
			
			////make stairs' fixtures
			
			var stair1_fixture:b2FixtureDef = new b2FixtureDef();
			stair1_fixture.shape = stair1;
			stair1_fixture.density = 1;
			stair1_fixture.friction = 0.7;
			
			var stair2_fixture:b2FixtureDef = new b2FixtureDef();
			stair2_fixture.shape = stair2;
			stair2_fixture.density = 1;
			stair2_fixture.friction = 0.7;
			
			var stair3_fixture:b2FixtureDef = new b2FixtureDef();
			stair3_fixture.shape = stair3;
			stair3_fixture.density = 1;
			stair3_fixture.friction = 0.7;
			
			//make tower head fixture 
			var headFixture:b2FixtureDef = new b2FixtureDef();
			headFixture.shape = head;
			headFixture.density = 1;
			headFixture.friction = 0.7;
			
			
			towerBody = main.gamePhysics.addPhysicObject(tower_body);
			towerBody.CreateFixture(stair1_fixture);
			towerBody.CreateFixture(stair2_fixture);
			towerBody.CreateFixture(stair3_fixture);
			towerBody.CreateFixture(headFixture);
			
			towerBody.setUniqueBodyName("towerBody");
					
		}
		
		private function bazookaPhysicObject():void{

			towerBazookaBodyDef =new b2BodyDef();
			towerBazookaBodyDef.type = b2Body.b2_dynamicBody;
			//bazooka 
			
			towerBazookaFixture = new b2FixtureDef();
			var towerBazookaShape:b2PolygonShape= new b2PolygonShape();
			
			var bazookaJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			towerBazookaBodyDef.position.Set(658/main.world_scale,306/main.world_scale);
			towerBazookaShape.SetAsBox(23/main.world_scale,5/main.world_scale);
			
			
			towerBazookaFixture.shape = towerBazookaShape;
			towerBazookaFixture.density = 1;
			towerBazookaFixture.friction = 0.7;
			towerBazookaFixture.filter.groupIndex = -7;
			towerBazookaBody = main.gamePhysics.addPhysicObject(towerBazookaBodyDef);
			towerBazookaBody.CreateFixture(towerBazookaFixture);
						
			bazookaJointDef.Initialize(towerBazookaBody, towerBody, new b2Vec2(684/main.world_scale,306/main.world_scale));
			main.gamePhysics.addJoint(bazookaJointDef);
			
			//towerBazooka.rotationY = 180;
			towerBazookaBody.SetUserData(towerBazookaSprite);
		}
		
		public function syncBazookaAndAnimation():void{

			bazooka_angle = Math.atan2(320-mouseY,730-mouseX);
			
			if (bazooka_angle < Math.PI/4 && bazooka_angle > -Math.PI/3 )
				
				towerBazookaBody.SetAngle(bazooka_angle);
			
			else if(mouseY < 320 ){
				
				bazooka_angle = Math.PI/4;
				towerBazookaBody.SetAngle(bazooka_angle);
					
				}
				else{
					
					bazooka_angle = -Math.PI/3;-Math.PI/3
					towerBazookaBody.SetAngle(bazooka_angle);
				}
		
			towerBazookaBody.SetAngularDamping(5);
			
			//Remove old object 
			for(var i:Number=0;i<BOMB_COUNT;i++){
				
				if(bombCountArray[i]){
					var tempBomb:Bomb = bombArray[i].valueOf();
					tempBomb.handleExplosion();
					
					if (tempBomb.isRemovable){
						bombCountArray[i] = false;
						main.hudLayer.bombChargerImage.width -= 20;
					}
				}
			}
			
			if(main.hudLayer.towerHealthBar.width < 80 && smokeEffectEnabled){
				smokeEffectEnabled = false;
				smokeEffect.alpha = 1;			
				smokeEffect.play();
				main.gameSoundManager.playSound(5);
			}
		
		}
		
		public function loadTowerItems():void{
			
			//Smoke Effects
			smokeEffect.alpha = 0;
			main.addChild(smokeEffect);
			
			main.addChild(towerCap);
			//main.addChild(towerBazookaBody.GetUserData());
			main.addChild(towerBazookaSprite);
			main.addChild(tower);
		}
		
		public function removeTowerItems():void{
			
			//Smoke Effects
			smokeEffect.alpha = 0;
			smokeEffect.stop();
			main.removeChild(smokeEffect);
			
			main.removeChild(towerCap);
			//main.addChild(towerBazookaBody.GetUserData());
			main.removeChild(towerBazookaSprite);
			main.removeChild(tower);
			
			main.stage.removeEventListener(MouseEvent.CLICK,shoot);
		}
	}
}