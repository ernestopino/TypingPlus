package graph.controls.publishing
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import events.GCEvent;
	import events.PublishUIEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import graph.apis.base.PublishObject;
	
	public class PublishUI extends Window
	{
		protected static const PADDING:Number = 10;
		private static const WINDOW_WIDTH:Number = 240;
		private static const WINDOW_HEIGHT:Number = 240;
		
		protected var _postButton:PushButton;
		protected var _publishObject:PublishObject = new PublishObject();
		protected var _ownerID:String = "";
		protected var _connectionType:String = "";
		
		public function PublishUI(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, ownerID:String = "", connectionType:String = "", title:String = "Publish")
		{
			super(parent, xpos, ypos, title);
			this.hasCloseButton = true;
			this.width = WINDOW_WIDTH;
			_postButton = new PushButton(this.content, 0, 0, "Post", onClickPostButton);
			_ownerID = ownerID;
			_connectionType = connectionType;
		}
		
		protected function setHeightByPostButton():void
		{
			this.height = _postButton.y + _postButton.height + PADDING + this.titleBar.height;
		}
		
		protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.ownerID = _ownerID;
			_publishObject.connectionType = _connectionType;
			var publishEvent:PublishUIEvent = new PublishUIEvent(PublishUIEvent.PUBLISH);
			publishEvent.publishObject = _publishObject;
			dispatchEvent(publishEvent);
		}
		
		override protected function onClose(event:MouseEvent):void
		{
			super.onClose(event);
			dispatchEvent(new GCEvent(GCEvent.CLOSE_WINDOW));
		}
	}

}