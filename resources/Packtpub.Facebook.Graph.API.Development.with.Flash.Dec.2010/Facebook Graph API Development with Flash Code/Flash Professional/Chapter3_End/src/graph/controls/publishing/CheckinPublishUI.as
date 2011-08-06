package graph.controls.publishing
{
	import com.adobe.serialization.json.JSON;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import graph.apis.base.PublishObject;
	
	public class CheckinPublishUI extends PublishUI
	{
		protected var _latitudeLabel:Label;
		protected var _latitudeInput:InputText;
		protected var _longitudeLabel:Label;
		protected var _longitudeInput:InputText;
		protected var _placeLabel:Label;
		protected var _placeInput:InputText;
		protected var _messageLabel:Label;
		protected var _messageInput:TextArea;
		
		public function CheckinPublishUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_ownerID:String = "", a_connectionType:String = "")
		{
			super(a_parent, a_xpos, a_ypos, a_ownerID, a_connectionType, "Create an Album");
			
			this.width = 240;
			this.height = 300;
			
			_latitudeLabel = new Label(this.content, PADDING, PADDING, "Latitude:");
			_latitudeInput = new InputText(this.content, PADDING, _latitudeLabel.y + _latitudeLabel.height);
			_latitudeInput.width = this.width - (2 * PADDING);
			
			_longitudeLabel = new Label(this.content, PADDING, _latitudeInput.y + _latitudeInput.height, "Longitude:");
			_longitudeInput = new InputText(this.content, PADDING, _longitudeLabel.y + _longitudeLabel.height);
			_longitudeInput.width = this.width - (2 * PADDING);
			
			_placeLabel = new Label(this.content, PADDING, _longitudeInput.y + _longitudeInput.height, "Place ID:");
			_placeInput = new InputText(this.content, PADDING, _placeLabel.y + _placeLabel.height);
			_placeInput.width = this.width - (2 * PADDING);
			
			_messageLabel = new Label(this.content, PADDING, _placeInput.y + _placeInput.height, "Message:");
			_messageInput = new TextArea(this.content, PADDING, _messageLabel.y + _messageLabel.height);
			_messageInput.width = this.width - (2 * PADDING);
			_messageInput.height *= 0.6;
			
			_postButton.x = _messageInput.x + _messageInput.width - _postButton.width;
			_postButton.y = _messageInput.y + PADDING + _messageInput.height;
			
			setHeightByPostButton();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			var coordinatesObj:Object = { latitude:_latitudeInput.text, longitude:_longitudeInput.text };
			var coordinates:String = JSON.encode(coordinatesObj);
			
			_publishObject.coordinates = coordinates;
			_publishObject.place = _placeInput.text;
			_publishObject.message = _messageInput.text;
			
			super.onClickPostButton(a_event);
		}
		
	}

}