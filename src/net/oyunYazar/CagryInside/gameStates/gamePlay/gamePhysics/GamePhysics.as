package net.oyunYazar.CagryInside.gameStates.gamePlay.gamePhysics
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import net.oyunYazar.CagryInside.CagryInside;
	
	public class GamePhysics extends Sprite
	{
		private var main:CagryInside;
		
		private var gamePhysicWorld:b2World;
		public var gravity:b2Vec2;
		public var world_scale:int=30;
		public var gameContactHandler:OYContactHandler;		
		
		
		public function GamePhysics(getMain:CagryInside){
			main = getMain;
			
			//game contact handler init
			gameContactHandler = new OYContactHandler(main);
			
			gravity = new b2Vec2(4,4);
			gamePhysicWorld = new b2World(gravity,true);
			gamePhysicWorld.SetContactListener(gameContactHandler);
		
		}
		
		public function addPhysicObject(addedBody:b2BodyDef):b2Body{
			//Adding physic objects to main physic world 
			return gamePhysicWorld.CreateBody(addedBody);
		}
		
		public function addJoint(addedJoint:b2JointDef):void{
			//Adding joints to main physic world 
			gamePhysicWorld.CreateJoint(addedJoint);
		}
		
		public function destroyBodyWhenCollide(body:b2Body):void{
			
			gamePhysicWorld.DestroyBody(body);
		}
		
		public function syncDebugData(debugData:b2DebugDraw):void{
			//Adding drawing information to main world 
			gamePhysicWorld.SetDebugDraw(debugData);
		}
		
		public function runPhysicEngine():void{
			gamePhysicWorld.Step(1/30,10,8);
			gamePhysicWorld.ClearForces();
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = gamePhysicWorld.GetBodyList(); bb; bb = bb.GetNext()){
				//trace(bb.GetUserData());
				if (bb.GetUserData() is Sprite){
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * main.world_scale;
					sprite.y = bb.GetPosition().y * main.world_scale;
					sprite.rotation = bb.GetAngle() * (180/Math.PI);	
				
				}
				if (bb.GetUserData() is MovieClip){
					
					var mv:MovieClip = bb.GetUserData() as MovieClip;
					mv.x = bb.GetPosition().x * main.world_scale;
					mv.y = bb.GetPosition().y * main.world_scale;
					mv.rotation = bb.GetAngle() * (180/Math.PI);	
				
				}
			}
			
			
			
			gamePhysicWorld.DrawDebugData();
		}
		

	}
}