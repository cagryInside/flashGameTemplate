package net.oyunYazar.CagryInside.gameStates.gamePlay.enemy
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	
	import flashx.textLayout.formats.Float;
	
	import net.oyunYazar.CagryInside.CagryInside;

	public class Bicirik extends MovieClip
	{
		private var main:CagryInside;
		
		//Bicirik's textures
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bicirik/leftLeg.png")]
		private var LeftLegImageClass:Class ;		
		private var leftLegImage:Bitmap = new LeftLegImageClass();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bicirik/rightLeg.png")]
		private var RightLegImageClass:Class ;	
		private var rightLegImage:Bitmap = new RightLegImageClass();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bicirik/centerLeg.png")]
		private var CenterLegImageClass:Class ;	
		private var centerLegImage:Bitmap = new CenterLegImageClass();
		
		private var leftLegSprite:Sprite = new Sprite();
		private var rightLegSprite:Sprite = new Sprite();
		private var centerLegSprite:Sprite = new Sprite();
		
		//Bicirik's legs physic components 
		private var leftLegBody:b2Body;
		private var rightLegBody:b2Body;
		private var centerBody:b2Body;
		
		private var leftLegBodyDef:b2BodyDef = new b2BodyDef();
		private var rightLegBodyDef:b2BodyDef = new b2BodyDef();
		private var centerBodyDef:b2BodyDef = new b2BodyDef();
		
		
		private var leftLegShape:b2PolygonShape = new b2PolygonShape();
		private var rightLegShape:b2PolygonShape = new b2PolygonShape();
		private var centerShape:b2PolygonShape = new b2PolygonShape();
		
		private var leftLegFixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var rightLegFixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var centerFixtureDef:b2FixtureDef = new  b2FixtureDef();
		
		private var leftRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var rightRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		
		private var positionX:Number;
		private var positionY:Number;

		
		private var explosionEffect:MovieClip = new ExplosionEffectLight() as MovieClip;
				
		public function Bicirik(getMain:CagryInside, positionX:Number, positionY:Number){
			
			main = getMain;
			
		//	main.gamePlay.bicirikCounter++;
			
			leftLegImage.x = -20;
			leftLegImage.y = -3;
			leftLegSprite.addChild(leftLegImage);
			
			rightLegImage.x = -20;
			rightLegImage.y = -3;
			rightLegSprite.addChild(rightLegImage);
			
			centerLegImage.x = -20;
			centerLegImage.y = -5;
			centerLegSprite.addChild(centerLegImage);
			
			this.positionX = positionX;
			this.positionY = positionY;
			this.bicirikPhysicObject();
			
			// explosion effect
			
			explosionEffect.alpha = 0;
			main.addChild(explosionEffect);
			
		}
		
		private function bicirikPhysicObject():void{
			
			//Body def //480:y
			leftLegBodyDef.position.Set((positionX-30)/main.world_scale, positionY/main.world_scale);
			rightLegBodyDef.position.Set((positionX+30)/main.world_scale, positionY/main.world_scale);
			centerBodyDef.position.Set(positionX/main.world_scale, positionY/main.world_scale);
			
			leftLegBodyDef.type= b2Body.b2_dynamicBody;
			rightLegBodyDef.type= b2Body.b2_dynamicBody;
			centerBodyDef.type= b2Body.b2_dynamicBody;
			
			//Shape 
			leftLegShape.SetAsBox(20/main.world_scale, 3/main.world_scale);
			rightLegShape.SetAsBox(20/main.world_scale, 3/main.world_scale);
			centerShape.SetAsBox(20/main.world_scale, 5/main.world_scale);
			
			//Fixture
			leftLegFixtureDef.shape = leftLegShape;
			rightLegFixtureDef.shape = rightLegShape;
			centerFixtureDef.shape = centerShape;
			
			//Setting group index to not collide each other 
			leftLegFixtureDef.filter.groupIndex = -2;
			rightLegFixtureDef.filter.groupIndex = -2;
			centerFixtureDef.filter.groupIndex = -2 ;
			
			leftLegFixtureDef.friction = 0.7;
			rightLegFixtureDef.friction = 0.7;
			centerFixtureDef.friction = 0.7;
			
			leftLegFixtureDef.density = 0.5;
			rightLegFixtureDef.density = 0.5;
			centerFixtureDef.density = 2.5;
			
			leftLegFixtureDef.restitution = 0.2;
			rightLegFixtureDef.restitution = 0.2;
			centerFixtureDef.restitution = 0.2;

			//Body
			leftLegBody = main.gamePhysics.addPhysicObject(leftLegBodyDef);
			rightLegBody = main.gamePhysics.addPhysicObject(rightLegBodyDef);
			centerBody = main.gamePhysics.addPhysicObject(centerBodyDef);
			
			leftLegBody.CreateFixture(leftLegFixtureDef);
			rightLegBody.CreateFixture(rightLegFixtureDef);
			centerBody.CreateFixture(centerFixtureDef);
			
			//Joints
			var dx:Number = leftLegBody.GetPosition().x;
			var dy:Number = leftLegBody.GetPosition().y;
			var cx:Number = centerBody.GetPosition().x;
			leftRevoluteJointDef.Initialize(leftLegBody, centerBody, new b2Vec2((dx+(cx-dx)/2),dy));
			
			dx = centerBody.GetPosition().x;
			dy = centerBody.GetPosition().y;
			cx = rightLegBody.GetPosition().x;
			rightRevoluteJointDef.Initialize(centerBody, rightLegBody, new b2Vec2((dx+(cx-dx)/2),dy));
			
			leftRevoluteJointDef.maxMotorTorque = 100;
			leftRevoluteJointDef.enableMotor = true;
			leftRevoluteJointDef.motorSpeed = 5.0 ;
		//	leftRevoluteJointDef.enableLimit = false ;
			//leftRevoluteJointDef.collideConnected = true;
			
			rightRevoluteJointDef.maxMotorTorque = 100;
			rightRevoluteJointDef.enableMotor = true;
			rightRevoluteJointDef.motorSpeed = -5.0;
			//rightRevoluteJointDef.collideConnected = true;
			//rightRevoluteJointDef.enableLimit = false;
			
			
			main.gamePhysics.addJoint(rightRevoluteJointDef);
			main.gamePhysics.addJoint(leftRevoluteJointDef);
			
			//Load bicirik images
			rightLegBody.SetUserData(rightLegSprite);
			leftLegBody.SetUserData(leftLegSprite);
			centerBody.SetUserData(centerLegSprite);
			main.addChild(leftLegSprite);
			main.addChild(rightLegSprite);
			main.addChild(centerLegSprite);
			
			centerBody.setUniqueBodyName("centerLeg");
			
		}
		
		public function handleCollision():Boolean{
			
			if((centerBody.collisionDetected)||(rightLegBody.collisionDetected)||(leftLegBody.collisionDetected)){
				
				main.gamePhysics.destroyBodyWhenCollide(centerBody);
				main.gamePhysics.destroyBodyWhenCollide(leftLegBody);
				main.gamePhysics.destroyBodyWhenCollide(rightLegBody);
				
				leftLegSprite.alpha = 0;
				rightLegSprite.alpha = 0;
				centerLegSprite.alpha = 0;
				
				//TODO : explosion effect 
				explosionEffect.x = centerBody.GetPosition().x * main.world_scale + 30;		
				explosionEffect.y = centerBody.GetPosition().y * main.world_scale;	
				explosionEffect.alpha = 1;
				explosionEffect.play();
				
				main.gameSoundManager.playSound(3);
				
				//TODO : tower hp down
				if(main.hudLayer.towerHealthBar.width - 10 > 0)
					main.hudLayer.towerHealthBar.width -= 10;
				else
					main.hudLayer.towerHealthBar.width = 0;
				
				return true;
			}else 
				return false;
		}
		
		public function getPositionY():Number{

			return centerBody.GetPosition().y*main.world_scale;
			
		}

		
	}
}