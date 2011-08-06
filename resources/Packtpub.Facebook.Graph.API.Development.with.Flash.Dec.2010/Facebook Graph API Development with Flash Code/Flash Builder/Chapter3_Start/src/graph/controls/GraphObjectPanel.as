package graph.controls
{
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import events.DialogEvent;
	import events.GraphObjectEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import graph.GraphObject;
	
	public class GraphObjectPanel extends Panel
	{
		private var _go:GraphObject;
		private var _textArea:TextArea;
		private var _pictureLoader:Loader;
		private var _showPopOutButton:Boolean = false;
		private var _popOutButton:PushButton;
		private var _showDeleteButton:Boolean = false;
		private var _deleteButton:PushButton;
		private var _deleteCallback:Function;
		
		public var ownerID:String = "";
		public var connectionType:String = "";
		
		public function GraphObjectPanel(a_parent:DisplayObjectContainer = null, a_x:Number = 0, a_y:Number = 0, a_graphObject:GraphObject = null, a_showPopOutButton:Boolean = false, a_showDeleteButton:Boolean = false)
		{
			super(a_parent, a_x, a_y);
			_showPopOutButton = a_showPopOutButton;
			_showDeleteButton = a_showDeleteButton;
			_popOutButton = new PushButton(this, 0, 0, "Pop Out", onClickPopOut);
			_popOutButton.visible = false;
			_deleteButton = new PushButton(this, 0, 0, "Delete", onClickDelete);
			_deleteButton.visible = false;
			if (a_graphObject)
			{
				renderGraphObject(a_graphObject);
			}
		}
		
		private function onClickDelete(a_event:Event):void
		{
			if (_deleteCallback != null)
			{
				if (_go.id)
				{
					_deleteCallback(_go.id);
				}
			}
		}
		
		public function renderGraphObject(a_graphObject:GraphObject):void
		{
			_go = a_graphObject;
			
			//remove old UI elements, in case re-rendering
			if (_textArea && _textArea.parent)
			{
				removeChild(_textArea);
			}
			if (_pictureLoader)
			{
				_pictureLoader.removeEventListener(Event.COMPLETE, onPictureDownloadComplete);
				if (_pictureLoader.parent)
				{
					removeChild(_pictureLoader);
				}
			}
			
			if (_go.type)	//might not exist, e.g. if using HTTP with no metadata=1 parameter
			{
				switch (_go.type)
				{
					case "user":
						if (_go.id)
						{
							loadPicture("https://graph.facebook.com/" + _go.id + "/picture");
						}
					break;
				}
			}
			else
			{
				
			}
			
			//create new elements
			_textArea = new TextArea(this);
			_textArea.width = this.width;
			_textArea.height = this.height;
			_textArea.html = true;
			
			for (var key:String in _go)
			{
				switch (key)
				{
					case "picture":
						loadPicture(_go[key]);
					break;
					case "link":
					case "website":
						_textArea.text += "<font size = '+3'>" + key + "</font>: " + "<a href = '" + _go[key] + "'>" + _go[key] + "</a>\n";
					break;
					case "rendererObject":
					case "graphObjectListRenderers":
						//these are properties specific to the Visualizer, so should be ignored
						//do nothing
					break;
					default:
						_textArea.text += "<font size = '+3'>" + key + "</font>: " + _go[key] + "\n";
					break;
				}
			}
			
			renderButtons();
		}
		
		private function onClickPopOut(a_event:MouseEvent):void
		{
			dispatchEvent(new GraphObjectEvent(GraphObjectEvent.POP_OUT, _go, true));
		}
		
		private function renderButtons():void
		{
			if (_showPopOutButton && _showDeleteButton)
			{
				_popOutButton.visible = true;
				_popOutButton.x = _textArea.x + _textArea.width - _popOutButton.width;
				_popOutButton.y = _textArea.y + _textArea.height - _popOutButton.height;
				_deleteButton.visible = true;
				_deleteButton.x = 0;
				_deleteButton.y = _popOutButton.y;
				_textArea.height = _deleteButton.y - _textArea.y;
			}
			else
			{
				if (_showPopOutButton)
				{
					_popOutButton.visible = true;
					_popOutButton.x = _textArea.x + _textArea.width - _popOutButton.width;
					_popOutButton.y = _textArea.y + _textArea.height - _popOutButton.height;
					_textArea.height = _popOutButton.y - _textArea.y;
				}
				if (_showDeleteButton)
				{
					_deleteButton.visible = true;
					_deleteButton.x = 0;
					_deleteButton.y = _textArea.y + _textArea.height - _deleteButton.height;
					_textArea.height = _deleteButton.y - _textArea.y;
				}
			}
		}
		
		private function loadPicture(a_url:String):void
		{
			_pictureLoader = new Loader();
			_pictureLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPictureDownloadComplete);
			_pictureLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onPictureDownloadHTTPStatusEvent);
			_pictureLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPictureDownloadIOError);
			var pictureRequest:URLRequest = new URLRequest(a_url);
			_pictureLoader.load(pictureRequest);
			
			//TODO: Could add a throbber here
		}
		
		private function onPictureDownloadIOError(a_event:IOErrorEvent):void
		{
			//stub
		}
		
		private function onPictureDownloadHTTPStatusEvent(a_event:HTTPStatusEvent):void
		{
			//stub
		}
		
		private function onPictureDownloadComplete(a_event:Event):void
		{
			this.addChild(_pictureLoader);
			_textArea.y = _pictureLoader.y + _pictureLoader.height;
			_textArea.height = this.height - _pictureLoader.height;
			renderButtons();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		override public function set height(a_value:Number):void
		{
			super.height = a_value;
			if (_textArea)
			{
				_textArea.height = a_value;
				renderButtons();
			}
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(a_value:Number):void
		{
			super.width = a_value;
			if (_textArea)
			{
				_textArea.width = a_value;
				renderButtons();
			}
		}
		
		public function get graphObject():GraphObject
		{
			return _go;
		}
		
		public function set showPopOutButton(a_value:Boolean):void
		{
			_showPopOutButton = a_value;
			_popOutButton.enabled = a_value;
		}
		
		public function get showDeleteButton():Boolean
		{
			return _showDeleteButton;
		}
		
		public function set showDeleteButton(a_value:Boolean):void
		{
			_showDeleteButton = a_value;
			renderButtons();
		}
		
		public function get deleteCallback():Function
		{
			return _deleteCallback;
		}
		
		public function set deleteCallback(a_value:Function):void
		{
			_deleteCallback = a_value;
		}
	}

}