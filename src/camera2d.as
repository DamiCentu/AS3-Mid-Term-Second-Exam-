package
{	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class camera2d
	{
		public var view:Sprite;
		
		public function camera2d()
		{
			view = new Sprite ();
		}
		
		public function set x(value:Number):void
		{
			view.x = -value;
		}
		
		public function get x():Number
		{
			return -view.x;
		}
		
		public function set y(value:Number):void
		{
			view.y = -value;
		}
		
		public function get y():Number
		{
			return -view.y;
		}
		
		public function lookAt(mc:MovieClip):void
		{
			/*x = mc.x * zoom - Main.mainStage.stageWidth / 2;
			y = mc.y * zoom - Main.mainStage.stageHeight / 2;*/
			var pLocal:Point = new Point(mc.x, mc.y);
			var pGlobal:Point = mc.parent.localToGlobal(pLocal);
			var pView:Point = view.globalToLocal(pGlobal);
			
			//x = pView.x - Main.mainStage.stageWidth / 2;
			y = pView.y - Main.mainStage.stageHeight / 2;
			
			//trace(pLocal, pGlobal);
		}
		
		public function smoothLookAt():void
		{
			
		}
		
		public function addToView(mc:MovieClip):void
		{
			view.addChild(mc);
		}
		
		public function removeToView(mc:MovieClip):void
		{
			view.removeChild(mc);
		}
		
		public function on():void
		{
			Main.mainStage.addChild(view);
		}
		
		public function off():void
		{
			Main.mainStage.removeChild(view);
		}
	}
}