package graph.controls.publishing
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import graph.apis.base.PublishObject;
	
	public class EventPublishUI extends PublishUI
	{
		protected var _nameLabel:Label;
		protected var _nameInput:InputText;
		protected var _startTimeLabel:Label;
		protected var _startTimeInput:InputText;
		protected var _endTimeLabel:Label;
		protected var _endTimeInput:InputText;
		
		public function EventPublishUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_ownerID:String = "", a_connectionType:String = "")
		{
			super(a_parent, a_xpos, a_ypos, a_ownerID, a_connectionType, "Create an Album");
			
			this.width = 240;
			this.height = 300;
			
			_nameLabel = new Label(this.content, PADDING, PADDING, "Name:");
			_nameInput = new InputText(this.content, PADDING, _nameLabel.y + _nameLabel.height);
			_nameInput.width = this.width - (2 * PADDING);
			
			_startTimeLabel = new Label(this.content, PADDING, _nameInput.y + _nameInput.height, "Start Time (ISO 8601):");
			_startTimeInput = new InputText(this.content, PADDING, _startTimeLabel.y + _startTimeLabel.height);
			_startTimeInput.width = this.width - (2 * PADDING);
			
			_endTimeLabel = new Label(this.content, PADDING, _startTimeInput.y + _startTimeInput.height, "End Time (ISO 8601):");
			_endTimeInput = new InputText(this.content, PADDING, _endTimeLabel.y + _endTimeLabel.height);
			_endTimeInput.width = this.width - (2 * PADDING);
			
			_postButton.x = _endTimeInput.x + _endTimeInput.width - _postButton.width;
			_postButton.y = _endTimeInput.y + PADDING + _endTimeInput.height;
			
			setHeightByPostButton();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.name = _nameInput.text;
			_publishObject.start_time = _startTimeInput.text;
			_publishObject.end_time = _endTimeInput.text;
			
			super.onClickPostButton(a_event);
		}
		
	}

}