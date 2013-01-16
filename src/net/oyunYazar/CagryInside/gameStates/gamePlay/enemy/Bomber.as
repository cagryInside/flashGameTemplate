package net.oyunYazar.CagryInside.gameStates.gamePlay.enemy
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import net.oyunYazar.CagryInside.CagryInside;


	public class Bomber extends MovieClip
	{
		
		private var main:CagryInside;
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/bomberBody.png")]
		private var bomberBodyImageClass:Class ;	
		private var bomberBodyImage:Bitmap = new bomberBodyImageClass();
		private var bomberBodySprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/bazookaImg.png")]
		private var bazookaImgClass:Class ;	
		private var bazookaImg:Bitmap = new bazookaImgClass();
		private var bazookaSprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/bazookaImg2.png")]
		private var bazookaImgClass2:Class ;	
		private var bazookaImg2:Bitmap = new bazookaImgClass2();
		private var bazookaSprite2:Sprite = new Sprite();
		
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/wheel.png")]
		private var wheelImgClass:Class ;	
		private var wheelImg:Bitmap = new wheelImgClass();
		private var wheelSprite:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/wheel2.png")]
		private var wheelImgClass2:Class ;	
		private var wheelImg2:Bitmap = new wheelImgClass2();
		private var wheelSprite2:Sprite = new Sprite();
		
		[Embed(source="../Resources/gamePlayImages/Enemy/Bomber/wheel3.png")]
		private var wheelImgClass3:Class ;	
		private var wheelImg3:Bitmap = new wheelImgClass();
		private var wheelSprite3:Sprite = new Sprite();
		
		//Bomber's legs physic components 
		private var bazooka:b2Body;
		private var body:b2Body;
		private var bodyCircle:b2Body;
		private var wheel:b2Body;
		private var wheelRear:b2Body;
		private var wheelFront:b2Body;
		private var circleFront:b2Body;
		private var circleRear:b2Body;
		private var bazookaRear:b2Body;
		
		private var bazookaDef:b2BodyDef = new b2BodyDef();
		private var bodyDef:b2BodyDef = new b2BodyDef();
		private var bodyCircleDef:b2BodyDef = new b2BodyDef();
		private var wheelDef:b2BodyDef = new b2BodyDef();
		private var wheelRearDef:b2BodyDef = new b2BodyDef();
		private var wheelFrontDef:b2BodyDef = new b2BodyDef();
		private var circleFrontDef:b2BodyDef = new b2BodyDef();
		private var circleRearDef:b2BodyDef = new b2BodyDef();
		private var bazookaRearDef:b2BodyDef = new b2BodyDef();
		
		private var bazookaShape:b2PolygonShape = new b2PolygonShape();
		private var bodyShape:b2PolygonShape = new b2PolygonShape();
		private var bodyCircleShape:b2CircleShape = new b2CircleShape();
		private var wheelShape:b2PolygonShape = new b2PolygonShape();
		private var wheelRearShape:b2PolygonShape = new b2PolygonShape();
		private var wheelFrontShape:b2PolygonShape = new b2PolygonShape();
		private var circleFrontShape:b2CircleShape = new b2CircleShape();
		private var circleRearShape:b2CircleShape = new b2CircleShape();
		private var bazookaRearShape:b2PolygonShape = new b2PolygonShape();
		
		private var bazookaFixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var bodyFixtureDef:b2FixtureDef = new  b2FixtureDef();
		private var bodyCircleFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var wheelFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var wheelRearFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var wheelFrontFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var circleFrontFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var circleRearFixtureDef:b2FixtureDef = new b2FixtureDef();
		private var bazookaRearFixtureDef:b2FixtureDef = new b2FixtureDef();
		
		private var bazookaToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var circleToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var bodyToWheelRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var bodyToWheelRearRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var bodyToWheelFrontRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var circleFrontToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var circleRearToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		private var bazookaRearToBodyRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
		
		private var positionX:Number ;
		private var positionY:Number ;
		
		private var explosionEffect:MovieClip = new ExplosionEffect() as MovieClip;
		
		public function Bomber(getMain:CagryInside, posX:Number, posY:Number)	{
			
			main = getMain;
			
			this.positionX = posX;
			this.positionY = posY;
			
			this.bomberPhysicObject();
			
			bomberBodyImage.x = -39;
			bomberBodyImage.y = -48;
			bomberBodySprite.addChild(bomberBodyImage);
			
			bazookaImg.x = -15;
			bazookaImg.y = -5;
			bazookaSprite.addChild(bazookaImg);
			
			bazookaImg2.x = -15;
			bazookaImg2.y = -5;
			bazookaSprite2.addChild(bazookaImg2);
			
			wheelImg.x = -10;
			wheelImg.y = -11;
			wheelSprite.addChild(wheelImg);
			
			wheelImg2.x = -10;
			wheelImg2.y = -11;
			wheelSprite2.addChild(wheelImg2);
			
			wheelImg3.x = -10;
			wheelImg3.y = -11;
			wheelSprite3.addChild(wheelImg3);
			
			//Explosion effects 
			explosionEffect.alpha = 0;
			main.addChild(explosionEffect);
			
		}
		
		public function bomberPhysicObject():void{
			
			//Body Def
			bazookaDef.position.Set((27+positionX)/main.world_scale, (-60+positionY)/main.world_scale);
			bazookaRearDef.position.Set((-22+positionX)/main.world_scale, (-60+positionY)/main.world_scale);
			bodyDef.position.Set((5+positionX)/main.world_scale, (-22+positionY)/main.world_scale);
			bodyCircleDef.position.Set((5+positionX)/main.world_scale, (-45+positionY)/main.world_scale);
			wheelDef.position.Set((7+positionX)/main.world_scale, (-13+positionY)/main.world_scale);
			wheelRearDef.position.Set((-18+positionX)/main.world_scale, (-13+positionY)/main.world_scale);
			wheelFrontDef.position.Set((32+positionX)/main.world_scale, (-13+positionY)/main.world_scale);
			circleFrontDef.position.Set((27+positionX)/main.world_scale, (-39+positionY)/main.world_scale);
			circleRearDef.position.Set((-17+positionX)/main.world_scale, (-40+positionY)/main.world_scale);
			
			bazookaDef.type = b2Body.b2_dynamicBody;
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyCircleDef.type = b2Body.b2_dynamicBody;
			wheelDef.type = b2Body.b2_dynamicBody;
			wheelRearDef.type = b2Body.b2_dynamicBody;
			wheelFrontDef.type = b2Body.b2_dynamicBody;
			circleFrontDef.type = b2Body.b2_dynamicBody;
			circleRearDef.type = b2Body.b2_dynamicBody;
			bazookaRearDef.type = b2Body.b2_dynamicBody;
			
			//Shape
			bazookaShape.SetAsBox(15/main.world_scale, 5/main.world_scale);
			bazookaRearShape.SetAsBox(15/main.world_scale, 5/main.world_scale);
			bodyShape.SetAsBox(37/main.world_scale, 13/main.world_scale);
			bodyCircleShape.SetRadius(25/main.world_scale);
			circleFrontShape.SetRadius(15/main.world_scale);
			circleRearShape.SetRadius(15/main.world_scale);

			//wheelshapes
			var vec1:b2Vec2 = new b2Vec2 (-5/main.world_scale , -5*Math.sqrt(5)/main.world_scale);
			var vec2:b2Vec2 = new b2Vec2 (5/main.world_scale , -5*Math.sqrt(5)/main.world_scale);
			var vec3:b2Vec2 = new b2Vec2 (10/main.world_scale , 0/main.world_scale);
			var vec4:b2Vec2 = new b2Vec2 (5/main.world_scale , 5*Math.sqrt(5)/main.world_scale);
			var vec5:b2Vec2 = new b2Vec2 (-5/main.world_scale , 5*Math.sqrt(5)/main.world_scale);
			var vec6:b2Vec2 = new b2Vec2 (-10/main.world_scale , 0/main.world_scale);
			
			var wheelVertices:Array = [vec1, vec2, vec3, vec4, vec5, vec6];
			wheelShape.SetAsArray(wheelVertices);
			wheelRearShape.SetAsArray(wheelVertices);
			wheelFrontShape.SetAsArray(wheelVertices);
			
			
			//Fixture
			bazookaFixtureDef.shape = bazookaShape ;
			bazookaRearFixtureDef.shape = bazookaRearShape ;
			bodyFixtureDef.shape = bodyShape ;
			bodyCircleFixtureDef.shape = bodyCircleShape ;
			wheelFixtureDef.shape = wheelShape ;
			wheelRearFixtureDef.shape = wheelRearShape ;
			wheelFrontFixtureDef.shape = wheelFrontShape ;
			circleFrontFixtureDef.shape = circleFrontShape ;
			circleRearFixtureDef.shape = circleRearShape ;
			
			//frictions and densities
			bazookaFixtureDef.friction = 0.5 ;
			bazookaRearFixtureDef.friction = 0.5 ;
			bodyFixtureDef.friction = 0.5 ;
			bodyCircleFixtureDef.friction = 0.5 ;
			wheelFixtureDef.friction = 0.9 ;
			wheelRearFixtureDef.friction = 0.9 ;
			wheelFrontFixtureDef.friction = 0.9 ;
			circleFrontFixtureDef.friction = 0.9 ;
			circleRearFixtureDef.friction = 0.9 ;
			
			bazookaFixtureDef.density = 1.0 ;
			bazookaRearFixtureDef.density = 1.0 ;
			bodyFixtureDef.density = 1.0 ;
			bodyCircleFixtureDef.density = 1.0 ;
			wheelFixtureDef.density = 1.0 ;
			wheelRearFixtureDef.density = 1.0 ;
			wheelFrontFixtureDef.density = 1.0 ;
			circleFrontFixtureDef.density = 1.0 ;
			circleRearFixtureDef.density = 1.0 ;
			
			bazookaRearFixtureDef.filter.groupIndex = -2 ;
			bodyFixtureDef.filter.groupIndex = -2 ;
			bazookaFixtureDef.filter.groupIndex = -2 ;
			bodyCircleFixtureDef.filter.groupIndex = -2 ;
			wheelFixtureDef.filter.groupIndex = -2 ;
			wheelFrontFixtureDef.filter.groupIndex = -2 ;
			wheelRearFixtureDef.filter.groupIndex = -2 ;
			circleFrontFixtureDef.filter.groupIndex = -2 ;
			circleRearFixtureDef.filter.groupIndex = -2 ;
			
//			bazookaDef.angle = Math.atan(-1) ;
			
			bazookaRear = main.gamePhysics.addPhysicObject(bazookaRearDef) ;
			bazooka = main.gamePhysics.addPhysicObject(bazookaDef) ;
			body = main.gamePhysics.addPhysicObject(bodyDef) ;
			bodyCircle = main.gamePhysics.addPhysicObject(bodyCircleDef);
			wheel = main.gamePhysics.addPhysicObject(wheelDef) ;
			wheelRear = main.gamePhysics.addPhysicObject(wheelRearDef) ;
			wheelFront = main.gamePhysics.addPhysicObject(wheelFrontDef) ;
			circleFront = main.gamePhysics.addPhysicObject(circleFrontDef) ;
			circleRear = main.gamePhysics.addPhysicObject(circleRearDef) ;
			
			bazookaRear.CreateFixture(bazookaRearFixtureDef);
			bazooka.CreateFixture(bazookaFixtureDef) ;
			body.CreateFixture(bodyFixtureDef) ;
			bodyCircle.CreateFixture(bodyCircleFixtureDef) ;
			wheel.CreateFixture(wheelFixtureDef) ;
			wheelRear.CreateFixture(wheelRearFixtureDef) ;
			wheelFront.CreateFixture(wheelFrontFixtureDef) ;
			circleFront.CreateFixture(circleFrontFixtureDef) ;
			circleRear.CreateFixture(circleRearFixtureDef) ;
			
			//joints
			var wheelJoinPoint:b2Vec2 = new b2Vec2(wheel.GetPosition().x, wheel.GetPosition().y );
			var wheelRearJointPoint:b2Vec2 = new b2Vec2(wheelRear.GetPosition().x , wheelRear.GetPosition().y );
			var wheelFrontJointPoint:b2Vec2 = new b2Vec2(wheelFront.GetPosition().x , wheelFront.GetPosition().y);
			var bazookaJointPoint:b2Vec2 = new b2Vec2(bazooka.GetPosition().x - 15/main.world_scale, bazooka.GetPosition().y);
			var bazookaRearJointPoint:b2Vec2 = new b2Vec2(bazookaRear.GetPosition().x + 15/main.world_scale, bazookaRear.GetPosition().y);
			
			bodyToWheelRevoluteJointDef.Initialize(wheel, body, wheelJoinPoint);
			bodyToWheelRearRevoluteJointDef.Initialize(wheelRear, body, wheelRearJointPoint);
			bodyToWheelFrontRevoluteJointDef.Initialize(wheelFront, body, wheelFrontJointPoint);
			circleToBodyRevoluteJointDef.Initialize(body, bodyCircle, bodyCircle.GetPosition());
			circleFrontToBodyRevoluteJointDef.Initialize(body, circleFront, circleFront.GetPosition());
			circleRearToBodyRevoluteJointDef.Initialize(body, circleRear, circleRear.GetPosition());
			bazookaToBodyRevoluteJointDef.Initialize(bodyCircle, bazooka, bazookaJointPoint);
			bazookaRearToBodyRevoluteJointDef.Initialize(bodyCircle, bazookaRear, bazookaRearJointPoint);
		
			circleToBodyRevoluteJointDef.enableLimit = true ;
			circleFrontToBodyRevoluteJointDef.enableLimit = true ;
			circleRearToBodyRevoluteJointDef.enableLimit = true ;
//			bazookaToBodyRevoluteJointDef.enableLimit = true ;
			
//			bazookaToBodyRevoluteJointDef.upperAngle = Math.PI/2 ;
//			bazookaToBodyRevoluteJointDef.lowerAngle = -Math.PI/5 ;
			
			bazookaToBodyRevoluteJointDef.enableMotor = true ;
			bazookaToBodyRevoluteJointDef.motorSpeed = -13;
			bazookaToBodyRevoluteJointDef.maxMotorTorque = 150.0;
			
			bazookaRearToBodyRevoluteJointDef.enableMotor = true ;
			bazookaRearToBodyRevoluteJointDef.motorSpeed = -13;
			bazookaRearToBodyRevoluteJointDef.maxMotorTorque = 150.0;
			
			bodyToWheelRevoluteJointDef.enableMotor = true;
			bodyToWheelRevoluteJointDef.motorSpeed = -4;
			bodyToWheelRevoluteJointDef.maxMotorTorque = 150.0;
			
			bodyToWheelRearRevoluteJointDef.enableMotor = true;
			bodyToWheelRearRevoluteJointDef.motorSpeed = -6;
			bodyToWheelRearRevoluteJointDef.maxMotorTorque = 150.0;
			
			bodyToWheelFrontRevoluteJointDef.enableMotor = true;
			bodyToWheelFrontRevoluteJointDef.motorSpeed = -4;
			bodyToWheelFrontRevoluteJointDef.maxMotorTorque = 150.0;
			
			main.gamePhysics.addJoint(bodyToWheelRevoluteJointDef);
			main.gamePhysics.addJoint(bodyToWheelRearRevoluteJointDef);
			main.gamePhysics.addJoint(bodyToWheelFrontRevoluteJointDef);
			main.gamePhysics.addJoint(circleToBodyRevoluteJointDef);
			main.gamePhysics.addJoint(circleFrontToBodyRevoluteJointDef) ;
			main.gamePhysics.addJoint(circleRearToBodyRevoluteJointDef) ;
			main.gamePhysics.addJoint(bazookaToBodyRevoluteJointDef) ;
			main.gamePhysics.addJoint(bazookaRearToBodyRevoluteJointDef) ;
			
			body.setUniqueBodyName("bomber");
			
			body.SetUserData(bomberBodySprite);
			bazooka.SetUserData(bazookaSprite);
			bazookaRear.SetUserData(bazookaSprite2);
			
			wheel.SetUserData(wheelSprite);
			wheelRear.SetUserData(wheelSprite2);
			wheelFront.SetUserData(wheelSprite3);
			
			main.addChild(bazookaSprite);
			main.addChild(bazookaSprite2);
			main.addChild(wheelSprite);
			main.addChild(wheelSprite2);
			main.addChild(wheelSprite3);
			main.addChild(bomberBodySprite);
		}
		
		public function handleCollision():Boolean{
			
			if(bazooka.collisionDetected || circleFront.collisionDetected || body.collisionDetected){
				
				main.gamePhysics.destroyBodyWhenCollide(body);
				main.gamePhysics.destroyBodyWhenCollide(bazooka);
				main.gamePhysics.destroyBodyWhenCollide(bodyCircle);
				main.gamePhysics.destroyBodyWhenCollide(wheel);
				main.gamePhysics.destroyBodyWhenCollide(wheelRear);
				main.gamePhysics.destroyBodyWhenCollide(wheelFront);
				main.gamePhysics.destroyBodyWhenCollide(circleFront);
				main.gamePhysics.destroyBodyWhenCollide(circleRear);
				main.gamePhysics.destroyBodyWhenCollide(bazookaRear);

				//TODO : explosion effect 
				explosionEffect.x = bodyCircle.GetPosition().x * main.world_scale;		
				explosionEffect.y = bodyCircle.GetPosition().y * main.world_scale;	
				explosionEffect.alpha = 1;
				explosionEffect.play();
				
				bazookaSprite.alpha = 0;
				bazookaSprite2.alpha = 0;
				bomberBodySprite.alpha = 0;
				wheelImg.alpha = 0;
				wheelImg2.alpha = 0;
				wheelImg3.alpha = 0;
				
				main.gameSoundManager.playSound(3);
				
				//TODO : tower hp down
				if(main.hudLayer.towerHealthBar.width - 30 > 0)
					main.hudLayer.towerHealthBar.width -= 30;
				else
					main.hudLayer.towerHealthBar.width = 0;
				
				return true;
			}else 
				return false;
		}
		
		public function getPositionY():Number{

			return body.GetPosition().y*main.world_scale;
			
		}
		
	}
}