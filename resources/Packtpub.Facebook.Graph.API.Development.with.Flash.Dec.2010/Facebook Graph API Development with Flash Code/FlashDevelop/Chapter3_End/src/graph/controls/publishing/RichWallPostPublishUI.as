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
	
	public class RichWallPostPublishUI extends PublishUI
	{
		protected static const PADDING:Number = 10;
		
		protected var _messageLabel:Label;
		protected var _messageInput:TextArea;
		protected var _pictureURLLabel:Label;
		protected var _pictureURLInput:InputText;
		protected var _linkURLLabel:Label;
		protected var _linkURLInput:InputText;
		protected var _nameLabel:Label;
		protected var _nameInput:InputText;
		protected var _captionLabel:Label;
		protected var _captionInput:InputText;
		protected var _descriptionLabel:Label;
		protected var _descriptionInput:InputText;
		
		public function RichWallPostPublishUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_ownerID:String = "", a_connectionType:String = "")
		{
			super(a_parent, a_xpos, a_ypos, a_ownerID, a_connectionType, "Post to Wall");
			
			this.width = 240;
			this.height = 300;
			
			_messageLabel = new Label(this.content, PADDING, PADDING, "Message:");
			_messageInput = new TextArea(this.content, PADDING, _messageLabel.y + _messageLabel.height);
			_messageInput.height *= 0.4;
			_messageInput.width = this.width - (2 * PADDING);
			
			_pictureURLLabel = new Label(this.content, PADDING, _messageInput.y + _messageInput.height, "Picture URL:");
			_pictureURLInput = new InputText(this.content, PADDING, _pictureURLLabel.y + _pictureURLLabel.height);
			_pictureURLInput.width = this.width - (2 * PADDING);
			_linkURLLabel = new Label(this.content, PADDING, _pictureURLInput.y + _pictureURLInput.height, "Link URL:");
			_linkURLInput = new InputText(this.content, PADDING, _linkURLLabel.y + _linkURLLabel.height);
			_linkURLInput.width = this.width - (2 * PADDING);
			_nameLabel = new Label(this.content, PADDING, _linkURLInput.y + _linkURLInput.height, "Name:");
			_nameInput = new InputText(this.content, PADDING, _nameLabel.y + _nameLabel.height);
			_nameInput.width = this.width - (2 * PADDING);
			_captionLabel = new Label(this.content, PADDING, _nameInput.y + _nameInput.height, "Caption:");
			_captionInput = new InputText(this.content, PADDING, _captionLabel.y + _captionLabel.height);
			_captionInput.width = this.width - (2 * PADDING);
			_descriptionLabel = new Label(this.content, PADDING, _captionInput.y + _captionInput.height, "Description:");
			_descriptionInput = new InputText(this.content, PADDING, _descriptionLabel.y + _descriptionLabel.height);
			_descriptionInput.width = this.width - (2 * PADDING);
			
			_postButton.x = _descriptionInput.x + _descriptionInput.width - _postButton.width;
			_postButton.y = _descriptionInput.y + PADDING + _descriptionInput.height;
			
			setHeightByPostButton();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.message = _messageInput.text;
			_publishObject.pictureURL = _pictureURLInput.text;
			_publishObject.linkURL = _linkURLInput.text;
			_publishObject.linkName = _nameInput.text;
			_publishObject.caption = _captionInput.text;
			_publishObject.description = _descriptionInput.text;
			super.onClickPostButton(a_event);
		}
	}

}