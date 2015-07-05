package
{
	import flash.geom.Point;

	public class Level1
	{
		public var level:MC_level;
		private var heroPoint:Point;
		
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
			loadHeroRespawnPoint();
			Main.myHero = new Hero();
			Main.myHero.spawn(level);
			
			heroRespawnPointLV1();
			
			for(var i:int = 0 ; i < Main.enemysRespawnPoints.length; i++)
			{
				Main.myEnemy = new Enemy();
				Main.myEnemy.spawn(level);
				Main.myEnemy.model.x = Main.enemysRespawnPoints[i].x;
				Main.myEnemy.model.y = Main.enemysRespawnPoints[i].y;
				
			}
		}
		public function heroRespawnPointLV1 ():void
		{
			Main.myHero.model.x = heroPoint.x;
			Main.myHero.model.y = heroPoint.y;
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
			Main.enemysRespawnPoints = new Array();
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_enemyRespawnPoint")
				{
					Main.enemysRespawnPoints.push( level.getChildAt(i));
					//level.getChildAt(i).alpha = 0;
				}
			}
		}
		
		public function loadHeroRespawnPoint():void{
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_heroRespawnPoint")
				{
					heroPoint = new Point(level.getChildAt(i).x, level.getChildAt(i).y);
					//level.getChildAt(i).alpha = 0;
				}
			}
		}
		
	}
}