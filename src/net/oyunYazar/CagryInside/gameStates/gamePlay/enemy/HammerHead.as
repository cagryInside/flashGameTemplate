package net.oyunYazar.CagryInside.gameStates.gamePlay.enemy
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import net.oyunYazar.CagryInside.CagryInside;


	public class HammerHead extends MovieClip
	{
		
		private var main:CagryInside;
		
		//HammerHead's legs physic components 
		private var leg1Body:b2Body;
		private var leg2Body:b2Body;
		private var body:b2Body;
		private var bodyCircle:b2Body;
		private var wheele:b2Body;
		private var wheeleRear:b2Body;
		
		private var leg1BodyDef:b2BodyDef = new b2BodyDef();
		private var leg2BodyDef:b2BodyDef = new b2BodyDef();
		private var bodyDef:b2BodyDef = new b2BodyDef();
		private var bodyCircleDef:b2BodyDef = new b2BodyDef();
		private var wheeleDef:b2BodyDef = new b2BodyDef();
		private var wheeleRearDef:b2BodyDef = new b2BodyDef();
		
		private var leg1Shape:b2PolygonShape = new b2PolygonShape();
		private var leg2Shape:b2PolygonShape = new b2PolygonShape();
		private var bodyShape:b2PolygonShape = new b2PolygonShape();
		private var bodyCircleShape:b2CircleShape = new b2CircleShape();
		private var wheeleShape:b2CircleShape = new b2CircleShape();
		private var wheeleRearShape:b2CircleShape = new b2CircleShape();
		
		private var leg1FixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var leg2FixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var bodyFixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var bodyCircleFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var wheeleFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var wheeleRearFixtureDef:b2FixtureDef = new b2FixtureDef();
		
		private var leg1ToLeg2RevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var leg1ToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var circleToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var circleToLeg1DistanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();
		private var circleToLeg2DistanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();
		private var bodyToWheeleRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var bodyToWheeleRearRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		
		private var positionX:Number;
		private var positionY:Number;
		
		[Embed(source="../Resources/gamePlayImages/Enemy/HammerHead/hammerheadbody.png")]
		private var HammerHeadImageClass:Class ;		
		private var hammerHeadImage:Bitmap = new HammerHeadImageClass();
		private var hammerHeadSprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/HammerHead/hammerleg1.png")]
		private var Leg1ImageClass:Class ;		
		private var leg1Image:Bitmap = new Leg1ImageClass();
		private var leg1Sprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/HammerHead/hammerleg2.png")]
		private var Leg2ImageClass:Class ;		
		private var leg2Image:Bitmap = new Leg2ImageClass();
		private var leg2Sprite:Sprite = new Sprite();
		
		private var explosionEffect:MovieClip = new ExplosionEffect() as MovieClip;
		
		public function HammerHead(getMain:CagryInside, positionX:Number, positionY:Number){
			
			main = getMain;
			this.positionX = positionX;
			this.positionY = positionY;
			
			hammerHeadImage.x = -21;
			hammerHeadImage.y = -28;
			hammerHeadSprite.addChild(hammerHeadImage);
			
			leg1Image.x = -14;
			leg1Image.y = -6;
			leg1Sprite.addChild(leg1Image);
			
			leg2Image.x = -16;
			leg2Image.y = -3;
			leg2Sprite.addChild(leg2Image);
			
			this.hammerHeadPhysicObject();
			
			//Explosion effects 
			explosionEffect.alpha = 0;
			main.addChild(explosionEffect);
		}
		
		private function hammerHeadPhysicObject():void{
			
			//Body def
			leg1BodyDef.position.Set((26+positionX)/main.world_scale, (-1+positionY)/main.world_scale);
			leg2BodyDef.position.Set((44+positionX)/main.world_scale, (-2+positionY)/main.world_scale);
			bodyDef.position.Set((5+positionX)/main.world_scale, (8+positionY)/main.world_scale);
			bodyCircleDef.position.Set((5+positionX)/main.world_scale, (0+positionY)/main.world_scale);
			wheeleDef.position.Set((22+positionX)/main.world_scale, (22+positionY)/main.world_scale);
			wheeleRearDef.position.Set((-2+positionX)/main.world_scale, (22+positionY)/main.world_scale);
			
			leg1BodyDef.type = b2Body.b2_dynamicBody;
			leg2BodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyCircleDef.type = b2Body.b2_dynamicBody;
			wheeleDef.type = b2Body.b2_dynamicBody;
			wheeleRearDef.type = b2Body.b2_dynamicBody;
			
			//Shape 
			leg1Shape.SetAsBox(14/main.world_scale, 2.5/main.world_scale);
			leg2Shape.SetAsBox(15/main.world_scale, 2.5/main.world_scale);
			bodyShape.SetAsBox(18/main.world_scale, 16/main.world_scale);
			bodyCircleShape.SetRadius(19/main.world_scale);
			wheeleShape.SetRadius(4.5/main.world_scale);
			wheeleRearShape.SetRadius(4.5/main.world_scale);
			
			//Fixture
			leg1FixtureDef.shape = leg1Shape;
			leg2FixtureDef.shape = leg2Shape;
			bodyFixtureDef.shape = bodyShape;
			bodyCircleFixtureDef.shape = bodyCircleShape;
			wheeleFixtureDef.shape = wheeleShape;
			wheeleRearFixtureDef.shape = wheeleRearShape;
			
			//Setting group index to not collide each other 
			leg1FixtureDef.filter.groupIndex = -2;
			leg2FixtureDef.filter.groupIndex = -2;
			bodyFixtureDef.filter.groupIndex = -2;
			bodyCircleFixtureDef.filter.groupIndex = -2;
			wheeleFixtureDef.filter.groupIndex = -2;
			wheeleRearFixtureDef.filter.groupIndex = -2;
			
//			leftLegFixtureDef.filter.groupIndex = -1;
//			rightLegFixtureDef.filter.groupIndex = -1;
			
			leg1FixtureDef.friction = 0.7;
			leg2FixtureDef.friction = 1.0;
			bodyFixtureDef.friction = 0.7;
			bodyCircleFixtureDef.friction = 0.7;
			wheeleFixtureDef.friction = 0.7
			wheeleRearFixtureDef.friction = 0.7
				
			leg1FixtureDef.density = 3.5;
			leg2FixtureDef.density = 3.5;
			bodyFixtureDef.density = 2.5;
			bodyCircleFixtureDef.density = 3.0;
			wheeleFixtureDef.density = 3.5;
			wheeleRearFixtureDef.density = 3.0;
			
	//		bodyFixtureDef.restitution = 0.6;
			
			var angleLeg1:Number = -Math.atan(2/1);
			var angleLeg2:Number = Math.atan(3/4);
			leg1BodyDef.angle = angleLeg1;
			leg2BodyDef.angle = angleLeg2;
			//leg1Body.SetAngle(1.5);
	
			//Body
			leg1Body = main.gamePhysics.addPhysicObject(leg1BodyDef);
			leg2Body = main.gamePhysics.addPhysicObject(leg2BodyDef);
			body = main.gamePhysics.addPhysicObject(bodyDef);
			bodyCircle = main.gamePhysics.addPhysicObject(bodyCircleDef);
			wheele = main.gamePhysics.addPhysicObject(wheeleDef);
			wheeleRear = main.gamePhysics.addPhysicObject(wheeleRearDef);
			
			leg1Body.CreateFixture(leg1FixtureDef);
			leg2Body.CreateFixture(leg2FixtureDef);
			body.CreateFixture(bodyFixtureDef);
			bodyCircle.CreateFixture(bodyCircleFixtureDef);
			wheele.CreateFixture(wheeleFixtureDef);
			wheeleRear.CreateFixture(wheeleRearFixtureDef);
			
			//Joints
			var leg1Position:b2Vec2 = leg1Body.GetPosition();
			var leg2Position:b2Vec2 = leg2Body.GetPosition();
			var circlePosition:b2Vec2 = bodyCircle.GetPosition();
			
			var leg1JointPointUp:b2Vec2 = new b2Vec2(leg1Position.x + (14*Math.cos(angleLeg1)/main.world_scale),leg1Position.y + (14*Math.sin(angleLeg1)/main.world_scale));
			var leg1JointPointDown:b2Vec2 = new b2Vec2(leg1Position.x - (14*Math.cos(angleLeg1)/main.world_scale),leg1Position.y - (14*Math.sin(angleLeg1)/main.world_scale));
			var leg2JointPoint:b2Vec2 = new b2Vec2(leg2Position.x + (15*Math.cos(angleLeg2)/main.world_scale),  leg2Position.y + (15*Math.sin(angleLeg2)/main.world_scale));
			var circleJointPoint1:b2Vec2 = new b2Vec2(circlePosition.x - (5*Math.cos(0.6)/main.world_scale), circlePosition.y - (5*Math.cos(0.6)/main.world_scale));
			var circleJointPoint2:b2Vec2 = new b2Vec2(circlePosition.x + (11*Math.cos(0.3)/main.world_scale), circlePosition.y - (11*Math.cos(0.3)/main.world_scale));
			
			circleToLeg1DistanceJointDef.Initialize(bodyCircle,leg1Body,circleJointPoint1,leg1JointPointUp);
			circleToLeg2DistanceJointDef.Initialize(bodyCircle,leg2Body,circleJointPoint2,leg2JointPoint);
			bodyToWheeleRevoluteJointDef.Initialize(body,wheele, wheele.GetPosition()); 
			bodyToWheeleRearRevoluteJointDef.Initialize(body,wheeleRear, wheeleRear.GetPosition()); 
			
			bodyToWheeleRevoluteJointDef.enableMotor = true;
			bodyToWheeleRevoluteJointDef.motorSpeed = 80 ;
			bodyToWheeleRevoluteJointDef.maxMotorTorque = 150.0;
			
			bodyToWheeleRearRevoluteJointDef.enableMotor = true;
			bodyToWheeleRearRevoluteJointDef.motorSpeed = 80 ;
			bodyToWheeleRearRevoluteJointDef.maxMotorTorque = 150.0;
			
			leg1ToBodyRevoluteJointDef.Initialize(leg1Body,body,leg1JointPointDown);
		//	leg1ToBodyRevoluteJointDef.enableLimit = true;
		//	leg1ToBodyRevoluteJointDef.upperAngle = 
			
			
			leg1ToLeg2RevoluteJointDef.Initialize(leg1Body,leg2Body,leg1JointPointUp);
			leg1ToLeg2RevoluteJointDef.enableLimit = true;
	/*		leg1ToLeg2RevoluteJointDef.enableMotor = true;
			leg1ToLeg2RevoluteJointDef.motorSpeed = -10;
			leg1ToLeg2RevoluteJointDef.maxMotorTorque =5.0;
	*/		
			circleToBodyRevoluteJointDef.Initialize(body,bodyCircle,bodyCircle.GetPosition());
			
			circleToBodyRevoluteJointDef.enableMotor = true;
			circleToBodyRevoluteJointDef.motorSpeed = 10;
			circleToBodyRevoluteJointDef.maxMotorTorque = 150.0;
			
			main.gamePhysics.addJoint(leg1ToBodyRevoluteJointDef);
			main.gamePhysics.addJoint(leg1ToLeg2RevoluteJointDef);
			main.gamePhysics.addJoint(circleToBodyRevoluteJointDef);
			main.gamePhysics.addJoint(circleToLeg1DistanceJointDef);
			main.gamePhysics.addJoint(circleToLeg2DistanceJointDef);
			main.gamePhysics.addJoint(bodyToWheeleRevoluteJointDef);
			main.gamePhysics.addJoint(bodyToWheeleRearRevoluteJointDef);
			
			//User datas 
			
			body.SetUserData(hammerHeadSprite);
			main.addChild(hammerHeadSprite);
			
			leg1Body.SetUserData(leg1Sprite);
			main.addChild(leg1Sprite);
			
			leg2Body.SetUserData(leg2Sprite);
			main.addChild(leg2Sprite);

		}
		
		public function handleCollision():Boolean{
			
			if(leg2Body.collisionDetected || wheeleRear.collisionDetected || bodyCircle.collisionDetected || body.collisionDetected || leg1Body.collisionDetected ){
				
				main.gamePhysics.destroyBodyWhenCollide(bodyCircle);
				main.gamePhysics.destroyBodyWhenCollide(leg1Body);
				main.gamePhysics.destroyBodyWhenCollide(leg2Body);
				main.gamePhysics.destroyBodyWhenCollide(body);
				main.gamePhysics.destroyBodyWhenCollide(wheele);
				main.gamePhysics.destroyBodyWhenCollide(wheeleRear);
				
				hammerHeadSprite.alpha = 0;
				leg1Sprite.alpha = 0;
				leg2Sprite.alpha = 0;
				
				//Handle Explosion 
				explosionEffect.x = bodyCircle.GetPosition().x * main.world_scale;		
				explosionEffect.y = bodyCircle.GetPosition().y * main.world_scale;	
				explosionEffect.alpha = 1;
				explosionEffect.play();
				
				main.gameSoundManager.playSound(3);
				//Tower hp
				if(main.hudLayer.towerHealthBar.width - 20 > 0)
					main.hudLayer.towerHealthBar.width -= 20;
				else
					main.hudLayer.towerHealthBar.width = 0;
				
				return true;
			}else 
				return false;
		}
		
		public function getPositionY():Number{

			return bodyCircle.GetPosition().y*main.world_scale;
			
		}
	}
}