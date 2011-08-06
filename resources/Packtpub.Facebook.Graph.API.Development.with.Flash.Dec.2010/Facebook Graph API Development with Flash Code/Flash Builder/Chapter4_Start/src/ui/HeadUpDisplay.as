package ui
{
	import com.bit101.components.PushButton;
	import events.DialogEvent;
	import events.GCEvent;
	import events.PublishUIEvent;
	import events.UIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import graph.controls.DialogBox;
	import graph.controls.publishing.AlbumPublishUI;
	import graph.controls.publishing.CheckinPublishUI;
	import graph.controls.publishing.CommentPublishUI;
	import graph.controls.publishing.EventPublishUI;
	import graph.controls.publishing.NotePublishUI;
	import graph.controls.publishing.PhotoPublishUI;
	import graph.controls.publishing.PublishingCapabilities;
	import graph.controls.publishing.PublishUI;
	import graph.controls.publishing.RichWallPostPublishUI;
	import graph.controls.publishing.WallPostPublishUI;
	import graph.controls.SearchUI;
	
	public class HeadUpDisplay extends Sprite
	{
		private var _zoomInButton:PushButton;
		private var _zoomOutButton:PushButton;
		private var _resetViewButton:PushButton;
		private var _showSearchUIButton:PushButton;
		private var _canShowSearchUI:Boolean = false;
		private var _searchUI:SearchUI;
		private var _searchUICallback:Function;
		private var _publishUI:PublishUI;
		private var _publishUIPos:Point = new Point(0, 0);
		
		public var uiHeight:Number;
		public var uiWidth:Number;
		
		public function HeadUpDisplay()
		{
			_searchUI = new SearchUI(this, 0, 25, "Search");
			_searchUI.visible = false;
			setUpButtons();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(a_event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			uiHeight = stage.stageHeight;
			uiWidth = stage.stageWidth;
			stage.addEventListener(Event.RESIZE, onStageResize);
			this.dispatchEvent(new UIEvent(UIEvent.RECENTER));
		}
		
		public function showPublishUI(a_ownerID:String = "", a_connectionType:String = "", a_publishingCapability:int = PublishingCapabilities.NONE):void
		{
			removePublishUI();
			
			if (a_publishingCapability == PublishingCapabilities.NONE)
			{
				return;
			}
			
			switch (a_connectionType)
			{
				case "feed":
					if (a_publishingCapability == PublishingCapabilities.BASIC)
					{
						_publishUI = new WallPostPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
					}
					else if (a_publishingCapability == PublishingCapabilities.COMPLETE)
					{
						_publishUI = new RichWallPostPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
					}
				break;
				case "photos":
					_publishUI = new PhotoPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
				case "comments":
					_publishUI = new CommentPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
				case "notes":
					_publishUI = new NotePublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
				case "albums":
					_publishUI = new AlbumPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
				case "events":
					_publishUI = new EventPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
				case "checkins":
					_publishUI = new CheckinPublishUI(this, _publishUIPos.x, _publishUIPos.y, a_ownerID, a_connectionType);
				break;
			}
			
			if (_publishUI)
			{
				_publishUI.addEventListener(PublishUIEvent.PUBLISH, onRequestPublish);
				_publishUI.addEventListener(GCEvent.CLOSE_WINDOW, onClickClosePublishUI);
				_publishUI.x = Math.max(0, (stage.stageWidth - _publishUI.width) / 2);
				_publishUI.y = Math.max(0, (stage.stageHeight - _publishUI.height) / 2);
			}
		}
		
		private function onClickClosePublishUI(a_event:GCEvent):void
		{
			removePublishUI();
		}
		
		private function removePublishUI():void
		{
			if (_publishUI)
			{
				if (_publishUI.parent == this)
				{
					removeChild(_publishUI);
				}
				_publishUI.removeEventListener(PublishUIEvent.PUBLISH, onRequestPublish);
				_publishUI = null;
			}
		}
		
		private function onRequestPublish(a_event:PublishUIEvent):void
		{
			a_event.stopImmediatePropagation();
			dispatchEvent(a_event.clone());
			removePublishUI();
		}
		
		private function onStageResize(a_event:Event):void
		{
			uiHeight = stage.stageHeight;
			uiWidth = stage.stageWidth;
		}
		
		private function setUpButtons():void
		{
			_zoomInButton = new PushButton(this, 0, 0, "Zoom In", zoomIn);
			_zoomInButton.width = 60;
			_zoomOutButton = new PushButton(this, _zoomInButton.x + _zoomInButton.width, 0, "Zoom Out", zoomOut);
			_zoomOutButton.width = 60;
			_resetViewButton = new PushButton(this, _zoomOutButton.x + _zoomOutButton.width, 0, "Reset View", resetView);
			_resetViewButton.width = 60;
			_showSearchUIButton = new PushButton(this, _resetViewButton.x + _resetViewButton.width, 0, "Search", showSearchUI);
			_showSearchUIButton.width = 60;
			_showSearchUIButton.visible = _canShowSearchUI;
		}
		
		private function showSearchUI(a_event:Event):void
		{
			_searchUI.visible = true;
			_searchUI.x = 0;
			_searchUI.y = 25;
		}
		
		public function showDialog(a_message:String = "", a_type:String = DialogEvent.DIALOG):void
		{
			var dialogBox:DialogBox = new DialogBox(a_message, this, 0.5 * (uiWidth - DialogBox.WINDOW_WIDTH), 0.5 * (uiHeight - DialogBox.WINDOW_HEIGHT));
			dialogBox.addEventListener(GCEvent.CLOSE_WINDOW, onCloseDialog, false, 0, true);
		}
		
		private function onCloseDialog(a_event:GCEvent):void
		{
			var dialogBox:DialogBox = a_event.currentTarget as DialogBox;
			removeChild(dialogBox);
		}
		
		private function resetView(a_event:Event):void
		{
			this.dispatchEvent(new UIEvent(UIEvent.RESET_VIEW));
		}
		
		private function zoomOut(a_event:Event):void
		{
			this.dispatchEvent(new UIEvent(UIEvent.ZOOM_OUT));
		}
		
		private function zoomIn(a_event:Event):void
		{
			this.dispatchEvent(new UIEvent(UIEvent.ZOOM_IN));
		}
		
		public function get canShowSearchUI():Boolean
		{
			return _canShowSearchUI;
		}
		
		public function set canShowSearchUI(a_value:Boolean):void
		{
			_canShowSearchUI = a_value;
			_showSearchUIButton.visible = a_value;
			_searchUI.visible = a_value;
		}
		
		public function set searchUICallback(a_value:Function):void
		{
			_searchUICallback = a_value;
			if (_searchUI)
			{
				_searchUI.setSearchCallback(_searchUICallback);
			}
		}
		
	}

}