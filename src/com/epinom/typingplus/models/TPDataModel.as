package com.epinom.typingplus.models
{
	import com.epinom.typingplus.vos.TPSettingsVO;
	
	import flash.display.MovieClip;
	import flash.display.Stage;

	public class TPDataModel
	{
		/**
		 * @property
		 * Constantes
		 */
		public static const APP_RUN_IN_LOCAL:Boolean = true;
		public static const FACEBOOK_APP_ID:String = "137660269655872";
		public static const FACEBOOK_APP_SECRET:String = "df8a3e04979a6bd70df42ad6b1a89612";
		public static const URL_BASE_DOMAIN:String = "http://www.epinom.com/apps/facebook/typingplus/";
		public static const XML_SETTINGS_FILE:String = "settings.xml";
		public static const APP_SWF_FILE:String = "app.swf";
		public static const MAIN_SWF_FILE:String = "main.swf";
		public static const APP_BULKLOADER_NAME:String = "appBulkloader";
		
		public static const TP_COMPONENT_LOGIN_HASH_ID:String = "com.epinom.typingplus.controllers.TPLogin";
		
		/**
		 * @property
		 * Instancia de la clase, se instancia una unica vez (Singleton)
		 */
		private static var _instance:TPDataModel = null;
		
		/**
		 * @property
		 * Controla la instanciacion de la clase
		 */
		private static var _allowInstantiation:Boolean; 
		
		/**
		 * @property
		 * Flashvars recibidas 
		 */
		private var _flashvars:Object;
		
		/**
		 * @property
		 * Loader visual
		 */
		private var _visualLoader:MovieClip;
		
		/**
		 * @property
		 * Referencia al escenario de la pelicula principal
		 */
		private var _stage:Stage;
		
		private var _settings:TPSettingsVO;
		private var _componentList:Array;
		
		public function TPDataModel()
		{
			if (!_allowInstantiation) {
				throw new Error("Error: Instanciación fallida: Use TPDataModel.getInstance() para crar nuevas instancias.");
			} else {				
				_flashvars = null;
				_settings = new TPSettingsVO();
				_componentList = new Array();
			}	
		}
		
		/**
		 * @method
		 * Devuelve la unica instancia de la clase DataModel
		 * 
		 * @return	instancia	Unica instancia de la clase DataModel 	
		 */
		public static function getInstance():TPDataModel 
		{
			if (_instance == null) 
			{
				_allowInstantiation = true;
				_instance = new TPDataModel();
				_allowInstantiation = false;
			}
			return _instance;
		}
		
		public function get visualLoader():MovieClip { return _visualLoader; }
		public function set visualLoader(value:MovieClip):void { _visualLoader = value; }
		
		/**
		 * @Getters and Setters
		 */
		public function get flashvars():Object { return _flashvars; }
		public function set flashvars(value:Object) { 
			_flashvars = value;
			trace("Flashvars recibidas: ", _flashvars);
		}
		
		/**
		 * @method
		 * Devuelve la referencia al escenario
		 * 
		 * @return	stage	Referencia al escenario
		 */
		public function get stage():Stage {
			return _stage;
		}
		
		/**
		 * @method
		 * Modifica la referencia al escenario
		 */
		public function set stage(value:Stage):void {
			_stage = value;
		}
		
		public function get settings():TPSettingsVO { return _settings; }
		public function set settings(value:TPSettingsVO):void { _settings = value; }
		
		public function get componentList():Array { return _componentList; }
		public function set componentList(value:Array):void { _componentList = value; }
	}
}