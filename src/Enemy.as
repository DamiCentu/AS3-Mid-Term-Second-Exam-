package
{
	import flash.display.MovieClip;
	
	public class Enemy
	{
		public var model:MC_enemy;
		public var scale:Number = 1;
		public var speed:int = 3;
		public var direction:int = 1;
		
		public var currentTimeToShoot:int = 0;
		public var timeToShoot:int = 1500;
		
		public var checkRespawn:Boolean;
		private var actualLevel:MovieClip;
		
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
			//model.mc_checkRight.alpha = 0;
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
			
		}
		public function move():void
		{
			model.x += speed * direction; 
		}
		public function destroy():void
		{
			Main.removeEnemyFromVector(this);
				
			if (actualLevel.contains(model))
			{
				actualLevel.removeChild(model);
			}
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
	}
}