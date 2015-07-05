package
{
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class Hero
	{
		public var model:MC_hero;
		public var speed:int = 4;
		public var velocityX:int;
		public var velocityY:int;
		public var scale:Number = 0.2;
		public var lifes:int = 5;
		
		public var originalColor:ColorTransform;
		public var effectColor:ColorTransform;
		
		public var timeToReturnOriginalColor:int = 50;
		public var currentTimeToReturnOriginalColor:int = 0;
		
		public function Hero()
		{
		}
		public function spawn ():void
		{
			model = new MC_hero;
			Main.mainStage.addChild(model);
			model.scaleX = model.scaleY = scale;
			
			effectColor = new ColorTransform();
			effectColor.color = 0xFFFFFF;
			
			originalColor = model.transform.colorTransform;
			//model.x = 200;
			//model.y = 600;
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
			if (lifes <= 0)
			{
				Main.loose();
				
			}
			
		}
		public function looseLife ():void
		{
			lifes--;
			
			if(lifes > 0)
			{
				//Main.myLevel1.heroRespawnPointLV1();
				//Main.myLevel2.heroRespawnPointLV2();
				Main.myLevel3.heroRespawnPointLV3();
				
				model.transform.colorTransform = effectColor;
				Main.mainStage.addEventListener(Event.ENTER_FRAME,updateTimeToChangeColor);
			}
		}
		public function moveX(direction:int):void
		{
			velocityX = speed * direction;
		}
		public function moveY(direction:int):void
		{
			velocityY = speed * direction;
		}
		
		public function updateTimeToChangeColor(e:Event):void
		{
			currentTimeToReturnOriginalColor += 1000 / Main.mainStage.frameRate;
			if(currentTimeToReturnOriginalColor >= timeToReturnOriginalColor)
			{
				Main.mainStage.removeEventListener(Event.ENTER_FRAME, updateTimeToChangeColor);
				model.transform.colorTransform = originalColor;
				currentTimeToReturnOriginalColor = 0;
			}
		}
	}
}