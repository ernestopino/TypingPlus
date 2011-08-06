package graph.controls.publishing
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.FileReference;
	
	/**
	 * ...
	 * @author MichaelJW
	 */
	public class PhotoPublishUI extends PublishUI
	{
		protected var _messageLabel:Label;
		protected var _messageInput:TextArea;
		protected var _pictureLabel:Label;
		protected var _pictureButton:PushButton;
		protected var _fileRef:FileReference;
		
		public function PhotoPublishUI(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, ownerID:String = "", connectionType:String = "", title:String = "Publish")
		{
			super(parent, xpos, ypos, ownerID, connectionType, title);
			
			this.width = 240;
			this.height = 340;
			
			_messageLabel = new Label(this.content, PADDING, PADDING, "Message:");
			_messageInput = new TextArea(this.content, PADDING, _messageLabel.y + _messageLabel.height);
			_messageInput.width = this.width - (2 * PADDING);
			_messageInput.height *= 0.4;
			
			_pictureLabel = new Label(this.content, PADDING, _messageInput.y + _messageInput.height + PADDING, "Photo:");
			_pictureButton = new PushButton(this.content, _messageInput.x + _messageInput.width - _postButton.width, _pictureLabel.y, "Upload", onClickUploadPicture);
			
			_postButton.x = _messageInput.x + _messageInput.width - _postButton.width;
			_postButton.y = _pictureLabel.y + PADDING + _pictureLabel.height;
			_postButton.enabled = false;
			
			setHeightByPostButton();
			
			_fileRef = new FileReference();
			_fileRef.addEventListener(Event.SELECT, onSelectFile);
		}
		
		private function onSelectFile(a_event:Event):void
		{
			_postButton.enabled = true;
		}
		
		private function onClickUploadPicture(a_event:Event):void
		{
			_fileRef.browse();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.message = _messageInput.text;
			_publishObject.source = _fileRef;
			
			super.onClickPostButton(a_event);
		}
	}

}