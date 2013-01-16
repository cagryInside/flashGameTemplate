package net.oyunYazar.CagryInside
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.*;
	
	import mx.events.ModuleEvent;
	
	import net.oyunYazar.CagryInside.assistans.HUDLayer;
	import net.oyunYazar.CagryInside.assistans.OYDeveloperAssistant;
	import net.oyunYazar.CagryInside.assistans.OYLoadManager;
	import net.oyunYazar.CagryInside.assistans.soundManager.OYSoundManager;
	import net.oyunYazar.CagryInside.gameStates.GameMenu;
	import net.oyunYazar.CagryInside.gameStates.OYGameStateManager;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.GamePlay;
	import net.oyunYazar.CagryInside.gameStates.gamePlay.gamePhysics.GamePhysics;

	
	[SWF(width='800',height='600',frameRate='30',backgroundColor='0xFFFFFF')]
	public class CagryInside extends Sprite
	{
		//Game Controllers 
		public var gLeftArrow:Boolean;
		public var gRightArrow:Boolean;
		public var gUpArrow:  Boolean;
		public var gDownArrow:Boolean;
		
		
		// Game State Classes
		public var gameMenu:GameMenu;
		public var gamePlay:GamePlay;
		
		//Game States
		private static const GAME_MENU:Number  = 0; 
		private static const GAME_PLAY:Number  = 1;
		
		
		////////////////Game Managers///////////////////////
		public var gameLoadManager:OYLoadManager;
		public var gameStateManager:OYGameStateManager;
		public var gameSoundManager:OYSoundManager;
		
		public var devAssistant:OYDeveloperAssistant;
		
		//HUD layer init 
		public var hudLayer:HUDLayer;
		
		//Game physic items 
		public var gamePhysics:GamePhysics;
		public var world_scale:Number = 30;
		public var player:b2Body;
		public function CagryInside()
		{
			devAssistant = new OYDeveloperAssistant(this);
			devAssistant.MemoryFPSCounter();
			
			gameLoadManager = new OYLoadManager(this);
			gameStateManager = new OYGameStateManager(this);
			gameSoundManager = new OYSoundManager();
			
			//Game physic engine 
			gamePhysics = new GamePhysics(this);
			
			
			//Hud layer iint
		//	hudLayer = new HUDLayer(this);
			
			//Temporary physic objects 
			// calling debug draw function
			debug_draw();
			
			//Listennig keyboard events on every frame
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownControl);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpControl);
			
		}
		
		
		public function debug_draw():void {
			var debug_draw:b2DebugDraw = new b2DebugDraw();
			var debug_sprite:Sprite = new Sprite();
			addChild(debug_sprite);
			debug_draw.SetSprite(debug_sprite);
			debug_draw.SetDrawScale(world_scale);
			debug_draw.SetFlags(b2DebugDraw.e_shapeBit);
			//gamePhysics.gamePhysicWorld.SetDebugDraw(debug_draw);
			gamePhysics.syncDebugData(debug_draw);
		}


		public function keyDownControl(event:KeyboardEvent):void{
			//Control if the key is down
			if(event.keyCode == Keyboard.LEFT){
				gLeftArrow = true;
			}else if(event.keyCode == Keyboard.RIGHT){
				gRightArrow = true;
			}else if(event.keyCode == Keyboard.UP){
				gUpArrow = true;
			}else if(event.keyCode == Keyboard.DOWN){
				gDownArrow = true;
			}								
		}
		
		public function keyUpControl(event:KeyboardEvent):void{
			//Control if the key is up
			if(event.keyCode == Keyboard.LEFT){
				gLeftArrow = false;
			}else if(event.keyCode == Keyboard.RIGHT){
				gRightArrow = false;
			}else if(event.keyCode == Keyboard.UP){//W
				gUpArrow = false;
			}else if(event.keyCode == Keyboard.DOWN){//S
				gDownArrow = false;
			}
			
			
		}
	}
}