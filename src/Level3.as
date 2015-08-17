package
{
	import flash.geom.Point;

	public class Level3
	{
		public var level : MC_level3;
		private var heroPoint:Point;
		public var bossPoint:Point;
		
		public function Level3()
		{
		}
		
		public function spawn ():void
		{
			level = new MC_level3;
			level.x = Main.mainStage.width /2 - 350;
			loadPlatforms();
			loadBossRespawnPoint();
			loadHeroRespawnPoint();
			Main.myHero = new Hero();
			Main.myHero.spawn(level);
			Main.myBoss = new Boss();
			Main.myBoss.spawn(level);
			
			heroRespawnPointLV3();
			
			bossRespawnPointLV3();
			
		}
		
		public function heroRespawnPointLV3 ():void
		{
			Main.myHero.model.x = heroPoint.x;
			Main.myHero.model.y = heroPoint.y;
		}
		
		public function bossRespawnPointLV3():void
		{
			Main.myBoss.model.x = bossPoint.x;
			Main.myBoss.model.y = bossPoint.y;
		}
		
		public function loadPlatforms():void
		{
			Main.platforms = new Array();
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_platform")
				{
					Main.platforms.push( level.getChildAt(i) );
					//level.getChildAt(i).alpha = 0;
				}
			}
		}
		public function loadBossRespawnPoint():void
		{
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_bossPoint")
				{
					bossPoint = new Point(level.getChildAt(i).x, level.getChildAt(i).y);
					level.getChildAt(i).alpha = 0;
				}
			}
		}
		
		public function loadHeroRespawnPoint():void
		{
			for(var i:int=0; i<level.numChildren; i++)
			{
				if(level.getChildAt(i).name == "mc_heroRespawnPoint")
				{
					heroPoint = new Point(level.getChildAt(i).x, level.getChildAt(i).y);
					level.getChildAt(i).alpha = 0;
				}
			}
		}
	}
}