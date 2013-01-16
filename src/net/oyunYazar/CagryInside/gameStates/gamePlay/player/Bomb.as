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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class Bomb extends MovieClip
	{
		//private var bombImage:Bitmap;
		private var bombSprite:Sprite = new Sprite();
		private var main:CagryInside;
		private var towerBazookaBomb:b2Body;
		
		[Embed(source="../Resources/gamePlayImages/Tower/bomb.png")]
		private var BombImageClass:Class ;
		private var bombImage:Bitmap = new BombImageClass();
		
		public var isRemovable:Boolean = false;
		
		private var bombEffect:MovieClip = new BombExplosion() as MovieClip;
		private var bombRemoveEffect:MovieClip = new ExplosionEffectLight() as MovieClip;
		
		
		public function Bomb(getMain:CagryInside, px:Number, py:Number, pd:Number, bazooka_angle:Number){
			
			main = getMain;
			
			
		//	bombImage = main.gameLoadManager.loadAssistant.getLoadedContent("../Resources/gamePlayImages/Tower/bomb.png");
			
			bombImage.x = -10;
			bombImage.y = -10;
			bombSprite.addChild(bombImage);
			
			var towerBazookaBombDef:b2BodyDef= new b2BodyDef();
//			towerBazookaBombDef.position.Set(px-(23*Math.cos(bazooka_angle-3.14/2))/main.world_scale, py+(23*Math.sin(bazooka_angle-3.1415/2))/main.world_scale);

			towerBazookaBombDef.position.Set(px-(23*Math.cos(bazooka_angle))/main.world_scale, py-(23*Math.sin(bazooka_angle))/main.world_scale);

			towerBazookaBombDef.type=b2Body.b2_dynamicBody;
			var my_circle:b2CircleShape=new b2CircleShape(10/main.world_scale);
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			
			my_fixture.shape = my_circle;
			my_fixture.density = pd;
			my_fixture.friction = 0.7;
			my_fixture.restitution = 0.3;
			//my_fixture.filter.groupIndex = -7;
			
			//sync bomb position
			towerBazookaBomb = main.gamePhysics.addPhysicObject(towerBazookaBombDef);

			towerBazookaBomb.CreateFixture(my_fixture);
			towerBazookaBomb.SetUserData(bombSprite);
			towerBazookaBomb.setUniqueBodyName("bomb");
			towerBazookaBomb.collisionDetected = false;
			
			main.addChild(bombSprite);
						
			towerBazookaBomb.ApplyImpulse(new b2Vec2(-Math.cos(bazooka_angle)*25, - Math.sin(bazooka_angle)*20),towerBazookaBomb.GetWorldCenter());

			
			bombEffect.alpha = 1;
			main.addChild(bombEffect);
			
			bombRemoveEffect.alpha = 0;
			main.addChild(bombRemoveEffect);
			
			bombEffect.x = px*main.world_scale-(23*Math.cos(bazooka_angle));		
			bombEffect.y = py*main.world_scale-(23*Math.sin(bazooka_angle));

		}
		
		public function handleExplosion():void{
			
			if(towerBazookaBomb.collisionDetected){
				main.gamePhysics.destroyBodyWhenCollide(towerBazookaBomb);
				bombSprite.alpha = 0;
				isRemovable = true;
				main.hudLayer.towerHealthBar.width -=10;
				
				bombRemoveEffect.x = towerBazookaBomb.GetPosition().x*main.world_scale ;
				bombRemoveEffect.y = towerBazookaBomb.GetPosition().y*main.world_scale ; 
				bombRemoveEffect.alpha = 1;
				bombRemoveEffect.play();
				
				main.gameSoundManager.playSound(4);
			}
			
			if(towerBazookaBomb.GetPosition().y >= 524/main.world_scale ){
				main.gamePhysics.destroyBodyWhenCollide(towerBazookaBomb);
				bombSprite.alpha = 0;
				isRemovable = true;
				
				bombRemoveEffect.x = towerBazookaBomb.GetPosition().x*main.world_scale ;
				bombRemoveEffect.y = towerBazookaBomb.GetPosition().y*main.world_scale ; 
				bombRemoveEffect.alpha = 1;
				bombRemoveEffect.play();
				
				main.gameSoundManager.playSound(4);
			}
			else if(towerBazookaBomb.GetPosition().x < 0 || towerBazookaBomb.GetPosition().x > 800/main.world_scale){
				
				main.gamePhysics.destroyBodyWhenCollide(towerBazookaBomb);
				bombSprite.alpha = 0;
				isRemovable = true;

			}
		}
		
	}
}