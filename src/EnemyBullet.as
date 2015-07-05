package
{
	import flash.display.MovieClip;

	public class EnemyBullet
	{
		public var model:MC_bullet;
		public var speed:int = 3;
		public var speedX:int;
		public var spawneo:Boolean;
		
		private var actualLevel:MovieClip;
		
		public function EnemyBullet()
		{
		}
		
		public function update ():void
		{
			move();
		}
		
		private function move():void
		{
			model.y += speed;
			model.x += speedX;
		}
		public function spawn(level:MovieClip, posY:int , posX:int):void
		{
			model = new MC_bullet;
			level.addChild(model);
			actualLevel = level;
			//model.x = Main.myEnemy.model.x;
			//model.y = Main.myEnemy.model.y;
			//posY = model.y;
			//posX = model.x;
			model.y = posY ; 
			model.x = posX;
			spawneo = true;
			Main.vectorEnemyBullets.push(this);
		}
		public function destroy():void
		{
			Main.removeEnemyBulletFromVector(this)
			
			if (actualLevel.contains(model)) 
			{
				actualLevel.removeChild(model);
			}
		}
	}
}