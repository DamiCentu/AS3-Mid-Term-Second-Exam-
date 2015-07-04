package
{
	public class EnemyBullet
	{
		public var model:MC_bullet;
		public var speed:int = 2;
		public var spawneo:Boolean;
		
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
		}
		public function spawn():void
		{
			model = new MC_bullet;
			Main.mainStage.addChild(model);
			model.x = Main.myEnemy.model.x;
			model.y = Main.myEnemy.model.y;
			spawneo = true;
			Main.vectorEnemyBullets.push(this);
		}
		public function destroy():void
		{
			Main.removeEnemyBulletFromVector(this)
			
			if (Main.mainStage.contains(model)) 
			{
				Main.mainStage.removeChild(model);
			}
		}
	}
}