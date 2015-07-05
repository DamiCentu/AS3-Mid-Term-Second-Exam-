package
{
	public class Level2
	{
		public var level:MC_level2;
		public function Level2()
		{
		}
		
		public function spawn ():void
		{
			level = new MC_level2;
			Main.mainStage.addChild(level);
			level.y = Main.mainStage.height /2 - 2550;
			level.x = Main.mainStage.width /2 - 300;
			loadPlatforms();
			loadEnemysRespawnPoints();
			Main.myHero = new Hero();
			Main.myHero.spawn(level);
			//Main.myHero.model.x
			heroRespawnPointLV2();
			for(var i:int = 0 ; i < 2; i++)
			{
				Main.myEnemy = new Enemy();
				Main.myEnemy.spawn(level);
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
		
		public function heroRespawnPointLV2 ():void
		{
			Main.myHero.model.x = 760;
			Main.myHero.model.y = 640;
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