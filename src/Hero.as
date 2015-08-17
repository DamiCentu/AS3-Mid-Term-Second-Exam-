package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class Hero
	{
		public var model:MC_hero;
		public var speed:int = 4;
		public var velocityX:int;
		public var velocityY:int;
		public var scale:Number = 0.2;
		public var lifes:int;
		
		public var originalColor:ColorTransform;
		public var effectColor:ColorTransform;
		
		public var timeToReturnOriginalColor:int = 50;
		public var currentTimeToReturnOriginalColor:int = 0;
		
		public  var texto:TextField = new TextField();
		public  var formato:TextFormat = new TextFormat();
		
		public var actualLevel:MovieClip;
		
		public function Hero()
		{
		}
		public function spawn (level:MovieClip):void
		{
			model = new MC_hero;
			level.addChild(model);
			model.scaleX = model.scaleY = scale;
			
			actualLevel = level;
			if(Main.dificulty == 1)
			{
				lifes = 3;
			}
			else if(Main.dificulty == 2)
			{
				lifes = 2;
			}
			else if(Main.dificulty == 3)
			{
				lifes = 1;
			}
			
			effectColor = new ColorTransform();
			effectColor.color = 0xFFFFFF;
			
			originalColor = model.transform.colorTransform;
			
			model.mc_checkRight.alpha = 0;
			model.mc_checkBack.alpha = 0;
			model.mc_checkLeft.alpha = 0;
			model.mc_checkTop.alpha = 0;
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
				Main.mainStage.removeChild(texto);
			}
			else if (lifes > 0)
			{	
				lifeInStage();
			}
			/*else if(Main.myMenu.visible == true)
			{
				texto.visible = false;
			}
			else if (Main.myMenu.visible == false)
			{
				texto.visible = true;
			}*/
		}
		
		public function lifeInStage():void
		{
				formato.font = "Comic Sans MS";
				formato.size = 30;
				formato.color = 0xFFFFFF;
				formato.align = TextFormatAlign.CENTER;
				texto.width = 300;
				texto.x = -75;
				texto.y = Main.mainStage.stageHeight - texto.height/2;
				texto.text = "Vidas: " + lifes;
				texto.setTextFormat(formato)
				Main.mainStage.addChild(texto);
		}
		
		public function looseLife ():void
		{
			
			
			if(lifes > 0)
			{
				if(Main.actualLevel == 1)
				{
				Main.myLevel1.heroRespawnPointLV1();
				}
				
				if(Main.actualLevel == 2)
				{
					Main.myLevel2.heroRespawnPointLV2();
				}
				
				if(Main.actualLevel == 3)
				{
					Main.myLevel3.heroRespawnPointLV3();
				}
				
				model.transform.colorTransform = effectColor;
				Main.mainStage.addEventListener(Event.ENTER_FRAME,updateTimeToChangeColor);
				
				lifes--;
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