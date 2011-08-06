package controllers
{
	import events.UIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.GraphControlContainer;
	import ui.HeadUpDisplay;
	public class UIController
	{
		private var _hud:HeadUpDisplay;
		private var _gcc:GraphControlContainer;
		private var _bg:Sprite;
		
		public function UIController(a_headUpDisplay:HeadUpDisplay, a_graphControlContainer:GraphControlContainer, a_background:Sprite)
		{
			_hud = a_headUpDisplay;
			_gcc = a_graphControlContainer;
			_bg = a_background;
			
			_bg.graphics.beginFill(0xffffff);
			_bg.graphics.drawRect(0, 0, 100, 100);
			
			setUpEventListeners()
		}
		
		private function setUpEventListeners():void
		{
			_hud.addEventListener(UIEvent.ZOOM_IN, onRequestZoomIn);
			_hud.addEventListener(UIEvent.ZOOM_OUT, onRequestZoomOut);
			_hud.addEventListener(UIEvent.RESET_VIEW, onRequestResetView);
			_hud.addEventListener(UIEvent.RECENTER, onRequestRecenter);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownBackground);
			_bg.addEventListener(Event.ADDED_TO_STAGE, onBGAddedToStage);
		}
		
		private function onBGAddedToStage(a_event:Event):void
		{
			_bg.removeEventListener(Event.ADDED_TO_STAGE, onBGAddedToStage);
			_bg.stage.addEventListener(Event.RESIZE, onResizeStage);
			makeBackgroundCoverStage();
		}
		
		private function onResizeStage(a_event:Event):void
		{
			makeBackgroundCoverStage();
		}
		
		private function makeBackgroundCoverStage():void
		{
			_bg.graphics.clear();
			_bg.graphics.beginFill(0xffffff);
			_bg.graphics.drawRect(0, 0, _bg.stage.stageWidth, _bg.stage.stageHeight);
		}
		
		private function onMouseDownBackground(a_event:MouseEvent):void
		{
			_gcc.startDrag();
			_bg.addEventListener(MouseEvent.MOUSE_UP, onMouseUpBackgroundWhileDraggingGcc);
		}
		
		private function onMouseUpBackgroundWhileDraggingGcc(a_event:MouseEvent):void
		{
			_gcc.stopDrag();
		}
		
		private function onRequestRecenter(a_event:UIEvent):void
		{
			recenter();
		}
		
		/**
		 * Set (0,0) of GCC to be at center of SWF
		 */
		private function recenter():void
		{
			_gcc.x = _hud.uiWidth / 2;
			_gcc.y = _hud.uiHeight / 2;
		}
		
		private function onRequestResetView(a_event:UIEvent):void
		{
			_gcc.scaleY = _gcc.scaleX = 1;
			recenter();
		}
		
		private function onRequestZoomOut(a_event:UIEvent):void
		{
			_gcc.scaleX /= 1.1;
			_gcc.scaleY = _gcc.scaleX;
		}
		
		private function onRequestZoomIn(a_event:UIEvent):void
		{
			_gcc.scaleX *= 1.1;
			_gcc.scaleY = _gcc.scaleX;
		}
		
	}

}