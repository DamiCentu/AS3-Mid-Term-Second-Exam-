package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class Enemy
	{
		public var model:MC_enemy;
		public var scale:Number = 1;
		public var speed:int;
		public var direction:int = 1;
		public var modelExplotion:MC_explotion;
		
		public var currentTimeToShoot:int = 0;
		public var timeToShoot:int;
		
		public var checkRespawn:Boolean;
		private var actualLevel:MovieClip;
		
		public var originalColor:ColorTransform;
		public var effectColor:ColorTransform;
		
		public var timeToReturnOriginalColor:int = 50;
		public var currentTimeToReturnOriginalColor:int = 0;
		
		public var scaleExplotion:Number = 0.3;
		
		public var respawneoAnimation:Boolean = false;
		
		public function Enemy()
		{
		}
		
		public function spawn (level:MovieClip):void
		{
			model = new MC_enemy;
			actualLevel = level;
			level.addChild(model);
			model.scaleX = model.scaleY = scale;
			Main.vectorEnemys.push(this);
			model.mc_checkRight.alpha = 0;
			model.mc_checkLeft.alpha = 0;
			
			if(Main.dificulty == 1)
			{
				speed = 3;
				timeToShoot = 1500;
			}
			else if(Main.dificulty == 2)
			{
				speed = 4;
				timeToShoot = 1250;
			}
			else if(Main.dificulty == 3)
			{
				speed = 5;
				timeToShoot = 1000;
			}
			
			effectColor = new ColorTransform();
			effectColor.color = 0xFFFFFF;
			
			originalColor = model.transform.colorTransform;
		}
		
		public function update():void
		{
			for (var i:int =0 ; i < Main.vectorEnemys.length; i++) 
			{
				if (Main.vectorEnemys[i] !=null)
				{
					Main.vectorEnemys[i].move();
				}				
			}
			
			timerToShoot();
		
			if (checkRespawn)
			{
				for (var l:int =0 ; l < Main.vectorEnemyBullets.length; l++) 
				{
					if (Main.vectorEnemyBullets[l] !=null)
					{
						Main.vectorEnemyBullets[l].update();
					}				
				}		
			}
			else if (respawneoAnimation)
			{
				if(modelExplotion.currentFrame >= modelExplotion.totalFrames)
				{
					removeAnimation();
				}
			}
		}
		public function move():void
		{
			model.x += speed * direction; 
		}
		public function destroy():void
		{
			model.transform.colorTransform = effectColor;
			Main.mainStage.addEventListener(Event.ENTER_FRAME,updateTimeToChangeColor);
		}
		
		public function destroyAndRemove():void
		{
			spawnAnimation();
			Main.removeEnemyFromVector(this);
			
			if (actualLevel.contains(model))
			{
				actualLevel.removeChild(model);
			}
		}
		
		//public function spawnAnimation(level:MovieClip):void
		public function spawnAnimation():void
		{
			modelExplotion = new MC_explotion;
			//actualLevel = level;
			//level.addChild(modelExplotion);
			actualLevel.addChild(modelExplotion);
			modelExplotion.x = model.x;
			modelExplotion.y = model.y;
			modelExplotion.scaleX = modelExplotion.scaleY = scaleExplotion;
			respawneoAnimation = true;
		}
		
		public function removeAnimation():void
		{
			if (actualLevel.contains(modelExplotion)){
				actualLevel.removeChild(modelExplotion);
			}
			respawneoAnimation = false;
		}
		
		public function timerToShoot():void
		{
			currentTimeToShoot += 1000 / Main.mainStage.frameRate;
			if(currentTimeToShoot >= timeToShoot)
			{
				for (var i:int =0 ; i < Main.vectorEnemys.length; i++) 
				{
					Main.myEnemyBullet = new EnemyBullet ();
					Main.myEnemyBullet.spawn(actualLevel, Main.vectorEnemys[i].model.y + 30, Main.vectorEnemys[i].model.x + 15);
					currentTimeToShoot = 0
					if (Main.myEnemyBullet.spawneo)
					{
						checkRespawn = true;
					}
				}
			}
		}
		
		public function updateTimeToChangeColor(e:Event):void
		{
			currentTimeToReturnOriginalColor += 1000 / Main.mainStage.frameRate;
			if(currentTimeToReturnOriginalColor >= timeToReturnOriginalColor)
			{
				Main.mainStage.removeEventListener(Event.ENTER_FRAME, updateTimeToChangeColor);
				model.transform.colorTransform = originalColor;
				currentTimeToReturnOriginalColor = 0;
				destroyAndRemove();
			}
		}
	}
}