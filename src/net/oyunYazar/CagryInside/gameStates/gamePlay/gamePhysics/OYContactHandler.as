package net.oyunYazar.CagryInside.gameStates.gamePlay.gamePhysics
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.Joints.*;
	
	import flash.display.Sprite;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class OYContactHandler extends b2ContactListener
	{
		private var main:CagryInside;
		
		public function OYContactHandler(getMain:CagryInside){
			main = getMain;
		}
		
		public override function BeginContact(contact:b2Contact):void {
			// getting the fixtures that collided
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// if the fixture is a sensor, mark the parent body to be removed
			
			if(fixtureB.GetBody().getUniqueBodyName() == "towerBody"){
				//trace("BINGOOOOOO B");
				//main.gamePhysics.destroyBodyWhenCollide(fixtureA.GetBody());
				fixtureA.GetBody().collisionDetected = true;
			}
				
			
			if (fixtureA.GetBody().getUniqueBodyName() == "towerBody"){
				//trace("BINGOOOOOO A");
				fixtureB.GetBody().collisionDetected = true;
								
			}
		}
		
	}
}