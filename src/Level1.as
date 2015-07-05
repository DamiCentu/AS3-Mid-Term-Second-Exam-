package
{
	public class Level1
	{
		public var level:MC_level;
		public function Level1()
		{
		}
		
		public function spawn ():void
		{
			level = new MC_level;
			Main.mainStage.addChild(level);
			level.y = Main.mainStage.height /2 - 1850;
			level.x = Main.mainStage.width /2 - 120;
			loadPlatforms();
			loadEnemysRespawnPoints();
			Main.myHero = new Hero();
			Main.myHero.spawn(level);
			
			heroRespawnPointLV1();
			for(var i:int = 0 ; i < 2; i++)
			{
				Main.myEnemy = new Enemy();
				Main.myEnemy.spawn();
				if(i == 0)
				{
					Main.myEnemy.model.x = 300;
					Main.myEnemy.model.y = 500;
				}
				if(i == 1)
				{
					Main.myEnemy.model.x = 600;
					Main.myEnemy.model.y = 300;
				}
				//	}
			}
		}
		public function heroRespawnPointLV1 ():void
		{
			Main.myHero.model.x = 225;
			Main.myHero.model.y = 615;
		}
		public function loadPlatforms():void
		{
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_platform")
				{
					Main.platforms.push( level.getChildAt(i) );
					//level.getChildAt(i).alpha = 0;
				}
			}
		}
		public function loadEnemysRespawnPoints():void
		{
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_enemyRespawnPoint")
				{
					Main.enemysRespawnPoints.push( level.getChildAt(i) );
					//level.getChildAt(i).alpha = 0;
				}
			}
		}
	}
}