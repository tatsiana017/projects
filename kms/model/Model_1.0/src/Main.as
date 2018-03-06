package 
{
	
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.events.Event3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.loaders.Parser3DS;
	import alternativa.engine3d.loaders.ParserMaterial;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Surface;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.resources.Geometry;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.types.Float;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import alternativa.engine3d.core.events.MouseEvent3D;
	import flash.events.MouseEvent;
	import alternativa.engine3d.core.events.Event3D;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import flash.events.OutputProgressEvent;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent
	import flash.ui.Keyboard;
	
	import flash.events.ProgressEvent;
 
	import flash.display.BitmapData;
    import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.geom.Vector3D;
			
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import alternativa.engine3d.primitives.GeoSphere;
	import alternativa.engine3d.primitives.Box;
	import flash.display.StageDisplayState;
	
	
	public class Main extends Sprite 
	{
		//создание переменных
		private var turnonOff:Boolean = false; //вкл/выкл
		private var contr:Boolean = false;
		
		private var scene:Object3D = new Object3D();
		
		private var bs:Object3D = new Object3D();
		
		private var camera:Camera3D; //создание камеры
		private var controller:SimpleObjectController; //сздание сцены
		private var stage3D:Stage3D;
		
		private var numvar1:Number = 1; // номер варианта
		private var numnapr1:Number = 1; // напряжение
								
				
		private var shiftX:Number=0;
		private var shiftZ:Number = 0;
		
		private var switchCamera:Boolean = false;
		private var Panelka:MovieClip; //панель
		
		private var shasha:Mesh;
		private var dvig:Mesh;
		private var girya1:Mesh;
		private var girya2:Mesh;
		private var girya3:Mesh;
		private var korobka:Mesh;
		private var line0:Mesh;
		private var line1:Mesh;
		private var line2:Mesh;
		private var line3:Mesh;
		private var linejka:Mesh;
		private var magnit:Mesh;
		private var OnOff:Mesh;
		private var room:Mesh;
		private var strela:Mesh;
		
		public static const FULLSCREEN_TRESHOLD:int = 5;	//время двойного щелчка для полноэкранного режима
		private var fullscreenTime:int = 0; //переключателль полноэкранного режима
		//переменные для манипулирования камерой
		public var cameraRadius:Number;
		public var cameraRotationX:Number;
		public var cameraRotationXOld:Number;
		private const CAMERA_Y_RANGE:Number = 25;
		private const CAMERA_X_RANGE:Number = 200;
		private const CAMERA_DISTANCE_FAR:Number = 120;
		private const CAMERA_DISTANCE_CLOSE:Number = 300;
		private const MODEL_CENTER_X:Number = 60;
		private const MODEL_CENTER_Y:Number = 60;
		
		private var mass:Number; //масса гирек
		private var napryaj:Number; //выбранное напряжение
				
		private var isStart:Boolean; //запущена ли программа
				
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
				initScene(); //метод инициализации
			//добавление листенеров на определенные действия и события 
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			stage.addEventListener(Event.RESIZE,onResize); 
							
			stage3D.requestContext3D();
		}
		
		private function onResize(e:Event):void //положение камеры
		{
			camera.view.height = stage.stageHeight;
			camera.view.width = stage.stageWidth;
			
			setPanel();
		}
		
		private function setPanel():void //положение панели при запуске
		{
			Panelka.x =-300+ camera.view.width/2-Panelka.width/2;
			Panelka.y =-200+ camera.view.height - Panelka.height / 3;
						
	}	
			
		private function detectKey(e:KeyboardEvent):void //обработчик нажатия клавиш
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				OnOff.rotationY = -15.6;
				OnOff.rotationX = 20;
			}
			
			if	(e.keyCode == Keyboard.W)
			{  
				camera.rotationX = -120 * Math.PI / 180;
			camera.rotationX = -90*Math.PI/180;
			camera.x = 70;
			camera.y = -50;
			camera.z =110;
			camera.view.hideLogo();
			controller = new SimpleObjectController(stage, camera, 200);
			controller.lookAt(new Vector3D(0, 0, 100));

			scene.addChild(camera);
				
			}else
			if	(e.keyCode == Keyboard.S)
			{  
	        camera.rotationX = -120 * Math.PI / 180;
			camera.rotationX = -90*Math.PI/180;
			camera.x = 0;
			camera.y = -140;
			camera.z = 110;
			camera.view.hideLogo();
			controller = new SimpleObjectController(stage, camera, 200);
			controller.lookAt(new Vector3D(0, 0, 100));

			scene.addChild(camera);
			
			}
			else
			if	(e.keyCode == Keyboard.A)
			{  
			if (fullscreenTime < FULLSCREEN_TRESHOLD) switchFullscreen();
	
			}
			
		}
		
		private function onMouseWheel (e:MouseEvent):void  //перемещение камеры вперед и назад
		{
			
			if (e.delta < 0){		//назад
				cameraRadius += 5;				
			}
			if (e.delta > 0){	//вперед
				cameraRadius -=5;					
			}
			
		}
		
				
		private function initScene():void //инициализация параметров
		{
			// Camera and view
			// Создание камеры и вьюпорта
					
			camera = new Camera3D(10, 1000); //обрезаение (при подходе, отходе)
			camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0, 0, 4); //ширина, высота, тектсура, цвет, прозрачность,не знаю....для области отображения в окне
			addChild(camera.view);
			addChild(camera.diagram);
			
			//создание панели и ее положение
			Panelka = new panel();
			addChild(Panelka);
			setPanel();
			Panelka.variant.value = 1;
			Panelka.numvar.text = '0';
			//добавление прослушивателей для панели
			Panelka.variant.addEventListener(Event.CHANGE, slider1); 
			Panelka.napr.addEventListener(Event.CHANGE, slider2);
			Panelka.spin.addEventListener(MouseEvent.CLICK, spin);
			Panelka.unspin.addEventListener(MouseEvent.CLICK, unspin);
			Panelka.show.addEventListener(MouseEvent.CLICK, showRezult);
			
			// Initial position
			// Установка начального положения камеры
			camera.x = 50;
			camera.y = -200;
			camera.z = 50;
			cameraRadius = CAMERA_DISTANCE_CLOSE;
			//инициализация контроллера
			controller = new SimpleObjectController(stage, camera, 200, 3, 0.7);
			controller.lookAt(new Vector3D(1,1,1));
			scene.addChild(camera);
			
			
			// Listeners
			// Подписка на события1
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
			
			//система управления камерой
			camera.view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			camera.view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			camera.view.addEventListener(MouseEvent.ROLL_OUT, onMouseUp);
			camera.view.addEventListener(MouseEvent.DOUBLE_CLICK, onFullScreen);
									
			cameraRotationZ = camera.rotationZ;	
			cameraRotationX = camera.rotationX;
			cameraRotationXOld = camera.rotationX;
						
			
			}
								
		private function onContextCreate(e:Event):void 
		{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
 
			// Загрузка модели
			// Models loading
			var loader3DS:URLLoader = new URLLoader();
			loader3DS.dataFormat = URLLoaderDataFormat.BINARY;
			// Относительный путь к модели
			loader3DS.load(new URLRequest("resources/ustanovka.3DS"));//относитальный путь к модели
			loader3DS.addEventListener(Event.COMPLETE, on3DSLoad); //complete - событие после загрузки сцены
			
			uploadResources( scene.getResources(true));
			
		}
						
		private function on3DSLoad(e:Event):void 
		{
			// Model parsing
			// Парсинг модели
			var parser:Parser3DS = new Parser3DS();
			parser.parse((e.target as URLLoader).data);
			trace(parser.objects);
			var mesh1:Mesh;
			var mesh2:Mesh;
			var mesh3:Mesh;

			//извлечение объектов из модели
			var object1:Object3D = parser.getObjectByName("chasha");
			var object2:Object3D = parser.getObjectByName("dvig");
			var object3:Object3D = parser.getObjectByName("girya1");
			var object4:Object3D = parser.getObjectByName("girya2");
			var object5:Object3D = parser.getObjectByName("girya3");
			var object6:Object3D = parser.getObjectByName("korobka");
			var object7:Object3D = parser.getObjectByName("line0");
			var object8:Object3D = parser.getObjectByName("line1");
			var object9:Object3D = parser.getObjectByName("line2");
			var object10:Object3D = parser.getObjectByName("line3");
			var object11:Object3D = parser.getObjectByName("linejka");
			var object12:Object3D = parser.getObjectByName("magnit");
			var object13:Object3D = parser.getObjectByName("OnOff");
			var object14:Object3D = parser.getObjectByName("room");
			var object15:Object3D = parser.getObjectByName("strela");
							
			addMesh(object1 as Mesh);
			addMesh(object2 as Mesh);
			addMesh(object3 as Mesh);
			addMesh(object4 as Mesh);
			addMesh(object5 as Mesh);
			addMesh(object6 as Mesh);
			addMesh(object7 as Mesh);
			addMesh(object8 as Mesh);
			addMesh(object9 as Mesh);
			addMesh(object10 as Mesh);
			addMesh(object11 as Mesh);
			addMesh(object12 as Mesh);
			addMesh(object13 as Mesh);
			addMesh(object14 as Mesh);
			addMesh(object15 as Mesh);
			
			// задание материалов объектам
			setResource(object1 as Mesh);
			setResource(object2 as Mesh);
			setResource(object3 as Mesh);
			setResource(object4 as Mesh);
			setResource(object5 as Mesh);
			setResource(object6 as Mesh);
			setResource(object7 as Mesh);
			setResource(object8 as Mesh);
			setResource(object9 as Mesh);
			setResource(object10 as Mesh);
			setResource(object11 as Mesh);
			setResource(object12 as Mesh);
			setResource(object13 as Mesh);
			setResource(object14 as Mesh);
			setResource(object15 as Mesh);
			//видимость струн			
			line1.visible = false;
			line2.visible = false;
			line3.visible = false;			
			isStart = true;
						
		}
				 
		private function addMesh(mesh:Mesh):void {
			trace(mesh.name);
			if (mesh != null)
			{
					trace(mesh.name);
				if (mesh.name == "dvig")
				dvig = mesh;
			
			else if (mesh.name == "girya1")
				girya1 = mesh;
			
			else if (mesh.name == "girya2")
				girya2 = mesh;
			
			else if (mesh.name == "girya3")
				girya3 = mesh;
			else if (mesh.name == "korobka")
				korobka = mesh;
			
			else if (mesh.name == "line0")
				line0 = mesh;
			
			else if (mesh.name == "line1")
				line1 = mesh;
			
			else if (mesh.name == "line2")
				line2 = mesh;
			
			else if (mesh.name == "line3")
				line3 = mesh;
			
			else if (mesh.name == "linejka")
				linejka = mesh;
			
			else if (mesh.name == "magnit")
				magnit = mesh;
			
			else if (mesh.name == "OnOff")
				OnOff = mesh;
			
			else if (mesh.name == "room")
				room = mesh;
			
			else if (mesh.name == "strela")
				strela = mesh;
					
					scene.addChild(mesh);
					uploadResources(mesh.getResources(false, Geometry));
			}	
		}
		//установление ресурсов объекту
		private function setResource(msh:Mesh):void {
			var textures:Vector.<ExternalTextureResource> = new Vector.<ExternalTextureResource>();
			for (var i:int = 0; i < msh.numSurfaces; i++) 
			{
				var surface:Surface = msh.getSurface(i);
				var material:ParserMaterial = surface.material as ParserMaterial;
				if (material != null) 
				{
					var diffuse:ExternalTextureResource = material.textures["diffuse"];
					if (diffuse != null) 
					{
						diffuse.url = ("resources/" + diffuse.url).replace("resources/resources/","resources/");
						textures.push(diffuse);
						surface.material = new TextureMaterial(diffuse);
					}
				}
			}
			// Loading of textures
			// Загрузка текстур
			var texturesLoader:TexturesLoader = new TexturesLoader(stage3D.context3D);
			texturesLoader.loadResources(textures);
		}
		
		private function uploadResources(resources:Vector.<Resource>):void {
			for each (var resource:Resource in resources) {
				resource.upload(stage3D.context3D);
			}
		}
					
		private function onEnterFrame(e:Event):void 
		{
						
			//движение камеры по окружности вокруг установки
			camera.x = cameraRadius * Math.cos(-Math.PI/2+camera.rotationZ) + MODEL_CENTER_X;
			camera.y = cameraRadius * Math.sin( -Math.PI / 2 + camera.rotationZ) + MODEL_CENTER_Y;
			camera.z = 70 - Math.sin((camera.rotationX - cameraRotationX)); //camera.rotationX
			
			camera.render(stage3D);
			
			
			if (switchCamera){
				var CamPos:Vector3D = bs.localToGlobal(new Vector3D(0, 500+shiftX, 200+shiftZ));
			camera.x = CamPos.x;
			camera.y = CamPos.y;
			camera.z = CamPos.z;
			CamPos = bs.localToGlobal(new Vector3D(0, -300+shiftX, -10+shiftZ));
			camera.lookAt(CamPos.x, CamPos.y, CamPos.z);
			}
			if (isStart)
			{
				getRezult();
				getGirya();
			}	
		}
		//управление камерой
		private var oldX:Number;
		private var oldY:Number;
		private var cameraRotationZ:Number;		
		
		private function spin(e:MouseEvent):void//выдвинуть панель
		{
			if(!contr)
			Panelka.x += Panelka.width-20; 
			contr = true;
		}
		private function unspin(e:MouseEvent):void//задвинуть панель
		{
			if(contr)
			Panelka.x -= Panelka.width-20; 
			contr = false;
		}
		
		private function slider1(e:Event):void//функция для первого слайдера
		{
			numvar1 = Panelka.variant.value;
			Panelka.numvar.text = numvar1; //значение слайдера присваивается label который рядом
			Panelka.dlina.text = 60 + 5 * numvar1;
			dvig.x =  152-(numvar1*52/10); 
			
			line0.scaleZ = 0.54 + (numvar1 * 0.3 / 10); //изменение длины струн
			line1.scaleZ = 0.54 + (numvar1 * 0.3 / 10);
			
			line2.scaleZ = 0.54 + (numvar1 * 0.3 / 10);
			
			line3.scaleZ = 0.54 + (numvar1 * 0.3 / 10);
			
			magnit.x = 195 + (numvar1 * (-25) / 10);			
		}
		private function slider2(e:Event):void //значение слайдера присваивается label который рядом
		{
			numnapr1 = Panelka.napr.value;
			Panelka.numnapr.text = numnapr1;
			(strela as Object3D).rotationY = (-52+(numnapr1*(104/10)))*Math.PI/180;//положение указателя на вольтметре
		}
						
		private function getRezult():void //расчет скорости распространения волн
		{
			if (Panelka.n1.selected == true)
			{
				Panelka.skorost.text = (2 * Panelka.dlina.text * numnapr1) / 1;
			}
			if (Panelka.n2.selected == true)
			{
				Panelka.skorost.text = (2 * Panelka.dlina.text * numnapr1) / 2;
			}
			if (Panelka.n3.selected == true)
			{
				Panelka.skorost.text = (2 * Panelka.dlina.text * numnapr1) / 3;
			}
		}
		
		private function getGirya():void //если выбрана гиря, убрать ее сподставки
		{
			if (Panelka.girya1.selected == true)
			{
				Panelka.massa.text = 200;
				mass = 200;
				girya1.visible = false;
								
			}
			else if (Panelka.girya1.selected == false)
			{
				girya1.visible = true; 
			}
			if (Panelka.girya2.selected == true)
			{
				Panelka.massa.text = 300;
				mass = 300;
				girya2.visible = false;
			}
			else if (Panelka.girya2.selected == false) 
			{
				girya2.visible = true;
			}
			if (Panelka.girya3.selected == true)
			{
				Panelka.massa.text = 400;
				mass = 400;
				girya3.visible = false;
			}
			else if (Panelka.girya3.selected == false)
			{
				girya3.visible = true;
			}
			if (Panelka.girya1.selected == true&&Panelka.girya3.selected == true)
			{
				Panelka.massa.text = 500;
				mass = 500;
				girya1.visible = false;
				girya3.visible = false;
			}
			if (Panelka.girya2.selected == true&&Panelka.girya3.selected == true)
			{
				Panelka.massa.text = 600;
				mass = 600;
				girya2.visible = false;
				girya3.visible = false;
			}
			if (Panelka.girya1.selected == true&&Panelka.girya2.selected == true&&Panelka.girya3.selected == true)
			{
				Panelka.massa.text = 700;
				mass = 700;
				girya1.visible = false;
				girya2.visible = false;
				girya3.visible = false;
			}
		}
		
		private function showRezult(e:MouseEvent):void //показать  на струне колебания 
		{
			line0.visible = false;
			
			if (mass == 200)
			{
				if (numnapr1 == 0)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 1 || numnapr1 == 2)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 3 || numnapr1 == 4)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}
			
			if (mass == 300)
			{
				if (numnapr1 == 0)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 1 || numnapr1 == 2 ||numnapr1 == 3)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 4 || numnapr1 == 5 || numnapr1 == 6)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}
			
			if (mass == 400)
			{
				if (numnapr1 == 0 ||numnapr1 == 1)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 2 ||numnapr1 == 3)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 4 || numnapr1 == 5)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}	
			
			if (mass == 500)
			{
				if (numnapr1 == 0 || numnapr1==1)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 2 || numnapr1 == 3 ||numnapr1 == 4)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 5 || numnapr1 == 6 || numnapr1 == 7)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}
			
			if (mass == 600)
			{
				if (numnapr1 == 0 || numnapr1 == 1 || numnapr1 == 2)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 3 ||numnapr1 == 4)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 5 || numnapr1 == 6)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}
			
			if (mass == 700)
			{
				if (numnapr1 == 0 || numnapr1 == 1 || numnapr1 == 2 || numnapr1 == 3 || numnapr1 == 4)
				{
					line0.visible = true;
					line1.visible = false;
					line2.visible = false;
					line3.visible = false;
				}
				else if (numnapr1 == 5 || numnapr1 == 6)
				{
					line1.visible = true;
					line2.visible = false;
					line3.visible = false;
					
				}
				else if (numnapr1 == 7 || numnapr1 == 8)
				{
					line2.visible = true;
					line1.visible = false;
					line3.visible = false;
				}
				else 
				{
					line3.visible = true;
					line2.visible = false;
					line1.visible = false;
				}
			}
		}
					
		private function onMouseDown(e:MouseEvent):void {
			oldX = camera.view.mouseX;
			oldY = camera.view.mouseY;
			camera.view.addEventListener(Event.ENTER_FRAME, onCameraMove);
			fullscreenTime = 0;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			camera.view.removeEventListener(Event.ENTER_FRAME, onCameraMove);
			cameraRotationZ = camera.rotationZ;
			cameraRotationXOld = camera.rotationX;
		}
		
		private function onCameraMove(e:Event):void {
			fullscreenTime++;
						
			camera.rotationZ = cameraRotationZ + Math.PI / 2 * (camera.view.mouseX - oldX) / CAMERA_X_RANGE;	
			camera.rotationX = cameraRotationXOld + (camera.view.mouseY - oldY) / CAMERA_Y_RANGE / 20;
			
			if (camera.rotationX - cameraRotationX > CAMERA_Y_RANGE*Math.PI/180) camera.rotationX = cameraRotationX + CAMERA_Y_RANGE*Math.PI/180;
			if (camera.rotationX - cameraRotationX < -1.8*CAMERA_Y_RANGE*Math.PI/180) camera.rotationX = cameraRotationX - 1.8*CAMERA_Y_RANGE*Math.PI/180;
		}
		//Обработчики полноэкранного режима
		private function onFullScreen(e:MouseEvent):void {
			if (fullscreenTime < FULLSCREEN_TRESHOLD) switchFullscreen();
		}
		
		private function switchFullscreen():void {
			if (stage.displayState == StageDisplayState.NORMAL) 
			{
				stage.displayState=StageDisplayState.FULL_SCREEN;
	    	} else {
	        	stage.displayState=StageDisplayState.NORMAL;
	    	}
		}
	

	}
}