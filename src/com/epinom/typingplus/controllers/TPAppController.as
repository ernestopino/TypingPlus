package com.epinom.typingplus.controllers
{
	import com.digitalsurgeons.loading.BulkLoader;
	import com.digitalsurgeons.loading.BulkProgressEvent;
	import com.epinom.typingplus.models.TPDataModel;
	import com.epinom.typingplus.objects.TPInterfaceObject;
	import com.epinom.typingplus.utils.TPXMLParser;
	import com.epinom.typingplus.views.TPComponent;
	import com.epinom.typingplus.vos.TPComponentVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.system.System;
	import flash.utils.getDefinitionByName;

	public class TPAppController extends MovieClip
	{
		/**
		 * @property
		 * Objeto responsable de cargas multiples de ficheros externos
		 */
		private var bulkLoader:BulkLoader;
		
		/**
		 * @property
		 * Objeto contenedor de variables externas enviadas desde el HTML/PHP
		 */
		private var flashvars:Object;
		
		/**
		 * @property
		 * Variables para comunicacion entre AS3 y Javascript en un entorno Facebook
		 */
		private var connection:LocalConnection; 
		private var connectionName:String;
		
		/**
		 * @property
		 * Referencia al swf "main.swf"
		 */
		private var mainMovieClip:MovieClip;
		private var mainLoader:Loader;
		
		/**
		 * @property
		 * Datos del usuario de Facebook
		 */
		private var fbUserToken:String;
		private var fbUserName:String;
		private var fbUrlUserImage:String;
		private var fbUserImage:Bitmap;
		
		/**
		 * @property
		 * Variables que se utilizaran como referencias de objetos visuales
		 */						
		private var typingPlusVisualLoader:MovieClip;	
		private var typingPlusVisualLoader_io:TPInterfaceObject;
		
		public function TPAppController()
		{
			super();
			trace("TPAppController->TPAppController()");
			
			// Declarando metodos para ser ejecutados desde JavaScript
			if (ExternalInterface.available) 
			{
				try {
					debug("Flash: Adding callback...");
					ExternalInterface.addCallback("sendToActionScript", FBloggedIn);
					if (checkJavaScriptReady()) {
						debug("Flash: JavaScript is ready.");
					} else {
						debug("Flash: JavaScript is not ready.");
					}
				} catch (error:SecurityError) {
					debug("Flash: A SecurityError occurred: " + error.message);
				} catch (error:Error) {
					debug("Flash: An Error occurred: " + error.message);
				}
			} else {
				debug("Flash: External interface is not available for this container.");
			}
			
			// Sistema de codificacion
			System.useCodePage = true;
			
			// Actualizando la referencia al escenario de la pelicula principal
			TPDataModel.getInstance().stage = stage;
			
			// Inicializando Controlador de Escencario
			TPStageController.getInstance();
			
			// Configurando seguridad de la aplicacion
			if(!TPDataModel.APP_RUN_IN_LOCAL)
			{
				Security.allowInsecureDomain("*");
				Security.allowDomain("*");
				Security.allowDomain(TPDataModel.URL_BASE_DOMAIN + "app.swf");
				Security.allowDomain(TPDataModel.URL_BASE_DOMAIN + "main.swf");
				Security.loadPolicyFile(TPDataModel.URL_BASE_DOMAIN + "crossdomain.xml");
			}
			
			// Inicializando propiedades
			flashvars = null;	
			
			// Inicializando aplicacion
			init();
		}
		
		public static function debug(text:Object):void {
			trace(text.toString());
			if(ExternalInterface.available)
				ExternalInterface.call("console.log", text.toString());
		}
		
		private function checkJavaScriptReady():Boolean {
			var isReady:Boolean = ExternalInterface.call("isReady");
			return isReady;
		}
		
		private function FBloggedIn(token:String):void {
			debug("TPAppController->FBloggedIn()");
			debug("Flash: token=" + token);	
		}
		
		/**
		 * @method
		 * Inicializa la apicacion
		 */
		private function init():void
		{
			trace("TPAppController->init()");
			
			// Iniciando carga de elementos externos
			bulkLoader = new BulkLoader(TPDataModel.APP_BULKLOADER_NAME);
			bulkLoader.logLevel = BulkLoader.LOG_INFO;
			
			// Estableciendo URL del fichero de configuracion
			if(TPDataModel.APP_RUN_IN_LOCAL)
				TPDataModel.getInstance().settings.settingsXMLLocation = TPDataModel.XML_SETTINGS_FILE;
			else
				TPDataModel.getInstance().settings.settingsXMLLocation = TPDataModel.URL_BASE_DOMAIN + TPDataModel.XML_SETTINGS_FILE;
			
			// Configurando detectores de eventos
			this.loaderInfo.addEventListener(Event.COMPLETE, onAppSWFLoaderComplete);	
		}
		
		/**
		 * @event
		 * Ejecuta acciones una vez terminada de cargarse la pelicula principal "app.swf"
		 */
		private function onAppSWFLoaderComplete(evt:Event):void 
		{	
			trace("TPAppController->onLoaderComplete()");
			
			// Obteniendo flashvars
			flashvars = (this.root.loaderInfo as LoaderInfo).parameters;
			
			// Pasando flashvars al modelo de datos					
			if(flashvars.APIKey != null) {
				TPDataModel.getInstance().flashvars = flashvars;
			}
			
			// Creando objeto de datos referente al loader visual
			var typingPlusVisualLoaderVO:TPComponentVO = new TPComponentVO();
			typingPlusVisualLoaderVO.type = "MovieClip";
			typingPlusVisualLoaderVO.className = "TPVisualLoader";
			typingPlusVisualLoaderVO.instanceName = "typingPlusVisualLoader";
			typingPlusVisualLoaderVO.visible = true;
			typingPlusVisualLoaderVO.hashId = "typingPlusVisualLoader";
			typingPlusVisualLoaderVO.url = "";
			typingPlusVisualLoaderVO.changeSize = false;
			typingPlusVisualLoaderVO.percentageWidth = -1;
			typingPlusVisualLoaderVO.percentageHeight = -1;
			typingPlusVisualLoaderVO.changePositionX = true;
			typingPlusVisualLoaderVO.changePositionY = true;
			typingPlusVisualLoaderVO.percentageX = 50;
			typingPlusVisualLoaderVO.percentageY = 50;
			typingPlusVisualLoaderVO.centralReference = false;
			typingPlusVisualLoaderVO.elementOrder = -1;
			typingPlusVisualLoaderVO.yPosition = -1;
			typingPlusVisualLoaderVO.percentagePadding = false;
			typingPlusVisualLoaderVO.paddingTop = -1;
			typingPlusVisualLoaderVO.paddingBottom = -1;
			typingPlusVisualLoaderVO.paddingLeft = -1;
			typingPlusVisualLoaderVO.paddingRight = -1;
			
			
			// Creando un objeto de tipo Class para luego crear objetos del tipo del className cargado por xml
			var TPVisualLoader:Class = getDefinitionByName(typingPlusVisualLoaderVO.className) as Class;
			
			// Creando objeto de tipo BtobLoader
			vetustaVisualLoader = new TPVisualLoader();
			vetustaVisualLoader.name = typingPlusVisualLoaderVO.instanceName;
			
			// Creo un objeto de tipo InterfaceObject
			typingPlusVisualLoader_io = new TPInterfaceObject(vetustaVisualLoader,
				typingPlusVisualLoaderVO.className,
				typingPlusVisualLoaderVO.instanceName,
				typingPlusVisualLoaderVO.hashId,
				typingPlusVisualLoaderVO.changeSize,
				typingPlusVisualLoaderVO.percentageWidth,
				typingPlusVisualLoaderVO.percentageHeight,
				typingPlusVisualLoaderVO.changePositionX,
				typingPlusVisualLoaderVO.changePositionY,
				typingPlusVisualLoaderVO.percentageX,
				typingPlusVisualLoaderVO.percentageY);	
			
			// Agregando objeto al escenario
			TPStageController.getInstance().addObject(typingPlusVisualLoaderVO.hashId, typingPlusVisualLoader_io, typingPlusVisualLoaderVO.visible);
			
			// Actualizando modelo de datos
			var typingPlusVisualLoaderComponent:TPComponent = new TPComponent(typingPlusVisualLoaderVO, typingPlusVisualLoader_io, typingPlusVisualLoader);
			TPDataModel.getInstance().componentList.push(typingPlusVisualLoaderComponent);
			
			// Configurando la carga multiple de los elementos necesario para construir la interfaz
			
			// Peticion de carga de XML de configuracion de la aplicacion y la configuracion de todos los componentes para la Diagramacion Liquida
			bulkLoader.add(new URLRequest(TPDataModel.getInstance().settings.settingsXMLLocation), { id:TPDataModel.getInstance().settings.settingsXMLLocation });
			
			// Peticion de carga de SWF externo que contiene todos los componentes (movieclips) en la biblioteca para la interfaz
			if(TPDataModel.APP_RUN_IN_LOCAL) bulkLoader.add(new URLRequest(TPDataModel.MAIN_SWF_FILE), { id:TPDataModel.MAIN_SWF_FILE });
			else bulkLoader.add(new URLRequest(TPDataModel.URL_BASE_DOMAIN + TPDataModel.MAIN_SWF_FILE), { id:TPDataModel.URL_BASE_DOMAIN + TPDataModel.MAIN_SWF_FILE });
			
			// Configurando manejadores de eventos independientes para cada elemento
			bulkLoader.get(TPDataModel.getInstance().settings.settingsXMLLocation).addEventListener(Event.COMPLETE, onXMLSettingsLoaded);
			bulkLoader.get(TPDataModel.URL_BASE_DOMAIN + TPDataModel.MAIN_SWF_FILE).addEventListener(Event.COMPLETE, onSWFMainLoaded);
			
			// Configurando manejadores de eventos globales para todos elementos
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onBulkElementLoadedHandler);
			bulkLoader.addEventListener(BulkLoader.PROGRESS, onBulkElementProgressHandler);
			bulkLoader.addEventListener(BulkLoader.ERROR, onErrorHandler);
			
			// Iniciando carga multiple
			bulkLoader.start();
		}
		
		/**
		 * @event
		 * Ejecuta acciones una vez terminada la descarga del fichero XML de configuracion
		 */
		public function onXMLSettingsLoaded(evt:Event):void 
		{
			trace("TPAppController->onXMLSettingsLoaded()");
			
			// Desactivando detectores de eventos
			bulkLoader.get(TPDataModel.getInstance().settings.settingsXMLLocation).removeEventListener(Event.COMPLETE, onXMLSettingsLoaded);
			
			// Obteniendo XML
			var xmlSettings:XML = bulkLoader.getXML(TPDataModel.getInstance().settings.settingsXMLLocation);
			debug(xmlSettings);
			
			// Parseando fichero XML de configuracion
			TPDataModel.getInstance().settings = TPXMLParser.parseSettingsXML(xmlSettings, TPDataModel.getInstance().settings);
			
			// Configurando StageManage
			TPStageController.getInstance().config(TPDataModel.getInstance().settings.resolution.width, TPDataModel.getInstance().settings.resolution.height);
		}
		
		/**
		 * @event
		 * Ejecuta acciones una vez terminada la descarga del fichero SWF que contiene los componentes	
		 */
		public function onSWFMainLoaded(evt:Event):void 
		{
			trace("TPAppController->onSWFMainLoaded()");
			
			// Desactivando detectores de eventos
			if(TPDataModel.APP_RUN_IN_LOCAL) {
				bulkLoader.get(TPDataModel.MAIN_SWF_FILE).removeEventListener(Event.COMPLETE, onSWFMainLoaded);
				mainMovieClip = bulkLoader.getMovieClip(TPDataModel.MAIN_SWF_FILE);
			}
			else {
				bulkLoader.get(TPDataModel.URL_BASE_DOMAIN + TPDataModel.MAIN_SWF_FILE).removeEventListener(Event.COMPLETE, onSWFMainLoaded);
				mainMovieClip = bulkLoader.getMovieClip(TPDataModel.URL_BASE_DOMAIN + TPDataModel.MAIN_SWF_FILE);
			}
			
			// Recupero el swf cargado (MAIN.SWF)
			
			
		}
		
		/**
		 * @event
		 * Ejecuta acciones una vez terminada las descargas de ficheros externos	
		 */
		public function onBulkElementLoadedHandler(evt:Event):void 
		{
			trace("TPAppController->onBulkElementLoadedHandler()");
			
			// Desactivando detectores de eventos
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onBulkElementLoadedHandler);
			bulkLoader.removeEventListener(BulkLoader.PROGRESS, onBulkElementProgressHandler);	
			bulkLoader.removeEventListener(BulkLoader.ERROR, onErrorHandler);
			
			/*
			// Realizando animacion del objeto de loader visual
			Tweener.addTween(vetustaVisualLoader, {alpha:0, time:1, transition:"easeOutCubic", onComplete:removeLoader});	
			
			// Visualizando wizard
			wizardModalWindow.visible = true;
			*/
		}
		
		private function removeLoader():void {
			trace("Eliminando loader visual del escenario...");
			//StageManager.getInstance().removeObject(DataModel.COMPONENT_VISUAL_LOADER_HASH);					
		}
		
		
		/**
		 * @event
		 * Ejecuta acciones mientras se descargan los ficheros externos	
		 */
		public function onBulkElementProgressHandler(evt:BulkProgressEvent):void 
		{	
			/*
			var percent:uint = Math.floor((evt.totalPercentLoaded) * 100) ;
			vetustaVisualLoader.bar_mc.gotoAndStop(percent);
			if(evt.bytesLoaded == evt.bytesTotal)
				vetustaVisualLoader.bar_mc.gotoAndStop(100);
			*/
		}								
		
		/**
		 * @event
		 * Ejecuta acciones cuando se captura algun error en la descarga de ficheros externos
		 */
		public function onErrorHandler(evt:Event):void {	
			throw new Error(evt);
		}
	}
}