package
{
	import com.senocular.utils.KeyObject;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	[SWF(width="1024", height="768", frameRate="60")]
	
	public class Main extends Sprite
	{
		public var key:KeyObject = new KeyObject(stage);
		
		public static var mainStage:Stage;
		
		public var isKeyLeft:Boolean;
		public var isKeyRight:Boolean;
		public var isKeyUp:Boolean;
		public var isKeyDown:Boolean;
		public static var isKeyShoot:Boolean;
		
		public static var vectorHeroBullets:Vector.<HeroBullet> = new Vector.<HeroBullet>();
		public static var vectorEnemys:Vector.<Enemy> = new Vector.<Enemy>();
		public static var vectorEnemyBullets:Vector.<EnemyBullet> = new Vector.<EnemyBullet>();
		
		public static var myHero:Hero;
		public static var myEnemy:Enemy;
		public var myLevel1:Level1;
		public static var myBullet:HeroBullet;
		
		public static var myEnemyBullet:EnemyBullet;
		
		public static var bulletsLeft:int;
		
		public static var platforms:Array = new Array ();
		
		public var timeToShoot:Number = 1.5;
		private var shootTimer:Number = 0;
		private var canShoot:Boolean = false;
		public var gameIsPaused:Boolean = false;
		private var pauseMC:MovieClip;
		
		public static var texto:TextField = new TextField();
		public static var formato:TextFormat = new TextFormat();
		
		public static var endGame:Boolean = false;
		
		//public var cam:camera2d;
		//public var level1mc:MovieClip;
		
		public function Main()
		{
			mainStage = stage;
			
			//	cam = new camera2d();
			//cam.on();
			
			myLevel1 = new Level1 ();
			myLevel1.spawn();
			//level1mc = myLevel1.level;
			//cam.addToView(level1mc);
			//cam.addToView(Level1);
			
			myHero = new Hero();
			myHero.spawn();
			
			for(var i:int = 0 ; i < 2; i++)
			{
				
				myEnemy = new Enemy();
				myEnemy.spawn();
				if(i == 0)
				{
					myEnemy.model.x = 300;
					myEnemy.model.y = 500;
				}
				if(i == 1)
				{
					myEnemy.model.x = 600;
					myEnemy.model.y = 300;
				}
			}
			
			pauseMC = createPauseButton();
			
			mainStage.addChild(pauseMC);
			pauseMC.x = stage.width - 300;
			pauseMC.y = 20;
			
			pauseMC.addEventListener(MouseEvent.CLICK, clickOnPause);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function createPauseButton():MovieClip
		{
			var mc:MovieClip = new MovieClip();
			
			var clickArea:Shape = new Shape;
			clickArea.graphics.beginFill(0xFF0000, 0);
			clickArea.graphics.drawRect(-16, -10, 38,40);
			clickArea.graphics.endFill();
			mc.addChild(clickArea);			
			
			var rectangle:Shape = new Shape;
			rectangle.graphics.beginFill(0xFFFFFF);
			rectangle.graphics.drawRect(-6, 0, 6,20);
			rectangle.graphics.endFill();
			mc.addChild(rectangle); 
			
			var rectangle2:Shape = new Shape; 
			rectangle2.graphics.beginFill(0xFFFFFF);
			rectangle2.graphics.drawRect(6, 0, 6,20);
			rectangle2.graphics.endFill();
			mc.addChild(rectangle2);
			
			return mc;
		}
		
		public function lifeInStage():void
		{
			formato.font = "Comic Sans MS";
			formato.size = 30;
			formato.color = 0xFFFFFF;
			formato.align = TextFormatAlign.CENTER;
			texto.width = 300;
			texto.x = -75;
			texto.y = mainStage.stageHeight - texto.height/2;
			texto.text = "Vidas: " + myHero.lifes;
			texto.setTextFormat(formato)
			mainStage.addChild(texto);
		}
		
		public static function loose():void
		{
			formato.font = "Comic Sans MS";
			formato.size = 30;
			formato.color = 0xFFFFFF;
			formato.align = TextFormatAlign.CENTER;
			texto.width = 300;
			texto.x = mainStage.stageWidth / 2 - texto.width / 2;
			texto.y = mainStage.stageHeight / 2 - texto.height / 2;
			texto.text = "PERDISTE NIERI"
			texto.setTextFormat(formato)
			mainStage.addChild(texto);
			
			endGame = true;
		}
		
		private function clickOnPause (event:MouseEvent):void
		{
			if(gameIsPaused)
			{
				gameIsPaused = false;
			} 
			else 
			{
				gameIsPaused = true;
			}
		}
		
		public function respawnBullet ():void
		{
			if (canShoot)
			{
				canShoot = false;
				shootTimer = 0;
				myBullet = new HeroBullet();
				myBullet.spawn();
			}
		}
		
		public static function removeHeroBulletFromVector(obj:HeroBullet):void
		{
			var i:int = vectorHeroBullets.indexOf(obj);
			vectorHeroBullets.splice(i, 1);
		}
		
		public static function removeEnemyBulletFromVector(obj:EnemyBullet):void
		{
			var i:int = vectorEnemyBullets.indexOf(obj);
			vectorEnemyBullets.splice(i, 1);
		}
		
		public function colisionHeroBulletPlatform():void
		{
			for (var i:int =0 ; i < platforms.length; i++) 
			{
				for (var j:int =0 ; j < vectorHeroBullets.length; j++) 
				{
					if(vectorHeroBullets[j] != null && vectorHeroBullets[j].model.hitTestObject(platforms[i]))
					{
						vectorHeroBullets[j].destroy();
					}
				}
			}
		}
		
		public function colisionEnemyBulletPlatform():void
		{
			for (var i:int =0 ; i < platforms.length; i++) 
			{
				for (var j:int =0 ; j < vectorEnemyBullets.length; j++) 
				{
					if(vectorEnemyBullets[j] != null && vectorEnemyBullets[j].model.hitTestObject(platforms[i]))
					{
						vectorEnemyBullets[j].destroy();
					}
				}
			}
		}
		
		public function colisionEnemyBulletHero():void
		{
			for (var j:int =0 ; j < vectorEnemyBullets.length; j++) 
			{
				if(vectorEnemyBullets[j] != null && vectorEnemyBullets[j].model.hitTestObject(myHero.model))
				{
					myHero.looseLife();
					vectorEnemyBullets[j].destroy();
				}
			}
		}
		
		public function colisionHeroPlatform():void
		{
			for (var i:int =0 ; i < platforms.length; i++) 
			{
				if(myHero.model.mc_checkRight.hitTestObject(platforms[i]) || myHero.model.mc_checkLeft.hitTestObject(platforms[i])|| myHero.model.mc_checkTop.hitTestObject(platforms[i])|| myHero.model.mc_checkBack.hitTestObject(platforms[i]))
				{
					myHero.looseLife();
				}
			}
		}
		
		public function colisionHeroEnemy():void
		{
			for (var j:int =0 ; j < vectorEnemys.length; j++) 
			{
				if(myHero.model.hitTestObject(vectorEnemys[j].model))
				{
					myHero.looseLife();
				}
			}
		}
		
		public function colisionBulletsEnemy():void
		{
			for(var j:int =0 ; j < vectorHeroBullets.length; j++)
			{
				if(vectorHeroBullets[j] != null && vectorHeroBullets[j].model.hitTestObject(myEnemy.model))
				{
					vectorHeroBullets[j].destroy();
					myEnemy.destroy();
				}
			}
		}
		
		public function colisionEnemyPlatform():void
		{
			for (var i:int =0 ; i < platforms.length; i++) 
			{
				for (var j:int =0 ; j < vectorEnemys.length; j++) 
				{
					if(vectorEnemys[j].model.mc_checkRight.hitTestObject(platforms[i]))
					{
						vectorEnemys[j].direction = -1;
					}
					else if(vectorEnemys[j].model.mc_checkLeft.hitTestObject(platforms[i]))
					{
						vectorEnemys[j].direction = 1;
					}
				}
			}
		}
		private function heroShootTimer():void
		{
			shootTimer += Main.mainStage.frameRate / 1000;
			if (shootTimer > timeToShoot)
			{
				canShoot = true;
			}
		}
		
		
		protected function update(event:Event):void
		{
			if (!gameIsPaused && !endGame) 
			{
				myHero.update();
				colisionHeroPlatform();
				myEnemy.update();
				colisionEnemyPlatform();
				colisionHeroEnemy();
				colisionBulletsEnemy();
				heroShootTimer();
				colisionHeroBulletPlatform();
				lifeInStage();
				colisionEnemyBulletPlatform();
				colisionEnemyBulletHero();
				//cam.lookAt(myHero.model);				
				
				for (var l:int =0 ; l < vectorHeroBullets.length; l++) 
				{
					if (vectorHeroBullets[l] !=null)
					{
						vectorHeroBullets[l].update();
					}				
				}			
			}
			
			if (key.isDown(key.DOWN))
			{
				myHero.moveY(1)
			}
			if(key.isDown(key.UP))
			{
				myHero.moveY(-1)
				//myLevel1.level.y += 4;
			}
			if(key.isDown(key.RIGHT))
			{
				myHero.moveX(1)
			}
			if(key.isDown(key.LEFT))
			{
				myHero.moveX(-1)
			}			
			if(key.isDown(key.SPACE))
			{
				respawnBullet();
			}
			
		}
	}
}