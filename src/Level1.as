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
	}
}