package
{
	import com.senocular.utils.KeyObject;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
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
		public static var myLevel1:Level1;
		public static var myLevel2:Level2;
		public static var myLevel3:Level3;
		public static var myBullet:HeroBullet;
		public static var myBoss:Boss;
		
		public static var myEnemyBullet:EnemyBullet;
		
		public static var bulletsLeft:int;
		
		public static var platforms:Array = new Array ();
		public static var enemysRespawnPoints:Array = new Array ();
		
		public var timeToShoot:Number = 1.5;
		private var shootTimer:Number = 0;
		private var canShoot:Boolean = false;
		public  static var gameIsPaused:Boolean = false;
		private var pauseMC:MovieClip;
		
		public static var texto:TextField = new TextField();
		public static var formato:TextFormat = new TextFormat();
		
		public static var endGame:Boolean = false;
		
		public static var myMenu:MC_menu;
		public var myCreditos:MC_creditos;
		public var myHowToPlay:MC_hoyToPlay;
		
		public static var myLoose:MC_loose;
		
		public static var myWin:MC_win;
		
		public static var cam:camera2d;
		
		public static var actualLevel:int;
		
		public static var dificulty:int = 1;
		
		public function Main()
		{
			mainStage = stage;
			
			createMenu();
		
			myMenu.mc_credits.addEventListener(MouseEvent.CLICK, clickOnCredits);
			myMenu.mc_howToPlay.addEventListener(MouseEvent.CLICK, clickOnHowToPlay);
			myMenu.mc_start.addEventListener(MouseEvent.CLICK, clickOnStart);
			mainStage.addEventListener(KeyboardEvent.KEY_UP, restartKey);
			
			
		}
		
		protected function restartKey(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.R:
					if (endGame)
					{
						if(myLoose != null)
						{
							removeLoose();
						}
						else if(myWin != null)
						{
							removeWin();
						}
						myMenu.visible = true;
						//endGame = false;
					}
					if (!endGame && !gameIsPaused && myMenu.visible != true)
					{
						restart();
					}
					break;
				case Keyboard.D:
					if(myMenu.visible)
					{	
						if(dificulty > 0 && dificulty < 4)
						{
							dificulty++;
							if(dificulty >= 4)
							{
								dificulty = 1;
							}
						}
					}
					trace (dificulty)
					break;
			}
		}
		
		public function dificultyOnStage():void
		{
			formato.font = "Comic Sans MS";
			formato.size = 30;
			formato.color = 0xFFFFFF;
			formato.align = TextFormatAlign.CENTER;
			texto.width = 300;
			texto.x = mainStage.stageWidth -  texto.width + 40;
			texto.y = mainStage.stageHeight - texto.height/2;
			texto.text = "Dificultad:" + dificulty;
			texto.setTextFormat(formato)
			mainStage.addChild(texto);
			
			/*if(myMenu.visible == true)
			{
				texto.visible == true;
			}
			else if(myMenu.visible == false)
			{
				texto.visible == false;
			}*/
		}
		
		public function restart():void
		{
			if(actualLevel == 1)
			{
				cam.removeToView(myLevel1.level);
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel1.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				endGame = true;
				myMenu.visible = true;
			}
			
			else if (actualLevel == 2)
			{
				cam.removeToView(myLevel2.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel2.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				myMenu.visible = true;
			}
			
			else if (actualLevel == 3)
			{
				cam.removeToView(myLevel2.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel2.level);
				}
				
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				myMenu.visible = true;
			}
			mainStage.removeChild(myHero.texto)
		}
		public function createMenu():void
		{
			myMenu = new MC_menu;
			mainStage.addChild(myMenu);
			myMenu.x = mainStage.width / 2 - 150;
			myMenu.y = mainStage.height / 2 - 100;
			//dificultyOnStage();
			myMenu.visible = true;
		}
		
		protected function clickOnCreditsGoBack(event:MouseEvent):void
		{
			mainStage.removeChild(myCreditos);
			//createMenu();
			myMenu.visible = true;
			
		}
		
		protected function clickOnStart(event:MouseEvent):void
		{
			loadLVL1();
			endGame = false;
			gameIsPaused = false;
			myMenu.visible = false;
			
		}
		
		protected function clickOnHowToPlay(event:MouseEvent):void
		{
			myHowToPlay = new MC_hoyToPlay;
			//mainStage.removeChild(myMenu);
			myMenu.visible = false;
			mainStage.addChild(myHowToPlay);
			myHowToPlay.x = mainStage.width / 2 - 300;
			myHowToPlay.y = mainStage.height / 2 - 100;
			myHowToPlay.mc_goBack.addEventListener(MouseEvent.CLICK, clickOnHowToPlayGoBack);
		}
		
		protected function clickOnHowToPlayGoBack(event:MouseEvent):void
		{
			mainStage.removeChild(myHowToPlay);
			//createMenu();
			myMenu.visible = true;
		}
		
		protected function clickOnCredits(event:MouseEvent):void
		{
			myCreditos = new MC_creditos;
			//mainStage.removeChild(myMenu);
			myMenu.visible = false;
			mainStage.addChild(myCreditos);
			myCreditos.x = mainStage.width / 2 - 400;
			myCreditos.y = mainStage.height / 2 - 200;
			myCreditos.mc_goBack.addEventListener(MouseEvent.CLICK, clickOnCreditsGoBack);
		}
		
		public function loadLVL1():void
		{
			actualLevel = 1;
			cam = new camera2d();
			cam.on();
			myLevel1 = new Level1 ();
			myLevel1.spawn();
			cam.addToView(myLevel1.level);
			
			respawnPauseButton();
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		public function loadLVL2():void
		{
			actualLevel = 2;
			myLevel2 = new Level2 ();
			myLevel2.spawn();
			cam.addToView(myLevel2.level);
		}
		
		public function colisionHeroLevel1End():void
		{
			if(myHero.model.hitTestObject(myLevel1.level.mc_levelEnd))
			{
				cam.removeToView(myLevel1.level);
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel1.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				loadLVL2();
				
			}
		}
		
		public function colisionHeroLevel2End():void
		{
			if(myHero.model.hitTestObject(myLevel2.level.mc_levelEnd))
			{
				cam.removeToView(myLevel2.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel2.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				loadLVL3();
			}
		}
		
		public function loadLVL3():void
		{
			actualLevel = 3;
			myLevel3 = new Level3 ();
			myLevel3.spawn();
			cam.addToView(myLevel3.level);
		}
		
		public function createPauseButton():MovieClip
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
		public function removePauseButton(): void
		{
			
		}
	
		public function respawnPauseButton():void
		{
			pauseMC = createPauseButton();
			
			mainStage.addChild(pauseMC);
			pauseMC.x = stage.width - 770;
			pauseMC.y = 25;
			
			pauseMC.addEventListener(MouseEvent.CLICK, clickOnPause);
		}
		
		//public function removePauseButton():void
		//{
			
		//}
		
		
		public static function spawnMCLoose():void
		{
			myLoose = new MC_loose;
			mainStage.addChild(myLoose);
			myLoose.x = mainStage.width / 2 - myLoose.width/2 + 250;
			myLoose.y = mainStage.height / 2 - myLoose.height/2 + 50;
			myLoose.scaleX = 0.9;
		}
		
		public static function removeLoose():void
		{
			if (mainStage.contains(myLoose)){
				mainStage.removeChild(myLoose);
			}
		}
		public static function loose():void
		{
			if(actualLevel == 1)
			{
				cam.removeToView(myLevel1.level);
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel1.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				//myMenu.visible = true;
			}
				
			else if (actualLevel == 2)
			{
				cam.removeToView(myLevel2.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel2.level);
				}
				vectorEnemys = new Vector.<Enemy>;
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				//myMenu.visible = true;
			}
				
			else if (actualLevel == 3)
			{
				cam.removeToView(myLevel3.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel3.level);
				}
				
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				//myMenu.visible = true;
			}
			
			
			spawnMCLoose();
			
			endGame = true;
		}
		
		public static function spawnMCWin():void
		{
			myWin = new MC_win;
			mainStage.addChild(myWin);
			myWin.x = mainStage.width / 2 - myWin.width/2 + 310;
			myWin.y = mainStage.height / 2 - myWin.height/2 - 300;
			//myWin.scaleX = 0.9;
		}
		
		public static function removeWin():void
		{
			if (mainStage.contains(myWin)){
				mainStage.removeChild(myWin);
			}
		}
		
		public static function win():void
		{
			if (actualLevel == 3)
			{
				cam.removeToView(myLevel3.level)
				if(mainStage.contains(myLevel1.level))
				{
					mainStage.removeChild(myLevel3.level);
				}
				
				vectorEnemyBullets = new Vector.<EnemyBullet>;
				vectorHeroBullets = new Vector.<HeroBullet>;
				
				//myMenu.visible = true;
			}
			spawnMCWin();
			
			endGame = true;
		}
		
		public function clickOnPause (event:MouseEvent):void
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
				myBullet.spawn(myHero.actualLevel);
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
		
		public static function removeEnemyFromVector (obj:Enemy):void
		{
			var i:int = vectorEnemys.indexOf(obj);
			vectorEnemys.splice(i, 1);
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
		
		public function colisionHeroBoss():void
		{
				if(myHero.model.hitTestObject(myBoss.model))
				{
					myHero.looseLife();
				}
		}
		
		public function colisionHeroBulletsEnemy():void
		{
			for(var j:int =0 ; j < vectorHeroBullets.length; j++)
			{
				for (var i:int =0 ; i < vectorEnemys.length; i++) 
				{
					if(vectorHeroBullets[j] != null && vectorHeroBullets[j].model.hitTestObject(vectorEnemys[i].model))
					{
						vectorHeroBullets[j].destroy();
						vectorEnemys[i].destroy();
						break;
					}
				}
			}
		}
		
		public function colisionHeroBulletsBoss():void
		{
			for(var j:int =0 ; j < vectorHeroBullets.length; j++)
			{
				if(vectorHeroBullets[j] != null && vectorHeroBullets[j].model.hitTestObject(myBoss.model))
				{
					vectorHeroBullets[j].destroy();
					myBoss.destroy();
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
		
		public function colisionBossPlatform():void
		{
			for (var i:int =0 ; i < platforms.length; i++) 
			{
				if(myBoss.model.mc_checkRight.hitTestObject(platforms[i]))
				{
					myBoss.direction = -1;
				}
				else if(myBoss.model.mc_checkLeft.hitTestObject(platforms[i]))
				{
					myBoss.direction = 1;
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
				if(myEnemy != null)
				{
					myEnemy.update();
				}
				colisionEnemyPlatform();
				colisionHeroEnemy();
				colisionHeroBulletsEnemy();
				heroShootTimer();
				colisionHeroBulletPlatform();
				//lifeInStage();
				colisionEnemyBulletPlatform();
				colisionEnemyBulletHero();
				if(actualLevel == 1)
				{
					colisionHeroLevel1End();
				}
				if(actualLevel == 2)
				{
					colisionHeroLevel2End();
				}
				if(actualLevel == 3)
				{
					myBoss.update();
					colisionBossPlatform();
					colisionHeroBulletsBoss();
					colisionHeroBoss();
				}
				cam.lookAt(myHero.model);				
				
				for (var l:int =0 ; l < vectorHeroBullets.length; l++) 
				{
					if (vectorHeroBullets[l] !=null)
					{
						vectorHeroBullets[l].update();
					}				
				}			
			}
		
			if(myMenu.visible)
			{
				dificultyOnStage();
			}
				
			if (key.isDown(key.DOWN))
			{
				myHero.moveY(1)
			}
			if(key.isDown(key.UP))
			{
				myHero.moveY(-1)
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
				if (!gameIsPaused && !endGame)
				{
					respawnBullet();
				}
			}
		}
	}
}