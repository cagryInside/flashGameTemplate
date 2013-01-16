package net.oyunYazar.CagryInside.assistans
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	
	import net.oyunYazar.CagryInside.CagryInside;
	
	public class OYDeveloperAssistant extends Sprite
	{
		private var last:uint = getTimer();
		private var ticks:uint = 0;
		private var fpsCounter:TextField;
		private var memoryCounter:TextField;
		
		private var main:CagryInside;
		
		public function OYDeveloperAssistant(getMain:CagryInside){
			main = getMain;
		}
		
		public function MemoryFPSCounter():void{
			
			//FPS 
			fpsCounter = new TextField();
			fpsCounter.textColor = 0x55555;
			fpsCounter.x = 550;
			//fpsCounter.text = "FPS: -----";
			fpsCounter.selectable = false;
			
			//Memory
			memoryCounter = new TextField();
			memoryCounter.textColor = 0x55555;
			memoryCounter.x = 550;
			memoryCounter.y = 20;
			//memoryCounter.text = "Used Memory: -------- mb";
			memoryCounter.selectable = false;
			
			
			main.addChild(fpsCounter);
			main.addChild(memoryCounter);
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		public function tick(evt:Event):void {
			ticks++;
			var now:uint = getTimer();
			var delta:uint = now - last;
			if (delta >= 1000) {
				//trace(ticks / delta * 1000+" ticks:"+ticks+" delta:"+delta);
				var fps:Number = ticks / delta * 1000;
				fpsCounter.text = "FPS: " + fps.toFixed(1);
				ticks = 0;
				last = now;
			}
			var mem:String = "Memory: " + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + 'Mb';
			memoryCounter.text = mem;
		}
	}
}