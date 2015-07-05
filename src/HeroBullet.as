package
{	
	import flash.display.MovieClip;

	public class HeroBullet
	{
		public var model:MC_bullet;
		public var speed:int = -5;
		private var actualLevel:MovieClip;
		public function HeroBullet()
		{
		}
		
		public function spawn(level:MovieClip):void
		{
			model = new MC_bullet;
			actualLevel = level;
			level.addChild(model);
			model.x = Main.myHero.model.x + 20;
			model.y = Main.myHero.model.y -20;
			Main.vectorHeroBullets.push(this);
		}
		public function destroy():void
		{
			Main.removeHeroBulletFromVector(this)
			if(actualLevel.contains(model))
			{
				actualLevel.removeChild(model);
			}
		}
		public function update ():void
		{
			move ();
			
		}
		public function move ():void
		{
			model.y += speed;
		}
	}
}