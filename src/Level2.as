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