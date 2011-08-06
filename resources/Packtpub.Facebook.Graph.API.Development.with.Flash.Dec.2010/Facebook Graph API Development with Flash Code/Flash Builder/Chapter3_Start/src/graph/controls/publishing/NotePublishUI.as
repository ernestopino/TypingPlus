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
	
	public class NotePublishUI extends PublishUI
	{
		protected var _subjectLabel:Label;
		protected var _subjectInput:InputText;
		protected var _messageLabel:Label;
		protected var _messageInput:TextArea;
		
		public function NotePublishUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_ownerID:String = "", a_connectionType:String = "")
		{
			super(a_parent, a_xpos, a_ypos, a_ownerID, a_connectionType, "Post a Note");
			
			this.width = 240;
			this.height = 300;
			
			_subjectLabel = new Label(this.content, PADDING, PADDING, "Subject:");
			_subjectInput = new InputText(this.content, PADDING, _subjectLabel.y + _subjectLabel.height);
			_subjectInput.width = this.width - (2 * PADDING);

			_messageLabel = new Label(this.content, PADDING, _subjectInput.y + _subjectInput.height, "Message (HTML accepted):");
			_messageInput = new TextArea(this.content, PADDING, _messageLabel.y + _messageLabel.height);
			_messageInput.width = this.width - (2 * PADDING);
			_messageInput.height *= 0.6;
			
			_postButton.x = _messageInput.x + _messageInput.width - _postButton.width;
			_postButton.y = _messageInput.y + PADDING + _messageInput.height;
			
			setHeightByPostButton();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.subject = _subjectInput.text;
			_publishObject.message = _messageInput.text;
			
			super.onClickPostButton(a_event);
		}
		
	}

}