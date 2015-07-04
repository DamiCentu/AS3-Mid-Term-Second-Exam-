package
{
	public class Hero
	{
		public var model:MC_hero;
		public var speed:int = 4;
		public var velocityX:int;
		public var velocityY:int;
		public var scale:Number = 0.2;
		
		public function Hero()
		{
		}
		public function spawn ():void
		{
			model = new MC_hero;
			Main.mainStage.addChild(model);
			model.scaleX = model.scaleY = scale;
			model.x = 200;
			model.y = 600;
			//model.mc_checkRight.alpha = 0;
			//model.mc_checkBack.alpha = 0;
			//model.mc_checkLeft.alpha = 0;
			//model.mc_checkTop.alpha = 0;
		}
		public function update():void
		{
			model.x += velocityX;
			model.y += velocityY;
			velocityY = 0;
			velocityX = 0;
		}
		public function looseLife ():void
		{
			model.x = 200;
			model.y = 600; 
		}
		public function moveX(direction:int):void
		{
			velocityX = speed * direction;
		}
		public function moveY(direction:int):void
		{
			velocityY = speed * direction;
		}
	}
}