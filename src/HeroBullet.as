package
{	
	public class HeroBullet
	{
		public var model:MC_bullet;
		public var speed:int = -5;
		public function HeroBullet()
		{
		}
		
		public function spawn():void
		{
			model = new MC_bullet;
			Main.mainStage.addChild(model);
			model.x = Main.myHero.model.x + 20;
			model.y = Main.myHero.model.y -20;
			Main.vectorHeroBullets.push(this);
		}
		public function destroy():void
		{
			Main.removeHeroBulletFromVector(this)
			if(Main.mainStage.contains(model))
			{
				Main.mainStage.removeChild(model);
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