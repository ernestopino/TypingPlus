package
{
	import controllers.CustomGraphContainerController;
	import controllers.GCController;
	import controllers.UIController;
	import events.DialogEvent;
	import events.PublishUIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import ui.GraphControlContainer;
	import ui.HeadUpDisplay;

	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite
	{
		private var _gcc:GraphControlContainer;
		private var _uic:UIController;
		private var _hud:HeadUpDisplay;
		private var _bg:Sprite;
		private var _gcController:GCController;
		
		public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			setUpUI();
			setUpGCC();
		}
		
		private function setUpUI():void
		{
			_bg = new Sprite();
			_gcc = new GraphControlContainer();
			_hud = new HeadUpDisplay();
			_uic = new UIController(_hud, _gcc, _bg);
			this.addChild(_bg);
			this.addChild(_gcc);
			this.addChild(_hud);
			
			this.addEventListener(DialogEvent.ERROR, onDialogEvent);
			this.addEventListener(DialogEvent.DIALOG, onDialogEvent);
			
			_gcc.addEventListener(PublishUIEvent.SHOW_UI, onRequestShowPublishUI);
			_hud.addEventListener(PublishUIEvent.PUBLISH, onRequestPublish);
		}
		
		private function onRequestPublish(a_event:PublishUIEvent):void
		{
			_gcController.publish(a_event.publishObject);
		}
		
		private function onRequestShowPublishUI(a_event:PublishUIEvent):void
		{
			_hud.showPublishUI(a_event.ownerID, a_event.connectionType, a_event.publishingCapability);
		}
		
		private function onDialogEvent(a_event:DialogEvent):void
		{
			_hud.showDialog(a_event.message, a_event.type);
		}
		
		private function setUpGCC():void
		{
			_gcController = new CustomGraphContainerController(_gcc);
			_gcController.setSearchUISettingCallback(setSearchUISetting);
			_hud.searchUICallback = _gcController.search;
		}
		
		private function setSearchUISetting(a_show:Boolean):void
		{
			_hud.canShowSearchUI = a_show;
		}
	}

}